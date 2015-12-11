library codemetrics.cyclomatic.test;

import 'package:codemetrics/cyclomatic/cyclomatic.dart';
import 'package:test/test.dart';

const String _TEST_COMP_UNIT = '''
class A {
  void method() {
    if(a()) {
      print("a");
    } else {
      print("b");
    }
    if(b() || c()){
      print("c");
    } else {
      print("d");
    }
  }
}

main() {}
''';

main() {
  group('Control flow AST visitor', () {
    test('Complexity increment with known config option', () {
      var visitor = new ControlFlowVisitor(DEFAULT_CYCLOMATIC_CONFIG);
      expect(visitor.complexity, 1);
      expect((){ visitor.increaseComplexity('ifStatement'); }, returnsNormally);
      expect(visitor.complexity, 2);
    });

    test('Complexity increment with unknown config option', () {
      var visitor = new ControlFlowVisitor(DEFAULT_CYCLOMATIC_CONFIG);
      expect(() {
        visitor.increaseComplexity('unknownoption');
      }, throwsArgumentError);
      expect(visitor.complexity, 1);
    });
  });
}