import 'dart:io';

import 'package:t_client/t_client.dart';
import 'package:t_html_parser/core/q_result/attributes.dart';
import 'package:t_html_parser/core/q_result/query_result.dart';
import 'package:t_html_parser/core/t_html_extensions.dart';

void main() async {
  fetchMM();
}

void fetchMM() async {
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
    index: 0,
    attr: Attribute.fromHtml(HtmlAttribute.src),
    selector: '.wp-post-image',
  );

  final title = QueryResult(
    index: 0,
    attr: Attribute.fromHtml(HtmlAttribute.text),
    selector: '.post-title',
  );
  final content = QueryResult(
    index: 0,
    attr: Attribute.fromHtml(HtmlAttribute.textContent),
    selector: '.entry-content',
    // afterQuery: (attr, result) => result!.cleanHtmlTag(),
  );

  print('title: ${title.getResult(data)}');
  print('coverUrl: ${imageUrl.getResult(data)}');
  print(content.getResult(data)!.cleanHtmlTag());
}
