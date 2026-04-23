import 'package:html/dom.dart' as html;
import 'package:html/dom.dart';
import 'package:t_html_parser/core/types/attributes.dart';

extension THtmlEleExtension on html.Element {
  ///
  /// ### Clean Tags
  ///
  void cleanEleTag({
    String tagNames = 'script,style,noscript, div[id^="pf-"]',
  }) {
    querySelectorAll(tagNames).forEach((e) => e.remove());
  }

  ///
  /// ### Get Attribute
  ///
  /// `selector.isEmpty` ? `current element` will choose
  ///
  String getQuerySelectorAttr({
    required String selector,
    required Attribute attr,
    String def = '',
  }) {
    if (selector.isEmpty) {
      final result = attributes[attr.value];
      return result ?? def;
    }
    final ele = querySelector(selector);
    if (ele == null) return def;
    final result = ele.attributes[attr.value];
    return result ?? def;
  }

  ///
  /// ### Get InnerHtml
  ///
  /// `selector.isEmpty` ? `current element` will choose
  ///
  String getQuerySelectorHtml({required String selector, String def = ''}) {
    if (selector.isEmpty) {
      return innerHtml;
    }
    final ele = querySelector(selector);
    if (ele == null) return def;
    return ele.innerHtml;
  }

  ///
  /// ### Get OuterHtml
  ///
  /// `selector.isEmpty` ? `current element` will choose
  ///
  String getQuerySelectorOuterHtml({
    required String selector,
    String def = '',
  }) {
    if (selector.isEmpty) {
      return outerHtml;
    }
    final ele = querySelector(selector);
    if (ele == null) return def;
    return ele.outerHtml;
  }

  ///
  /// ### Get Text
  ///
  /// `selector.isEmpty` ? `current element` will choose
  ///
  String getQuerySelectorText({required String selector, String def = ''}) {
    if (selector.isEmpty) {
      querySelectorAll('br').forEach((br) {
        br.replaceWith(Text('\n'));
      });
      querySelectorAll('p, div').forEach((el) {
        el.append(Text('\n'));
      });
      return text.trim();
    }
    // with selector
    final ele = querySelector(selector);
    if (ele == null) return def;
    ele.querySelectorAll('br').forEach((br) {
      br.replaceWith(Text('\n'));
    });
    ele.querySelectorAll('p, div').forEach((el) {
      el.append(Text('\n'));
    });
    return ele.text.trim();
  }
}
