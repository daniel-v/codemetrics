part of codemetrics.reporter;

abstract class AnalysisReporter {
  Future<StringBuffer> getReport();

  AnalysisRunner get analysisRunner;
}
