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

  List<List<Report>> transformData(List<Map<String, dynamic>> data) {
    final reports = <List<Report>>[<Report>[], <Report>[]].toList(growable: false);
    if (data != null) {
      final paths = <String>[];
      for (final d in data) {
        final path = d.keys.toList(growable: false)[0].replaceFirst('$root${p.separator}', "").replaceAll(p.separator, '.');
        paths.add(path);
      }
      paths.sort();

      for (final path in paths) {
        final pt = path.replaceAll('.${_baseName(path)}', "");
        if (!_reportExists(reports[0], pt)) {
          reports[0].add(Report(path: pt, name: pt, complexity: _getComplexity(data, pt)));
        }
        reports[1].add(Report(path: pt, name: path, complexity: _getComplexity(data, path)));
      }
      print(reports);
    }
    return reports;
  }

  bool _reportExists(final List<Report> reports, final String path) {
    for (final r in reports) {
      if (r.path == path) {
        return true;
      }
    }
    return false;
  }

  int _getComplexity(final List<Map<String, dynamic>> data, [final String name]) {
    int value = 0;
    if (name == null) {
      for (final d in data) {
        final values = Map<String, dynamic>.from(d.values.toList(growable: false)[0]);
        for (final callable in values['callables']) {
          value += values[callable];
        }
      }
    } else {
      for (final d in data) {
        final n = d.keys.toList(growable: false)[0].replaceAll(p.separator, '.');
        if (n.contains(name)) {
          final values = Map<String, dynamic>.from(d.values.toList(growable: false)[0]);
          for (final callable in values['callables']) {
            value += values[callable];
          }
        }
      }
    }
    return value;
  }

  String _baseName(final String path) {
    final tokens = path.split('.');
    if (tokens.length < 2) {
      return '';
    }
    return '${tokens[tokens.length - 2]}.${tokens[tokens.length - 1]}';
  }
}
