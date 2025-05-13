## THtmlParse

html package ကို helper class ထပ်ထည့်ထားပါပဲ။

```Dart
// with extension
final html = "<div><p>Hello</p></div>";
final dom = html.toHtmlDocument;
final ele = html.toHtmlElement; // null ?

final attr = ele!.getQuerySelectorAttr(selector: '', attr: '');
final htmlText = ele.getQuerySelectorHtml(selector: '', attr: '');
final text = ele.getQuerySelectorText(selector: '', attr: '');
// with class
final domC = THtmlParser.getHtmlDocument(html);
final eleC = THtmlParser.getHtmlElement(html);

final attrC = eleC!.getQuerySelectorAttr(selector: '', attr: '');
final htmlTextC = eleC.getQuerySelectorHtml(selector: '', attr: '');
final textC = eleC.getQuerySelectorText(selector: '', attr: '');
```
