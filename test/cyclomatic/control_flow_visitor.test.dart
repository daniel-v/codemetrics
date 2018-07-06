library codemetrics.cyclomatic.test;

import 'package:codemetrics/cyclomatic/cyclomatic.dart';
import 'package:test/test.dart';

main() {
  group('Control flow AST visitor', () {
    test('Complexity increment with known config option', () {
      var visitor = new ControlFlowVisitor(DEFAULT_CYCLOMATIC_CONFIG);
      expect(visitor.complexity, 1);
      expect(() {
        visitor.increaseComplexity('ifStatement');
      }, returnsNormally);
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
