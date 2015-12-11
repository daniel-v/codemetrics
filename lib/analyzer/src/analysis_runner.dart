part of codemetrics.analyzer;

abstract class AnalysisRunner {
  AnalysisRecorder get recorder;

  Analyzer get analyzer;

  Iterable<String> get filePathes;

  Iterable<Map<String, dynamic>> getResults();

  AnalysisRunner(AnalysisRecorder recorder, Analyzer analyzer,
      Iterable<String> filePathes);

  void run();
}
