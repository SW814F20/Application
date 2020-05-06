import 'package:application/model/EditorScreenElement.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/widgets.dart';

class ButtonElement extends EditorScreenElement{

  ButtonElement(String name, int position): super(name: name, position: position);

  RoundedTextField _nameInput;

  static ButtonElement fromJson(String name, int position, Map<String, dynamic> json) {
    return ButtonElement(name, position);
  }

  @override
  String display() {
    return 'Button: '+ ((name != null) ? name : position.toString());
  }

  @override
  String toJson() {
    return '{"type": "Button", "name": "$name", "position": $position}';
  }

  @override
  List<Widget> getSettingsWidgets() {
    _nameInput = nameWidget();
    _nameInput.controller.text = name;
    return [
      _nameInput,
      saveSettingsWidget(saveSettings)
    ];
  }

  @override
  void saveSettings() {
    name = _nameInput.controller.text;

    super.saveSettings();
  }

  @override
  Widget render() {
    return const Text('Button');
  }
}