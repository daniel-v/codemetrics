part of codemetrics.cyclomatic;

/**
 * Available options in CyclomaticConfig
 */
const List<String> CYCLOMATIC_CONFIG_OPTIONS = const [
  'assertStatement',
  'blockFunctionBody',
  'catchClause',
  'conditionalExpression',
  'forEachStatement',
  'forStatement',
  'ifStatement',
  'switchDefault',
  'switchCase',
  'whileStatement',
  'yieldStatement'
];

/**
 * Configuration for Cyclomatic Complexity calculation
 */
class CyclomaticConfig {
  final BuiltMap<String, int> addedComplexityByControlFlowType;

  int get assertStatement =>
      addedComplexityByControlFlowType['assertStatement'];

  int get blockFunctionBody =>
      addedComplexityByControlFlowType['blockFunctionBody'];

  int get catchClause => addedComplexityByControlFlowType['catchClause'];

  int get conditionalExpression =>
      addedComplexityByControlFlowType['conditionalExpression'];

  int get forEachStatement =>
      addedComplexityByControlFlowType['forEachStatement'];

  int get forStatement => addedComplexityByControlFlowType['forStatement'];

  int get ifStatement => addedComplexityByControlFlowType['ifStatement'];

  int get switchDefault => addedComplexityByControlFlowType['switchDefault'];

  int get switchCase => addedComplexityByControlFlowType['switchCase'];

  int get whileStatement => addedComplexityByControlFlowType['whileStatement'];

  int get yieldStatement => addedComplexityByControlFlowType['yieldStatement'];

  CyclomaticConfig._(this.addedComplexityByControlFlowType);

  factory CyclomaticConfig._fromBuilder(CyclomaticConfigBuilder builder) {
    Map m = {
      'assertStatement': builder._useAssertStatement ? 1 : 0,
      'blockFunctionBody': builder._useBlockFunctionBody ? 1 : 0,
      'catchClause': builder._useCatchClause ? 1 : 0,
      'conditionalExpression': builder._useConditionalExpression ? 1 : 0,
      'forEachStatement': builder._useForEachStatement ? 1 : 0,
      'forStatement': builder._useForStatement ? 1 : 0,
      'ifStatement': builder._useIfStatement ? 1 : 0,
      'switchDefault': builder._useSwitchDefault ? 1 : 0,
      'switchCase': builder._useSwitchCase ? 1 : 0,
      'whileStatement': builder._useWhileStatement ? 1 : 0,
      'yieldStatement': builder._useYieldStatement ? 1 : 0
    };
    return new CyclomaticConfig._(new MapBuilder<String, int>(m).build());
  }

  static CyclomaticConfigBuilder getBuilder() {
    return new CyclomaticConfigBuilder();
  }
}

class CyclomaticConfigBuilder {
  bool _useAssertStatement = false;
  bool _useBlockFunctionBody = false;
  bool _useCatchClause = false;
  bool _useConditionalExpression = false;
  bool _useForEachStatement = false;
  bool _useForStatement = false;
  bool _useIfStatement = false;
  bool _useSwitchDefault = false;
  bool _useSwitchCase = false;
  bool _useWhileStatement = false;
  bool _useYieldStatement = false;

  void useAssertStatement() {
    _useAssertStatement = true;
  }

  void useBlockFunctionBody() {
    _useBlockFunctionBody = true;
  }

  void useCatchClause() {
    _useCatchClause = true;
  }

  void useConditionalExpression() {
    _useConditionalExpression = true;
  }

  void useForEachStatement() {
    _useForEachStatement = true;
  }

  void useForStatement() {
    _useForStatement = true;
  }

  void useIfStatement() {
    _useIfStatement = true;
  }

  void useSwitchDefault() {
    _useSwitchDefault = true;
  }

  void useSwitchCase() {
    _useSwitchCase = true;
  }

  void useWhileStatement() {
    _useWhileStatement = true;
  }

  void useYieldStatement() {
    _useYieldStatement = true;
  }

  CyclomaticConfig build() {
    return new CyclomaticConfig._fromBuilder(this);
  }
}

/**
 * Configuration for Cyclomatic Complexity analysis that is very strict
 * and increases method complexity for _every_ known control flow statement
 *
 * See [CYCLOMATIC_CONFIG_OPTIONS] for a full list of statements that increase
 * complexity.
 */
final CyclomaticConfig DEFAULT_CYCLOMATIC_CONFIG = () {
  CyclomaticConfigBuilder builder = CyclomaticConfig.getBuilder()
    ..useAssertStatement()
    ..useBlockFunctionBody()
    ..useCatchClause()
    ..useConditionalExpression()
    ..useForEachStatement()
    ..useForStatement()
    ..useIfStatement()
    ..useSwitchDefault()
    ..useSwitchCase()
    ..useWhileStatement()
    ..useYieldStatement();
  return builder.build();
}();
