import 'package:codemetrics/codemetrics.dart';
import 'package:glob/glob.dart';
import 'dart:convert';
import 'dart:io';

const List<String> IGNORED_PATH_PARTS = const [ '.pub', 'packages' ];

main(List<String> args) {
  
  var dartFiles = new Glob('**.dart').listSync(root: '/home/dvarga/Projects/easyling/pagetranslate/war/_el/dart/package/common/lib/src/workbench_util/', followLinks: false);
  dartFiles.removeWhere((FileSystemEntity entity) {
    if(entity is! File)
      return true;
    if(entity is File) {
      for(String ignoredPathPart in IGNORED_PATH_PARTS) {
        if(entity.path.contains(ignoredPathPart))
          return true;
      }
    }
    return false;
  });

  var dartFilePathes = dartFiles.map((FileSystemEntity entity) => entity.path).toList(growable: false);
//
//  Iterable<Source> dartSources = dartFilePathes.map((String path) {
//    return new FileBasedSource(new JavaFile(path));
//  }).toList();
//  AnalysisContextImpl analysisContext = new AnalysisContextImpl();
//  LibraryElementImpl libElement = new LibraryElementBuilder(analysisContext, new AnalysisErrorListener_NULL_LISTENER())
//      .buildLibrary(new Library(analysisContext, new AnalysisErrorListener_NULL_LISTENER(), dartSources.first));
//
//  TypeProviderImpl typeProvider = new TypeProviderImpl(libElement);
//  new ResolverVisitor(libElement, dartSources.first, null, new AnalysisErrorListener_NULL_LISTENER());

  var recorder = new CyclomaticAnalysisRecorder();

  var analyzer = new CyclomaticAnalyzer();

  CyclomaticAnalysisRunner runner = new CyclomaticAnalysisRunner(recorder, analyzer, dartFilePathes);
  runner.run();
  print(new HtmlReporter(runner).getReport());

//  print('${JSON.encode(runner.getResults())}');
}
