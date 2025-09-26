class TSelectorRules {
  final String selector;
  final String? attribute;
  TSelectorRules(this.selector, {this.attribute});

  @override
  String toString() {
    return 'selector: $selector -> attr: $attribute';
  }
}
