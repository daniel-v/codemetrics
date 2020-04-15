part of codemetrics.reporter;

class JsonReporter extends AnalysisReporter {
  JsonReporter(String output, String root) : super(output, root);

  @override
  Future<void> generateReport(final Iterable<Map<String, dynamic>> data) async {
    return StringBuffer(json.encode(data));
  }
}
