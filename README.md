## THtmlParser

html package ကို helper class ထပ်ထည့်ထားပါပဲ။

```Dart
// with extension
final html = "<div><p>Hello</p></div>";
final dom = html.toHtmlDocument;
final ele = html.toHtmlElement; // null ?

// clean html
//void cleanDomTag({String tagNames = 'script,style,noscript'})
dom.cleanDomTag();
//void cleanEleTag({String tagNames = 'script,style,noscript'})
ele?.cleanEleTag();

final attr = ele!.getQuerySelectorAttr(selector: '', attr: '');
final htmlText = ele.getQuerySelectorHtml(selector: '');
final text = ele.getQuerySelectorText(selector: '');
// with class
final domC = THtmlParser.getHtmlDocument(html);
final eleC = THtmlParser.getHtmlElement(html);

final attrC = eleC!.getQuerySelectorAttr(selector: '', attr: '');
final htmlTextC = eleC.getQuerySelectorHtml(selector: '');
final textC = eleC.getQuerySelectorText(selector: '');
// web soup
final extractor = TExtractor(
    rules: {
    'title': TSelectorRules('.title'),
    'imageUrl': TSelectorRules('img', attribute: 'src'),
    },
);
//Map<String, String?>
final map = extractor.extract(html, isCleanHtmlTag: true);
// html tag clean
final cleanedHtmlTag = TExtractor.cleanHtmlTag(html);
```
