import '../theme/tokens.dart';

class Issue {
  final String id;
  final SevKind sev;
  final int page;
  final String title;
  final String snippet;
  final String why;
  final String? action;

  const Issue({
    required this.id,
    required this.sev,
    required this.page,
    required this.title,
    required this.snippet,
    required this.why,
    this.action,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'sev': sev.name,
        'page': page,
        'title': title,
        'snippet': snippet,
        'why': why,
        if (action != null) 'action': action,
      };

  factory Issue.fromJson(Map<String, dynamic> j) => Issue(
        id: j['id'] as String,
        sev: SevKind.values.byName(j['sev'] as String),
        page: j['page'] as int,
        title: j['title'] as String,
        snippet: j['snippet'] as String,
        why: j['why'] as String,
        action: j['action'] as String?,
      );
}
