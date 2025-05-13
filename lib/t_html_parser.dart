import 'dart:developer';

import 'package:html/dom.dart' as html;

export 't_html_extensions.dart';

class THtmlParser {
  static html.Document getHtmlDocument(String content) {
    return html.Document.html(content);
  }

  static html.Element? getHtmlElement(String content) {
    final dom = html.Document.html(content);
    return dom.body;
  }

  static String getQuerySelectorAttr(
    html.Element element,
    String selector,
    String attr,
  ) {
    var res = '';
    try {
      if (element.querySelector(selector) == null) return '';
      res = element.querySelector(selector)!.attributes[attr] ?? '';
    } catch (e) {
      log('$selector: ${e.toString()}');
    }
    return res.trim();
  }

  static String getQuerySelectorText(html.Element element, String selector) {
    var res = '';

    try {
      if (element.querySelector(selector) == null) return '';
      res = element.querySelector(selector)!.text;
    } catch (e) {
      log('$selector: ${e.toString()}');
    }
    return res.trim();
  }

  static String getQuerySelectorHtml(html.Element element, String selector) {
    var res = '';

    try {
      if (element.querySelector(selector) == null) return '';
      res = element.querySelector(selector)!.innerHtml;
    } catch (e) {
      log('$selector: ${e.toString()}');
    }
    return res.trim();
  }

  static String getNewLine(String html, {String replacer = '\n'}) {
    var res = '';

    res = html.replaceAll(
      RegExp(r'<[^/][^>]*>'),
      replacer,
    ); // opening tag remove
    res = res.replaceAll(RegExp(r'</[^>]+>'), replacer); // closing tag -> \n
    res = removeHtmlEntities(res);

    return res.trim();
  }

  static String cleanScriptTag(String html) {
    final cleaned = html.replaceAll(
      RegExp(r'<script[^>]*?>[\s\S]*?<\/script>', caseSensitive: false),
      '',
    );
    return cleaned;
  }

  static String cleanStyleTag(String html) {
    final cleaned = html.replaceAll(
      RegExp(r'<style[^>]*?>[\s\S]*?<\/style>', caseSensitive: false),
      '',
    );
    return cleaned;
  }

  static String removeHtmlEntities(String html) {
    return html.replaceAll(RegExp(r'&[^;\s]+;'), '');
  }
}
