import 'package:html/dom.dart' as html;

extension THtmlDomExtension on html.Document {
  void cleanDomTag({
    String tagNames = 'script,style,noscript, div[id^="pf-"]',
  }) {
    querySelectorAll(tagNames).forEach((e) => e.remove());
  }
}
