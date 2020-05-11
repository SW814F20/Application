import 'package:testEngine/src/CanGenerate.dart';

import 'UIElement.dart';

class UISpec extends CanGenerate {
  final int id;
  final String name;
  final List<UIElement> elements;
  UISpec({this.id, this.name, this.elements});

  static UISpec fromJson(Map<String, dynamic> data) {
    int id = data['id'];
    String name = data['name'];
    var dataElements = data['elements'];

    if(name == null || name.isEmpty){
      throw ArgumentError('A name for page must be provided!');
    }

    if(id == null || id < 1) {
      throw ArgumentError('A id for page must be provided and must be bigger than zero (>0)!');
    }

    var elements = <UIElement>{};
    for(var element in dataElements){
      elements.add(UIElement.fromJson(element));
    }

    return UISpec(id: data['id'], name: data['name'], elements: elements.toList());
  }
}