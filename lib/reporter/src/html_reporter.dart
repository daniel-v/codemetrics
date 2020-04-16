part of codemetrics.reporter;

class HtmlReporter extends AnalysisReporter {
  static final String TABLE_BODY = '<!TABLE_BODY!>';
  static final String TABLE_FOOT = '<!TABLE_FOOT!>';
  static final String BREADCRUMB = '<!BREADCRUMB!>';

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

    String template = await getHtmlTemplate();
    final String tableBody = _body(reports);
    final String tableFoot = _foot(reports);
    final String breadcrumbs = _breadcrumb();

    // replace table tags
    template = template.replaceAll(TABLE_BODY, tableBody);
    template = template.replaceAll(TABLE_FOOT, tableFoot);
    template = template.replaceAll(BREADCRUMB, breadcrumbs);

    // create index.html
    final File f = File(p.join(_outputDir.path, 'index.html'));
    await f.writeAsString(template);
    // create sites
    await _createSites(reports);

    // TODO: analyze individual methods inside DART file
    // TODO: to give more info about the complexity analysis
  }

  Future<void> _createSites(final List<List<Report>> reports) async {
    final Directory sitesDir = Directory(p.join(outputDir.path, 'sites'));
    await sitesDir.create();

    for (final package in reports[0]) {
      String template = await getHtmlTemplate();

      final String tableBody = _body(reports, package.path);
      final String tableFoot = _foot(reports, package.path);
      final String breadcrumbs = _breadcrumb(package, true);

      // replace table tags
      template = template.replaceAll(TABLE_BODY, tableBody);
      template = template.replaceAll(TABLE_FOOT, tableFoot);
      template = template.replaceAll(BREADCRUMB, breadcrumbs);

      // create package site
      final File f = File(p.join(sitesDir.path, '${package.name}.html'));
      await f.writeAsString(template);
    }
  }

  String _breadcrumb([final Report report, final bool isPackage = false]) {
    String bc = '''
    <a class="el_report" href="${isPackage ? "../index.html" : "index.html"}">Codemetrics</a> 
    ''';
    if (isPackage && report != null) {
      bc += '''
      >
      <a class="el_package" href="${report.path}.html">${report.path}</a>
      ''';
    }
    return bc;
  }

  String _foot(final List<List<Report>> reports, [final String path]) {
    int cc = 0;
    for (final report in reports[1]) {
      if (path == null) {
        cc += report.complexity;
      } else if (report.path == path) {
        cc += report.complexity;
      }
    }
    return '''
  <tr>
    <td>Total</td>
    <td class="ctr2">$cc</td>
  </tr>
      ''';
    ;
  }

  String _body(final List<List<Report>> reports, [final String path]) {
    String body = '';
    if (path == null) {
      for (final report in reports[0]) {
        final id = reports[0].indexOf(report);
        body += '''
  <tr>
    <td id="a$id">
      <a class="el_package" href="sites/${report.path}.html">${report.name}</a>
    </td>
    <td id="b$id" class="ctr2">${report.complexity}</td>
  </tr>
      ''';
      }
    } else {
      for (final report in reports[1]) {
        if (report.path == path) {
          final absPath = p.join(root, report.path.replaceAll('.', p.separator), _baseName(report.name));

          final id = reports[1].indexOf(report);
          body += '''
  <tr>
    <td id="a$id">
      <a class="el_class" href="$absPath">${report.name}</a>
    </td>
    <td id="b$id" class="ctr2">${report.complexity}</td>
  </tr>
      ''';
        }
      }
    }
    return body;
  }

  Future<Directory> _getAssetsDir() async {
    final Directory assetsDir = Directory('package:');
    final String root = assetsDir.absolute.path.split('package:')[0];
    return Directory(p.join(root, 'assets'));
  }
}
