part of codemetrics.reporter;

class HtmlReporter extends AnalysisReporter {
  HtmlReporter(final String output, final String root) : super(output, root);

  Future<String> getHtmlTemplate() async {
    final assetDir = await _getAssetsDir();
    final f = File(p.join(assetDir.path, 'report_template_v2.html'));
    final html = f.readAsString();
    return html;
  }

  @override
  Future<void> generateReport(List<Map<String, dynamic>> data) async {
    final reports = transformData(data);
    reports.forEach((r) => print('${r.toString()}'));

    await _transferResource();

    final String template = await getHtmlTemplate();
    for (final d in data) {
      // TODO:
    }

    final File f = File(p.join(_outputDir.path, 'index.html'));
    await f.writeAsString(template);
  }

  Future<void> _transferResource() async {
    final Directory resourceDir = Directory(p.join(outputDir.path, 'resources'));
    await resourceDir.create();

    final assetsDir = await _getAssetsDir();
    final List<FileSystemEntity> entities = assetsDir.listSync();
    for (final FileSystemEntity e in entities) {
      if (e.path.endsWith('.css') || e.path.endsWith('.js')) {
        final File f = File(e.path);
        f.copy(p.join(resourceDir.path, p.basename(f.path)));
      }
    }
  }

  Future<Directory> _getAssetsDir() async {
    final Directory assetsDir = Directory('package:');
    final String root = assetsDir.absolute.path.split('package:')[0];
    return Directory(p.join(root, 'assets'));
  }
}
