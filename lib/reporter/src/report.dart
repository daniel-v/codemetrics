class Report {
  final String name;
  final String path;
  final int complexity;
  final List<Report> details;

  Report({this.path, this.name, this.complexity, this.details});

  @override
  String toString() {
    return 'Report{name: $name, complexity: $complexity, details: $details, path; $path}';
  }
}
