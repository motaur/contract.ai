import 'issue.dart';
import '../theme/tokens.dart';

class HistoryEntry {
  final String id;
  final String fileName;
  final DateTime analyzedAt;
  final String summary;
  final List<Issue> issues;
  final int durationSecs;

  HistoryEntry({
    required this.id,
    required this.fileName,
    required this.analyzedAt,
    required this.summary,
    required this.issues,
    required this.durationSecs,
  });

  int get red => issues.where((i) => i.sev == SevKind.red).length;
  int get amber => issues.where((i) => i.sev == SevKind.amber).length;
  int get blue => issues.where((i) => i.sev == SevKind.blue).length;

  String get when {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(analyzedAt.year, analyzedAt.month, analyzedAt.day);
    final diff = today.difference(d).inDays;
    if (diff <= 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '$diff days ago';
    return '${_month(analyzedAt.month)} ${analyzedAt.day}';
  }

  String get group {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(analyzedAt.year, analyzedAt.month, analyzedAt.day);
    final diff = today.difference(d).inDays;
    if (diff <= 0) return 'Today';
    if (diff < 7) return 'This week';
    if (analyzedAt.year == now.year && analyzedAt.month == now.month) {
      return 'Earlier in ${_month(analyzedAt.month)}';
    }
    if (analyzedAt.year == now.year) return _month(analyzedAt.month);
    return '${_month(analyzedAt.month)} ${analyzedAt.year}';
  }

  static String _month(int m) => const [
        '',
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ][m];

  Map<String, dynamic> toJson() => {
        'id': id,
        'fileName': fileName,
        'analyzedAt': analyzedAt.toIso8601String(),
        'summary': summary,
        'issues': issues.map((i) => i.toJson()).toList(),
        'durationSecs': durationSecs,
      };

  factory HistoryEntry.fromJson(Map<String, dynamic> j) => HistoryEntry(
        id: j['id'] as String,
        fileName: j['fileName'] as String,
        analyzedAt: DateTime.parse(j['analyzedAt'] as String),
        summary: j['summary'] as String,
        issues: (j['issues'] as List)
            .map((i) => Issue.fromJson(i as Map<String, dynamic>))
            .toList(),
        durationSecs: j['durationSecs'] as int,
      );
}
