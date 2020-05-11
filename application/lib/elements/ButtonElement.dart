import 'package:application/model/EditorScreenElement.dart';
import 'package:flutter/widgets.dart';

class ButtonElement extends EditorScreenElement {
  ButtonElement(String name, int position, String type, {this.text = ''})
      : super(name: name, position: position, type: type);
  String text;

  static ButtonElement fromJson(
      String name, int position, Map<String, dynamic> json) {
    if (json == null || json['text'] == null) {
      return ButtonElement(name, position, 'Button');
    } else {
      return ButtonElement(name, position, 'Button', text: json['text']);
    }
  }

  @override
  String display() {
    return 'Button' + ((name != null) ? ': $name' : '');
  }

  @override
  String toJson() {
    return '''
    {
    "type": "Button",
    "name": "$name",
    "text": "$text",
    "position": $position
    }''';
  }

  @override
  Widget render() {
    return const Text('Button');
  }
}
