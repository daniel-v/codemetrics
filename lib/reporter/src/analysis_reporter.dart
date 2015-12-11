part of codemetrics.reporter;

abstract class AnalysisReporter {
  StringBuffer getReport();

  AnalysisRunner get analysisRunner;
}
