import 'package:application/model/EditorScreenElement.dart';

class ButtonElement extends EditorScreenElement{

  ButtonElement(String name, int position): super(name: name, position: position);

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
}