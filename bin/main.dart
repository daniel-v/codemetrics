import 'package:codemetrics/codemetrics.dart';
import 'package:glob/glob.dart';
import 'dart:io';
import 'package:args/args.dart';

const List<String> IGNORED_PATH_PARTS = const [ '.pub', 'packages'];

main(List<String> args) {
  var parser = new ArgParser();
  parser.addOption('report-format', allowed: ['html', 'js'],
      defaultsTo: 'js', help: 'The format of the output of the analysis');
  parser.addOption('analysis-root',
      defaultsTo: './', help: 'Root path from which all dart files will be analyzed');
  var arguments = parser.parse(args);

  var dartFiles = new Glob('**.dart').listSync(
      root: arguments['analysis-root'],
      followLinks: false);
  dartFiles.removeWhere((FileSystemEntity entity) {
    if (entity is! File)
      return true;
    if (entity is File) {
      for (String ignoredPathPart in IGNORED_PATH_PARTS) {
        if (entity.path.contains(ignoredPathPart))
          return true;
      }
    }
    return false;
  });

  var dartFilePathes = dartFiles.map((FileSystemEntity entity) => entity.path).toList(growable: false);
  var recorder = new CyclomaticAnalysisRecorder();
  var analyzer = new CyclomaticAnalyzer();

  CyclomaticAnalysisRunner runner = new CyclomaticAnalysisRunner(recorder, analyzer, dartFilePathes);
  runner.run();
  AnalysisReporter reporter;
  switch(arguments['report-format']){
    case 'html':
      reporter = new HtmlReporter(runner);
      break;
    case 'js':
      reporter = new JsonReporter(runner);
      break;
    default:
      throw new ArgumentError.value(arguments['report-format'], 'report-format');
  }
  stdout.write(reporter.getReport());
}
