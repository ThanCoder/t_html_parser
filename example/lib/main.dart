import 'package:flutter/material.dart';
import 'package:t_html_parser/t_html_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _test() {
    // with extension
    final html = "<div><p>Hello</p></div>";
    final dom = html.toHtmlDocument;
    final ele = html.toHtmlElement; // null ?

    final attr = ele!.getQuerySelectorAttr(selector: '', attr: '');
    final htmlText = ele.getQuerySelectorHtml(selector: '', attr: '');
    final text = ele.getQuerySelectorText(selector: '');
    // with class
    final domC = THtmlParser.getHtmlDocument(html);
    final eleC = THtmlParser.getHtmlElement(html);

    final attrC = eleC!.getQuerySelectorAttr(selector: '', attr: '');
    final htmlTextC = eleC.getQuerySelectorHtml(selector: '', attr: '');
    final textC = eleC.getQuerySelectorText(selector: '');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Placeholder(),
        floatingActionButton: FloatingActionButton(onPressed: _test),
      ),
    );
  }
}
