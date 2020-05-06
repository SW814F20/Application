import 'package:application/model/EditorScreenElement.dart';
import 'package:flutter/widgets.dart';

class TextElement extends EditorScreenElement {
  TextElement(String name, int position, String type, {this.text = ''})
      : super(name: name, position: position, type: type);

  String text;

  static TextElement fromJson(
      String name, int position, Map<String, dynamic> json) {
    if (json == null || json['data'] == null) {
      return TextElement(name, position, 'Text');
    } else {
      return TextElement(name, position, 'Text', text: json['data']);
    }
  }

  @override
  String display() {
    return 'Text: ' + ((name != null) ? name : position.toString());
  }

  @override
  String toJson() {
    return '{"type": "Text", "name": "$name", "data": "$text", "position": $position}';
  }

  @override
  Widget render() {
    return const Text('Text');
  }
}
