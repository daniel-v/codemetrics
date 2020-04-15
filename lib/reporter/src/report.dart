class Report {
  final String name;
  final int complexity;
  final List<Report> details;

  Report({this.name, this.complexity, this.details});

  @override
  String toString() {
    return 'Report{name: $name, complexity: $complexity, details: $details}';
  }
}
