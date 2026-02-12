# THtmlParser

## QueryResult

```dart
final url =
      'https://mmxianxia.com/novels/immortality-the-lord-of-the-holy-dynasty-invites-me-to-come-out-of-seclusion/';

final client = TClient();
final res = await client.get(url);
final html = res.data.toString();

final title = QueryResult(
    index: 0,
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.entry-title',
);
final otherTitle = QueryResult(
    index: 0,
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.entry-title',
);
final author = QueryResult(
    index: 1,
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.serl .serval',
);
final translator = QueryResult(
    index: 2,
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.serl .serval',
);
final content = QueryResult(
    index: 0,
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.entry-content',
);

print('title: ${title.getResult(html)}');
print('otherTitle: ${otherTitle.getResult(html)}');
print('author: ${author.getResult(html)}');
print('translator: ${translator.getResult(html)}');
print('content: ${content.getResult(html)}');
```

## New Method

```Dart
// with extension
final html = "<div><p>Hello</p></div>";
final dom = html.toHtmlDocument;
final ele = html.toHtmlElement; // null?

//FQuery Class
final query = FQuery(selector: 'h1',);
print(query.getResult(ele));
```

## Old Methods

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
