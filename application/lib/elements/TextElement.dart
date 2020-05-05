import 'package:application/model/EditorScreenElement.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/widgets.dart';

class TextElement extends EditorScreenElement {
  TextElement(String name, int position, String type)
      : super(name: name, position: position, type: type);

  RoundedTextField _nameInput;

  static TextElement fromJson(
      String name, int position, Map<String, dynamic> json) {
    return TextElement(name, position, 'Text');
  }

  @override
  String display() {
    return 'Text: ' + ((name != null) ? name : position.toString());
  }

  @override
  String toJson() {
    return '{"type": "Text", "name": "$name", "position": $position}';
  }

  @override
  List<Widget> getSettingsWidgets() {
    _nameInput = nameWidget();
    _nameInput.controller.text = name;
    return [_nameInput, saveSettingsWidget(saveSettings)];
  }

  @override
  void saveSettings() {
    name = _nameInput.controller.text;

    super.saveSettings();
  }

  @override
  Widget render() {
    return const Text('Text');
  }
}
