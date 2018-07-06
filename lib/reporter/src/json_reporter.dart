part of codemetrics.reporter;

class JsonReporter implements AnalysisReporter {
  JsonReporter(this.analysisRunner);

  Future<StringBuffer> getReport() async {
    return new StringBuffer(json.encode(analysisRunner.getResults()));
  }

  final AnalysisRunner analysisRunner;
}
