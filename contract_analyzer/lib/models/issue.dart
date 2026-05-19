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
}
