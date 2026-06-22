import 'dart:convert';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

import '../models/issue.dart';
import '../theme/tokens.dart';

class GeminiModelInfo {
  final String id;
  final String displayName;
  const GeminiModelInfo({required this.id, required this.displayName});
}

class AnalysisResult {
  final String summary;
  final List<Issue> issues;
  const AnalysisResult({required this.summary, required this.issues});
}

class GeminiService {
  static const _systemPrompt =
      'You are an expert contract lawyer. Analyze the provided contract and identify potential issues, risks, and important clauses the user should know about.\n\n'
      'Classify each issue by severity:\n'
      '- "red": Serious risk or unfair clause requiring immediate attention or negotiation\n'
      '- "amber": Moderate concern or unusual clause worth discussing\n'
      '- "blue": Informational note or standard clause the user should be aware of\n\n'
      'Return ONLY a JSON object (no markdown, no explanation) with this structure:\n'
      '{\n'
      '  "summary": "1-2 sentence plain-English assessment of the contract",\n'
      '  "issues": [\n'
      '    {\n'
      '      "id": "1",\n'
      '      "severity": "red",\n'
      '      "page": 1,\n'
      '      "title": "Short descriptive title (max 6 words)",\n'
      '      "snippet": "Exact quoted text from contract (max 120 chars)",\n'
      '      "why": "Why this matters to the user (1-2 sentences)",\n'
      '      "action": "Specific recommended action (1 sentence)"\n'
      '    }\n'
      '  ]\n'
      '}\n\n'
      'Sort issues: red first, then amber, then blue. Include 5-15 issues total.';

  static const _maxRetries = 3;
  static const _retryDelay = Duration(seconds: 6);

  static bool _is503(Object e) {
    final msg = e.toString();
    return msg.contains('503') ||
        msg.contains('Service Unavailable') ||
        msg.contains('overloaded') ||
        msg.contains('UNAVAILABLE');
  }

  static Future<List<GeminiModelInfo>> fetchModels(String apiKey) async {
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey&pageSize=100',
    );

    Object? lastError;
    for (var attempt = 0; attempt < _maxRetries; attempt++) {
      if (attempt > 0) await Future.delayed(_retryDelay);
      try {
        final res = await http.get(uri);
        if (res.statusCode == 503) {
          lastError = Exception('HTTP 503: Service temporarily unavailable. Retrying…');
          continue;
        }
        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final rawModels = data['models'] as List? ?? [];
        return rawModels
            .where((m) {
              final methods = List<String>.from(
                  m['supportedGenerationMethods'] as List? ?? []);
              final name = m['name'] as String? ?? '';
              return methods.contains('generateContent') &&
                  name.contains('gemini') &&
                  !name.contains('embedding') &&
                  !name.contains('aqa');
            })
            .map((m) {
              final raw = m['name'] as String;
              return GeminiModelInfo(
                id: raw.replaceFirst('models/', ''),
                displayName: m['displayName'] as String? ?? raw,
              );
            })
            .toList();
      } catch (e) {
        if (_is503(e)) {
          lastError = e;
          continue;
        }
        rethrow;
      }
    }
    throw lastError ?? Exception('Failed after $_maxRetries attempts');
  }

  static Future<AnalysisResult> analyzeContract({
    required String apiKey,
    required String modelId,
    required Uint8List bytes,
    required String mimeType,
    required String fileName,
  }) async {
    final model = GenerativeModel(
      model: modelId,
      apiKey: apiKey,
      systemInstruction: Content.system(_systemPrompt),
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.1,
      ),
    );

    final Content content;
    if (mimeType == 'text/plain') {
      final text = utf8.decode(bytes, allowMalformed: true);
      content = Content.text('Contract document "$fileName":\n\n$text');
    } else {
      content = Content.multi([
        DataPart(mimeType, bytes),
        TextPart('Contract file: $fileName'),
      ]);
    }

    Object? lastError;
    for (var attempt = 0; attempt < _maxRetries; attempt++) {
      if (attempt > 0) await Future.delayed(_retryDelay);
      try {
        final response = await model.generateContent([content]);
        final responseText = response.text ?? '{}';
        final data = jsonDecode(responseText) as Map<String, dynamic>;

        final summary = data['summary'] as String? ?? 'Analysis complete.';
        final issuesRaw = data['issues'] as List? ?? [];

        final issues = issuesRaw.map<Issue>((raw) {
          final sev = switch (raw['severity'] as String? ?? 'blue') {
            'red' => SevKind.red,
            'amber' => SevKind.amber,
            _ => SevKind.blue,
          };
          return Issue(
            id: raw['id'] as String? ?? '0',
            sev: sev,
            page: (raw['page'] as num?)?.toInt() ?? 1,
            title: raw['title'] as String? ?? 'Issue',
            snippet: raw['snippet'] as String? ?? '',
            why: raw['why'] as String? ?? '',
            action: raw['action'] as String?,
          );
        }).toList();

        return AnalysisResult(summary: summary, issues: issues);
      } catch (e) {
        if (_is503(e)) {
          lastError = e;
          continue;
        }
        rethrow;
      }
    }
    throw lastError ?? Exception('Failed after $_maxRetries attempts');
  }
}
