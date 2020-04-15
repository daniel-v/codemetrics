import 'dart:io';

import 'package:args/args.dart';
import 'package:codemetrics/codemetrics.dart';
import 'package:glob/glob.dart';

const List<String> IGNORED_PATH_PARTS = const ['.pub', 'packages'];

Future<void> main(List<String> args) async {
  var parser = new ArgParser();
  parser.addOption('output', defaultsTo: './report', help: 'Generated report output location');
  parser.addOption('max-value', defaultsTo: '85', help: 'Maximum percent of cyclomatic complexity value');
  parser.addOption('report-format', allowed: ['html', 'js'], defaultsTo: 'html', help: 'The format of the output of the analysis');
  parser.addOption('analysis-root', defaultsTo: './', help: 'Root path from which all dart files will be analyzed');
  var arguments = parser.parse(args);

  var dartFiles = new Glob('**.dart').listSync(root: arguments['analysis-root'], followLinks: false);
  dartFiles.removeWhere((FileSystemEntity entity) {
    if (entity is! File) return true;
    if (entity is File) {
      for (String ignoredPathPart in IGNORED_PATH_PARTS) {
        if (entity.path.contains(ignoredPathPart)) return true;
      }
    }
    return false;
  });

  var dartFilePaths = dartFiles.map((FileSystemEntity entity) => entity.path).toList(growable: false);
  var recorder = new CyclomaticAnalysisRecorder();
  var analyzer = new CyclomaticAnalyzer();

  CyclomaticAnalysisRunner runner = new CyclomaticAnalysisRunner(recorder, analyzer, dartFilePaths);
  runner.run();
  AnalysisReporter reporter;
  switch (arguments['report-format']) {
    case 'html':
      reporter = new HtmlReporter(arguments['output'], arguments['analysis-root']);
      break;
    case 'js':
      reporter = new JsonReporter(arguments['output'], arguments['analysis-root']);
      break;
    default:
      throw new ArgumentError.value(arguments['report-format'], 'report-format');
  }
  await reporter.generateReport(runner.getResults());
}
