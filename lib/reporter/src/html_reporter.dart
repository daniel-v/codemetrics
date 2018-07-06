part of codemetrics.reporter;

class HtmlReporter implements AnalysisReporter {
  HtmlReporter(this.analysisRunner);

  Future<StringBuffer> getReport() async {
    Document template = await getHtmlTemplate();
    addReportData(template);
    return new StringBuffer('<!DOCTYPE html>\n' + template.documentElement.outerHtml);
  }

  Future<Document> getHtmlTemplate() async {
    var res = new Resource('package:codemetrics/reporter/assets/html_reporter_template.html');
    var template = await res.readAsString();
    return parse(template, sourceUrl: res.uri.toString());
  }

  void addReportData(Document template) {
    var scriptTag = template.createElement('script')
      ..text = '''
var analysisData = ${json.encode(analysisRunner.getResults())}
    ''';
    template.querySelector('head').append(scriptTag);
  }

  final AnalysisRunner analysisRunner;
}
