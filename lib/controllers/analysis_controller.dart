import 'package:flutter/foundation.dart';

import '../models/history_entry.dart';
import '../models/issue.dart';
import '../services/gemini_service.dart';
import '../services/prefs.dart';

enum AnalysisStatus { idle, analyzing, done, error }

class AnalysisController extends ChangeNotifier {
  AnalysisStatus _status = AnalysisStatus.idle;
  Uint8List? _fileBytes;
  String _fileName = '';
  String _mimeType = '';
  String _modelId = '';
  String _summary = '';
  List<Issue> _issues = [];
  String _error = '';
  int _durationSecs = 0;

  AnalysisStatus get status => _status;
  String get fileName => _fileName;
  String get modelId => _modelId;
  String get summary => _summary;
  List<Issue> get issues => _issues;
  String get error => _error;
  int get durationSecs => _durationSecs;

  void setPending({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
    required String modelId,
  }) {
    _fileBytes = bytes;
    _fileName = fileName;
    _mimeType = mimeType;
    _modelId = modelId;
    _status = AnalysisStatus.idle;
    _summary = '';
    _issues = [];
    _error = '';
    notifyListeners();
  }

  Future<void> analyze(String apiKey) async {
    if (_fileBytes == null) return;
    _status = AnalysisStatus.analyzing;
    _error = '';
    notifyListeners();

    final start = DateTime.now();
    try {
      final result = await GeminiService.analyzeContract(
        apiKey: apiKey,
        modelId: _modelId,
        bytes: _fileBytes!,
        mimeType: _mimeType,
        fileName: _fileName,
      );
      _durationSecs = DateTime.now().difference(start).inSeconds;
      _summary = result.summary;
      _issues = result.issues;
      _status = AnalysisStatus.done;
      await Prefs.saveEntry(HistoryEntry(
        id: '${start.millisecondsSinceEpoch}',
        fileName: _fileName,
        analyzedAt: start,
        summary: _summary,
        issues: _issues,
        durationSecs: _durationSecs,
      ));
    } catch (e) {
      _error = e.toString();
      _status = AnalysisStatus.error;
    }
    notifyListeners();
  }

  void loadEntry(HistoryEntry entry) {
    _fileBytes = null;
    _fileName = entry.fileName;
    _mimeType = '';
    _modelId = '';
    _summary = entry.summary;
    _issues = entry.issues;
    _durationSecs = entry.durationSecs;
    _status = AnalysisStatus.done;
    _error = '';
    notifyListeners();
  }

  void reset() {
    _status = AnalysisStatus.idle;
    _fileBytes = null;
    _fileName = '';
    _mimeType = '';
    _modelId = '';
    _summary = '';
    _issues = [];
    _error = '';
    _durationSecs = 0;
    notifyListeners();
  }
}
