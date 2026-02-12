class Attribute {
  final String attr;
  const Attribute(this.attr);

  factory Attribute.fromHtml(HtmlAttribute attr) {
    return Attribute(attr.name);
  }

  String get value => attr.trim();
}

enum HtmlAttribute {
  text('text'),
  textContent('textContent'),
  href('href'),
  src('src'),
  html('html'),
  outerHtml('outerHtml'),
  alt('alt'); // နောက်ထပ် လိုအပ်တာတွေ ထပ်ထည့်နိုင်ပါတယ်

  final String value;
  const HtmlAttribute(this.value);
}
