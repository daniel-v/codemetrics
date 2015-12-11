part of codemetrics.reporter;

class JsonReporter implements AnalysisReporter {

  JsonReporter(this.analysisRunner);

  StringBuffer getReport() {
    return new StringBuffer(JSON.encode(analysisRunner.getResults()));
  }

  final AnalysisRunner analysisRunner;
}
