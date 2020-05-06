import 'package:application/model/EditorScreenElement.dart';
import 'package:flutter/widgets.dart';

class TextInputElement extends EditorScreenElement {
  TextInputElement(String name, int position, String type,
      {this.readOnly = false,
      this.obscureText = false,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.enabled})
      : super(name: name, position: position, type: type);

  bool readOnly;
  bool obscureText;
  bool autoCorrect;
  bool enableSuggestions;
  bool enabled;

  static TextInputElement fromJson(
      String name, int position, Map<String, dynamic> json) {
    if (json == null) {
      return TextInputElement(name, position, 'TextInput');
    } else {
      return TextInputElement(name, position, 'TextInput',
          readOnly: json['readOnly'],
          obscureText: json['obscureText'],
          autoCorrect: json['autoCorrect'],
          enableSuggestions: json['enableSuggestions'],
          enabled: json['enabled']);
    }
  }

  @override
  String display() {
    return 'TextInput: ' + ((name != null) ? name : position.toString());
  }

  @override
  String toJson() {
    return '{"type": "TextInput", "name": "$name", "readOnly": $readOnly, "obscureText": $obscureText, "autoCorrect": $autoCorrect, "enableSuggestions": $enableSuggestions, "enabled": $enabled, "position": $position}';
  }

  @override
  Widget render() {
    return const Text('TextInput');
  }
}
