import 'package:html/dom.dart' as dom;

extension WebDevUtils on dom.Element {
  // JS textContent နဲ့ အတူတူပဲဖြစ်အောင် လုပ်ထားတာပါ
  String get textContent {
    // tag အားလုံးရဲ့ text တွေကို recursive စနစ်နဲ့ စုယူပါတယ်
    return nodes.map((node) => node.text).join('').trim();
  }
}

// သုံးစွဲပုံ
// var myText = element.textContent;
