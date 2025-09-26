import 'package:html/dom.dart' as html;

import '../t_html_parser.dart';

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

  String cleanHtmlTag() {
    // remove tag
    var res = replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
    res = res.replaceAll(
      RegExp(r'</?(p|div|h[1-6])[^>]*>', caseSensitive: false),
      '\n',
    );
    res = res.replaceAll(RegExp(r'<[^>]+>'), '');
    res = res.replaceAll(RegExp(r'\n\s*\n+'), '\n\n');
    // space အမျိုးအစားများ
    res = res.replaceAll("&nbsp;", " ");
    res = res.replaceAll("&ensp;", " "); // U+2002 en space
    res = res.replaceAll("&emsp;", " "); // U+2003 em space
    res = res.replaceAll("&thinsp;", " "); // U+2009 thin space

    // အခြားသင်္ကေတများ
    res = res.replaceAll("&lt;", "<");
    res = res.replaceAll("&gt;", ">");
    res = res.replaceAll("&amp;", "&");
    res = res.replaceAll("&quot;", "\"");
    res = res.replaceAll("&apos;", "'");
    return res;
  }
}

extension HtmlDomExtension on html.Document {
  void cleanDomTag({String tagNames = 'script,style,noscript'}) {
    querySelectorAll(tagNames).forEach((e) => e.remove());
  }
}

// ele
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
