class Recent {
  final String id;
  final String name;
  final String when;
  final String? group;
  final int red;
  final int amber;
  final int blue;

  const Recent({
    required this.id,
    required this.name,
    required this.when,
    this.group,
    this.red = 0,
    this.amber = 0,
    this.blue = 0,
  });
}
