import 'package:t_html_parser/core/types/attributes.dart';
import 'package:t_html_parser/core/q_result/web_utils.dart';
import 'package:t_html_parser/t_html_parser.dart';

// typedef QueryResultSingleQueryCallback = String Function(Element ele);

class QueryResultSingleQuery {
  final String Function(Element ele) fn;
  const QueryResultSingleQuery(this.fn);

  String call(Element ele) => fn(ele);
}

class QueryResult {
  final Attribute attr;
  final String selector;
  final String cleanDomTags;
  final bool isCleanDomTags;
  QueryResult({
    required this.attr,
    required this.selector,
    this.isCleanDomTags = false,
    this.cleanDomTags = 'script,style,noscript, div[id^="pf-"]',
  });

  ///
  /// ### Fetch Multiple
  ///
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
          result = ele.getQuerySelectorText(selector: '');
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

  ///
  /// ### Fetch Single Text
  ///
  String getResult(String html, {String def = '', int index = 0}) {
    // dom
    final dom = html.toHtmlDocument;
    // clean
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
      result = ele.getQuerySelectorText(selector: '');
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
    return result ?? def;
  }

  ///
  /// ### Fetch Single Text
  ///
  /// `selector.isEmpty ? will query current element`
  ///
  String getResultFromElement(
    Element element, {
    String def = '',
    int index = 0,
  }) {
    // query selector
    final eles = element.querySelectorAll(selector);
    if (eles.isEmpty || eles.length < index) return def;
    final ele = eles[index];
    String? result;
    // print(ele.attributes);
    if (attr.value == 'text') {
      result = ele.getQuerySelectorText(selector: '');
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
    return result ?? def;
  }
}
