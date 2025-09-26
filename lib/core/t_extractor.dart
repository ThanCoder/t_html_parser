import 'package:t_html_parser/t_html_parser.dart';

class TExtractor {
  final Map<String, TSelectorRules> rules;
  TExtractor({required this.rules});

  Map<String, String?> extract(String html, {bool isCleanHtmlTag = true}) {
    final result = <String, String?>{};
    // clean script
    final ele = html.toHtmlElement;
    if (ele == null) return result;

    if (isCleanHtmlTag) {
      ele.querySelectorAll('script,style,noscript').forEach((e) => e.remove());
    }

    rules.forEach((key, val) {
      if (val.attribute == null) {
        // is text
        final res = ele.getQuerySelectorHtml(selector: val.selector);
        // text မှာဆိုရင် ထပ်ပြီး CLEAN HTML TAG
        result[key] = isCleanHtmlTag ? cleanHtmlTag(res) : res;
      } else {
        // is attr
        final res = ele.getQuerySelectorAttr(
          selector: val.selector,
          attr: val.attribute!,
        );
        result[key] = res;
      }
    });
    return result;
  }

  static String cleanHtmlTag(String htmlStr) {
    // remove tag
    var res = htmlStr.replaceAll(
      RegExp(r'<br\s*/?>', caseSensitive: false),
      '\n',
    );
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
