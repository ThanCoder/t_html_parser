import 'package:t_html_parser/core/q_result/attributes.dart';
import 'package:t_html_parser/core/q_result/web_utils.dart';
import 'package:t_html_parser/t_html_parser.dart';

typedef QueryResultSingleQueryCallback = String Function(Element ele);

class QueryResultSingleQuery {
  final QueryResultSingleQueryCallback fn;
  const QueryResultSingleQuery(this.fn);

  String call(Element ele) => fn(ele);
}

class QueryResult {
  final Attribute attr;
  final String selector;
  final String cleanDomTags;
  final bool isCleanDomTags;
  final String Function(String attr, String html)? beforeDomQuery;
  final String Function(String attr, String? result)? afterQuery;
  QueryResult({
    required this.attr,
    required this.selector,
    this.isCleanDomTags = false,
    this.cleanDomTags = 'script,style,noscript',
    this.beforeDomQuery,
    this.afterQuery,
  });

  // String _getText(List<>)
  List<List<String>> getResultList(
    String html, {
    List<QueryResultSingleQuery> singleQueries = const [],
  }) {
    List<List<String>> list = [];
    // dom
    final dom = html.toHtmlDocument;
    if (isCleanDomTags && cleanDomTags.isNotEmpty) {
      dom.cleanDomTag(tagNames: cleanDomTags);
    }
    // query selector
    for (var ele in dom.querySelectorAll(selector)) {
      String? result;
      // custom query
      if (singleQueries.isNotEmpty) {
        List<String> resultList = [];
        for (var query in singleQueries) {
          final res = query.call(ele);
          resultList.add(res);
        }
        list.add(resultList);
      } else {
        // default query
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
      }

      if (result != null) {
        list.add([result]);
      }
    }

    return list;
  }

  String getResult(String html, {String def = '', int index = 0}) {
    // before query
    if (beforeDomQuery != null) {
      return beforeDomQuery?.call(attr.value, html) ?? def;
    }
    // dom
    final dom = html.toHtmlDocument;
    if (isCleanDomTags && cleanDomTags.isNotEmpty) {
      dom.cleanDomTag(tagNames: cleanDomTags);
    }
    // query selector
    final eles = dom.querySelectorAll(selector);
    if (eles.isEmpty || eles.length < index) return def;
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
      return afterQuery?.call(attr.value, result) ?? def;
    }
    return result ?? def;
  }
}
