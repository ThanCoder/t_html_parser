class Attribute {
  final String attribute;
  const Attribute(this.attribute);

  factory Attribute.fromHtml(HtmlAttribute attr) {
    return Attribute(attr.name);
  }

  String get value => attribute.trim();
}

enum HtmlAttribute {
  text('text'),
  textContent('textContent'),
  href('href'),
  src('src'),
  html('html'),
  outerHtml('outerHtml'),
  dataSrc('data-src'),
  alt('alt'); // နောက်ထပ် လိုအပ်တာတွေ ထပ်ထည့်နိုင်ပါတယ်

  final String value;
  const HtmlAttribute(this.value);
}
