import 'package:testEngine/helpers.dart';
import 'package:testEngine/testEngine.dart';

class ButtonElement extends UIElement {
  final String name;
  final String text;

  ButtonElement({this.name, this.text}): super(type: 'Button');

  static ButtonElement fromJson(Map<String, dynamic> data) {
    String name = data['name'];
    String text = data['text'];

    if(name == null || name.isEmpty){
      throw ArgumentError('A name for Button must be provided!');
    }

    if(text != null && text.isEmpty) {
      text = null;
    }


    return ButtonElement(name: name, text: text);
  }

}