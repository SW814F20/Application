import '../UIElement.dart';

class TextElement extends UIElement{
  final String name;
  final String data;

  TextElement({this.name, this.data}): super(type: 'Text');

  static TextElement fromJson(Map<String, dynamic> json){
    String name = json['name'];
    String data = json['data'];

    if(name == null || name.isEmpty){
      throw ArgumentError('A name for Text must be provided!');
    }

    if(data == null || data.isEmpty){
      throw ArgumentError('A data for Text must be provided!');
    }

    return TextElement(name: name, data: data);
  }

}