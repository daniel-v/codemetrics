part of codemetrics.analyzer;

String _getQualifiedName(ScopedDeclaration dec) {
  Declaration declaration = dec.declaration;
  if (declaration is FunctionDeclaration) {
    return declaration.name.toString();
  } else if (declaration is MethodDeclaration) {
    return "${dec.enclosingClass.name}.${declaration.name}";
  }
  return null;
}

int _getCyclomaticComplexity(ControlFlowVisitor visitor) {
  return visitor.complexity;
}

class CyclomaticAnalysisRecorder extends Object implements AnalysisRecorder {
  Map<String, dynamic> _activeRecordGroup = null;

  bool get _hasStartedGroup => _activeRecordGroup != null;

  final List<Map<String, dynamic>> _records;

  CyclomaticAnalysisRecorder() : _records = new List<Map<String, dynamic>>();

  @override
  bool canRecord(String recordName) {
    // let's not limit what kind of records can be recorded
    return true;
  }

  @override
  List<Map<String, dynamic>> getRecords() {
    return _records;
  }

  @override
  void startRecordGroup(String groupName) {
    if (_hasStartedGroup) {
      throw new StateError(
          'Cannot start a group while another one is started. Use `endRecordGroup` to close the opened one.');
    }
    if (groupName == null) {
      throw new ArgumentError.notNull('groupName');
    }
    Map<String, dynamic> recordGroup = new Map<String, dynamic>();
    _records.add({groupName: recordGroup});
    _activeRecordGroup = recordGroup;
  }

  @override
  void endRecordGroup() {
    _activeRecordGroup = null;
  }

  @override
  void record(String recordName, value) {
    if (!_hasStartedGroup) {
      throw new StateError('No record groups have been started. Use `startRecordGroup` before `record`');
    }
    if (recordName == null) {
      throw new ArgumentError.notNull('recordName');
    }
    _activeRecordGroup[recordName] = value;
  }
}

class CyclomaticAnalyzer extends Object implements Analyzer<CyclomaticAnalysisRecorder> {
  CyclomaticAnalysisRecorder _recorder;

  @override
  void runAnalysis(String filePath, CyclomaticAnalysisRecorder recorder) {
    _recorder = recorder;
    var declarations = getDeclarations(filePath);
    if (declarations.length > 0) {
      recorder.startRecordGroup(filePath);
      recordDeclarationNamesFor(declarations);
      runComplexityAnalysisFor(declarations);
      recorder.endRecordGroup();
    }
  }

  BuiltList<ScopedDeclaration> getDeclarations(String filePath) {
    var compUnit = parseDartFile(filePath);
    var callableVisitor = new CallableAstVisitor();
    compUnit.visitChildren(callableVisitor);
    return callableVisitor.declarations;
  }

  void runComplexityAnalysisFor(BuiltList<ScopedDeclaration> declarations) {
    for (ScopedDeclaration dec in declarations) {
      var controlFlowVisitor = visitDeclaration(dec.declaration);
      int complexity = _getCyclomaticComplexity(controlFlowVisitor);
      recordDeclarationComplexity(dec, complexity);
    }
  }

  ControlFlowVisitor visitDeclaration(Declaration dec) {
    var controlFlowVisitor = new ControlFlowVisitor(DEFAULT_CYCLOMATIC_CONFIG);
    dec.visitChildren(controlFlowVisitor);
    return controlFlowVisitor;
  }

  void recordDeclarationNamesFor(Iterable<ScopedDeclaration> declarations) {
    _recorder.record(
        "callables", declarations.map((ScopedDeclaration dec) => _getQualifiedName(dec)).toList(growable: false));
  }

  void recordDeclarationComplexity(ScopedDeclaration dec, int complexity) {
    _recorder.record(_getQualifiedName(dec), complexity);
  }

  Map<String, dynamic> getDeclarationMetadata(ScopedDeclaration dec) {
    Map<String, dynamic> meta = {};
    meta["loc"] = dec.declaration.length;

    dec.declaration;
  }
}

class CyclomaticAnalysisRunner extends Object implements AnalysisRunner {
  CyclomaticAnalysisRunner(this.recorder, this.analyzer, this.filePathes);

  @override
  final AnalysisRecorder recorder;

  @override
  final CyclomaticAnalyzer analyzer;

  @override
  final Iterable<String> filePathes;

  @override
  void run() {
    for (String path in filePathes) {
      analyzer.runAnalysis(path, recorder);
    }
  }

  @override
  Iterable<Map<String, dynamic>> getResults() {
    return recorder.getRecords();
  }
}
