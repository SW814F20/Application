import 'package:application/model/EditorScreenElement.dart';

class TextElement extends EditorScreenElement{
  TextElement(String name, int position): super(name: name, position: position);

  static TextElement fromJson(String name, int position, Map<String, dynamic> json){
    return TextElement(name, position);
  }

  @override
  String display() {
    return 'Text: '+((name != null) ? name : position.toString());
  }

  @override
  String toJson() {
    return '{"type": "Text", "name": "$name", "position": $position}';
  }
}