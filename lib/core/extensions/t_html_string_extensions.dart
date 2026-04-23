import 'package:html/dom.dart' as html;
import 'package:html/parser.dart';

extension THtmlStringExtensions on String {
  html.Document get toHtmlDocument {
    return parse(this);
  }

  html.Element? get toHtmlElement {
    return toHtmlDocument.documentElement;
  }

  ///
  /// ### Clean Html Tag,Js Tag
  ///
  String get cleanHtmlTag {
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

    // Function အစကနေ အဆုံးထိ ဖမ်းမယ့် RegExp
    // (function(...) { ... })(...) ပုံစံကို ဖမ်းမယ့် pattern
    final jsBlockPattern = RegExp(
      r'\(function\s*\(.*?\)\s*\{[\s\S]*?\}\)\s*\(.*?\);?',
      multiLine: true,
    );

    // ရှင်းထုတ်လိုက်မယ်
    res = res.replaceAll(jsBlockPattern, '');
    return res.trim();
  }
}
