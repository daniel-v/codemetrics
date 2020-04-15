part of codemetrics.reporter;

abstract class AnalysisReporter {
  Directory get outputDir => _outputDir;

  String get root => _root;

  Directory _outputDir;

  String _root;

  AnalysisReporter(final String output, final String root) {
    final Directory dReport = Directory(output);
    if (dReport.existsSync()) {
      dReport.deleteSync(recursive: true);
    }
    dReport.createSync(recursive: true);
    _outputDir = dReport;
    _root = root;
  }

  Future<void> generateReport(List<Map<String, dynamic>> data);

  List<Report> transformData(List<Map<String, dynamic>> data) {
    final reports = <String,Report>{};
    if (data != null) {
      for (final d in data) {
        for (final k in d.keys) {
          final tokens = k.replaceFirst(root, "").split(p.separator);
          for (final token in tokens) {
            // TODO
          }
          print(tokens);
//          reports[token] = (Report(name: k.replaceFirst(root, "")));
        }
      }
    }
    return reports.values.toList(growable: false);
  }
}
