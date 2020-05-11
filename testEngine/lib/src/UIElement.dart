import 'package:testEngine/src/CanGenerate.dart';
import 'package:testEngine/src/UIElements/Button.dart';
import 'package:testEngine/src/UIElements/Text.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';

abstract class UIElement extends CanGenerate {
  final String type;


  UIElement({this.type});

  static UIElement fromJson(Map<String, dynamic> data) {
    String type = data['type'];
    if(type == null || type.isEmpty){
      throw ArgumentError('A type for element must be provided!');
    }

    switch(type){
      case 'TextInput':
        return TextInputElement.fromJson(data);
        break;
      case 'Button':
        return ButtonElement.fromJson(data);
        break;
      case 'Text':
        return TextElement.fromJson(data);
        break;
      default:
        throw ArgumentError('The specified type "${type}" is unknown!');
    }
  }
}