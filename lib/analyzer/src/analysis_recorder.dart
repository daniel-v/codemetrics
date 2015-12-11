part of codemetrics.analyzer;

abstract class AnalysisRecorder {

  void startRecordGroup(String groupName);

  void endRecordGroup();

  void record(String recordName, dynamic value);

  bool canRecord(String recordName);

  Iterable<Map<String, dynamic>> getRecords();
}