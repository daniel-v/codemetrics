part of codemetrics.analyzer;

abstract class Analyzer<T extends AnalysisRecorder> {
  void runAnalysis(String filePath, T recorder);
}
