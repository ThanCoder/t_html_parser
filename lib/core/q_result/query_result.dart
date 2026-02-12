// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:t_html_parser/core/index.dart';
import 'package:t_html_parser/core/q_result/attributes.dart';
import 'package:t_html_parser/core/q_result/web_utils.dart';

class QueryResult {
  final int index;
  final Attribute attr;
  final String selector;
  final String cleanDomTags;
  final bool isCleanDomTags;
  final String? Function(String attr, String html)? beforeDomQuery;
  final String? Function(String attr, String? result)? afterQuery;
  QueryResult({
    required this.index,
    required this.attr,
    required this.selector,
    this.isCleanDomTags = false,
    this.cleanDomTags = 'script,style,noscript',
    this.beforeDomQuery,
    this.afterQuery,
  });

  // String _getText(List<>)

  String? getResult(String html) {
    // before query
    if (beforeDomQuery != null) {
      return beforeDomQuery?.call(attr.value, html);
    }
    // dom
    final dom = html.toHtmlDocument;
    if (isCleanDomTags && cleanDomTags.isNotEmpty) {
      dom.cleanDomTag(tagNames: cleanDomTags);
    }
    // query selector
    final eles = dom.querySelectorAll(selector);
    if (eles.isEmpty || eles.length < index) return null;
    final ele = eles[index];
    String? result;
    // print(ele.attributes);
    if (attr.value == 'text') {
      result = ele.text.trim();
    } else if (attr.value == 'textContent') {
      result = ele.textContent;
    } else if (attr.value == 'html') {
      result = ele.innerHtml.trim();
    } else if (attr.value == 'outerHtml') {
      result = ele.outerHtml.trim();
    } else {
      // attribute
      result = ele.attributes[attr.value];
    }

    // after query
    if (afterQuery != null) {
      return afterQuery?.call(attr.value, result);
    }
    return result;
  }
}
