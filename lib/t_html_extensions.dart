import 'package:html/dom.dart' as html;

import 't_html_parser.dart';

extension HtmlFromStringExtension on String {
  html.Document get toHtmlDocument {
    return THtmlParser.getHtmlDocument(this);
  }

  html.Element? get toHtmlElement {
    return THtmlParser.getHtmlElement(this);
  }

  String get cleanScriptTag {
    return THtmlParser.cleanScriptTag(this);
  }

  String get cleanStyleTag {
    return THtmlParser.cleanStyleTag(this);
  }

  String getNewLine({String replacer = '\n'}) {
    return THtmlParser.getNewLine(this, replacer: replacer);
  }
}

extension HtmlDomExtension on html.Document {
  void cleanDomTag({String tagNames = 'script,style,noscript'}) {
    querySelectorAll(tagNames).forEach((e) => e.remove());
  }
}

extension HtmlEleExtension on html.Element {
  String getQuerySelectorAttr({
    required String selector,
    required String attr,
  }) {
    return THtmlParser.getQuerySelectorAttr(this, selector, attr);
  }

  void cleanEleTag({String tagNames = 'script,style,noscript'}) {
    querySelectorAll(tagNames).forEach((e) => e.remove());
  }

  String getQuerySelectorHtml({required String selector}) {
    return THtmlParser.getQuerySelectorHtml(this, selector);
  }

  String getQuerySelectorText({required String selector}) {
    return THtmlParser.getQuerySelectorText(this, selector);
  }
}
