import 'package:t_html_parser/core/index.dart';

void main() {
  final html = '<h1>hello</h1>';

  final dom = html.toHtmlDocument;

  final ele = dom.body!;
  final query = FQuery(selector: 'h1',);
  print(query.getResult(ele));
}
