import 'dart:io';

import 'package:t_client/t_client.dart';
import 'package:t_html_parser/core/dom_selector.dart';
import 'package:t_html_parser/core/extensions/t_html_element_extensions.dart';
import 'package:t_html_parser/core/extensions/t_html_string_extensions.dart';
import 'package:t_html_parser/core/types/attributes.dart';
import 'package:t_html_parser/core/q_result/query_result.dart';

void main() async {
  // final url = 'https://allsaroak.com/0fc1dd15e956';
  final url =
      'https://node-browser.vercel.app?url=https://mmsubmovie.com/movies/';

  final client = TClient();
  final respFile = File('movie.html');
  String html = '';
  if (respFile.existsSync()) {
    html = await respFile.readAsString();
  } else {
    final res = await client.get(url);
    html = res.data.toString();
    await respFile.writeAsString(html);
  }

  final result = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '#archive-content .movies',
  );

  final res = result.getResultList(
    html,
    singleQueries: [
      QueryResultSingleQuery(
        (ele) => ele.getQuerySelectorText(selector: '.data a'),
      ),
      QueryResultSingleQuery(
        (ele) => ele.getQuerySelectorAttr(
          selector: '.data a',
          attr: Attribute('href'),
        ),
      ),
      QueryResultSingleQuery(
        (ele) => ele.getQuerySelectorAttr(
          selector: '.poster img',
          attr: Attribute.fromHtml(HtmlAttribute.src),
        ),
      ),
    ],
  );

  print(res);
  // await File('res.txt').writeAsString(text);

  // fetchApyar(html);
}

void fetchApyar(String html) {
  final list = DomSelector.getResultList(
    html,
    selectorAll: '.g-3 .col-6',
    queries: [
      DomSingleQuery(
        (ele) => ele.getQuerySelectorText(selector: '.card-title'),
      ),
      DomSingleQuery(
        (ele) =>
            ele.getQuerySelectorAttr(selector: 'a', attr: Attribute('href')),
      ),
      DomSingleQuery(
        (ele) =>
            ele.getQuerySelectorAttr(selector: 'img', attr: Attribute('src')),
      ),
    ],
  );
  final pagi = DomSelector.getResultList(
    html,
    selectorAll: '.pagination .page-item',
    queries: [
      DomSingleQuery((ele) => ele.getQuerySelectorText(selector: 'a')),
      DomSingleQuery(
        (ele) =>
            ele.getQuerySelectorAttr(selector: 'a', attr: Attribute('href')),
      ),
    ],
  );
  print(list);
  print(pagi);

  // final list = QueryResult(
  //   attr: Attribute.fromHtml(HtmlAttribute.text),
  //   selector: '.g-3 .col-6',
  // );
  // print(
  //   list
  //       .getResultList(
  //         html,
  //         singleQueries: [
  //           QueryResultSingleQuery(
  //             (ele) => ele.getQuerySelectorText(selector: '.card-title'),
  //           ),
  //           QueryResultSingleQuery(
  //             (ele) => ele.getQuerySelectorAttr(selector: 'a', attr: 'href'),
  //           ),
  //           QueryResultSingleQuery(
  //             (ele) => ele.getQuerySelectorAttr(selector: 'img', attr: 'src'),
  //           ),
  //         ],
  //       )
  //       .first,
  // );
}

void fetchMM(String html) async {
  final title = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.entry-title',
  );
  final otherTitle = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.entry-title',
  );
  final author = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.serl .serval',
  );
  final translator = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.serl .serval',
  );
  final content = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.entry-content',
    isCleanDomTags: true,
  );

  print('title: ${title.getResult(html)}');
  print('otherTitle: ${otherTitle.getResult(html)}');
  print('author: ${author.getResult(html, index: 1)}');
  print('translator: ${translator.getResult(html, index: 2)}');
  print('content: ${content.getResult(html)}');
}

void fetchDrmgnyo() async {
  final url = 'https://drmgnyo.com/read/apyar53/';
  final file = File('res.html');
  String data = '';

  if (file.existsSync()) {
    data = await file.readAsString();
  } else {
    final client = TClient();
    final res = await client.get(url);
    await file.writeAsString(res.data);
    data = res.data;
  }

  //.wp-post-image .entry-content
  final imageUrl = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.src),
    selector: '.wp-post-image',
  );

  final title = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.post-title',
  );
  final content = QueryResult(
    attr: Attribute.fromHtml(HtmlAttribute.textContent),
    selector: '.entry-content',
    // afterQuery: (attr, result) => result!.cleanHtmlTag(),
  );

  print('title: ${title.getResult(data)}');
  print('coverUrl: ${imageUrl.getResult(data)}');
  print(content.getResult(data).cleanHtmlTag);
}
