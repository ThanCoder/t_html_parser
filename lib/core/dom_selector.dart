import 'package:t_html_parser/core/extensions/t_html_string_extensions.dart';
import 'package:t_html_parser/t_html_parser.dart';

class DomSingleQuery {
  final String Function(Element ele) fn;
  const DomSingleQuery(this.fn);

  String call(Element ele) => fn(ele);
}

class DomSelector {
  static List<String> getResult(
    String html, {
    bool isCleanDomTags = false,
    String cleanDomTags = 'script,style,noscript',
    List<DomSingleQuery> queries = const [],
  }) {
    List<String> list = [];
    final dom = html.toHtmlDocument;
    if (isCleanDomTags && cleanDomTags.isNotEmpty) {
      dom.cleanDomTag(tagNames: cleanDomTags);
    }
    // query selector
    for (var query in queries) {
      final res = query.call(dom.body!);
      list.add(res);
    }
    return list;
  }

  static List<List<String>> getResultList(
    String html, {
    required String selectorAll,
    bool isCleanDomTags = false,
    String cleanDomTags = 'script,style,noscript',
    List<DomSingleQuery> queries = const [],
  }) {
    List<List<String>> list = [];
    final dom = html.toHtmlDocument;
    if (isCleanDomTags && cleanDomTags.isNotEmpty) {
      dom.cleanDomTag(tagNames: cleanDomTags);
    }
    // query selector
    for (var ele in dom.querySelectorAll(selectorAll)) {
      List<String> resultList = [];
      for (var query in queries) {
        final res = query.call(ele);
        resultList.add(res);
      }
      list.add(resultList);
    }
    return list;
  }
}
