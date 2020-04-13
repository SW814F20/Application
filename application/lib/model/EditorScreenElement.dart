import 'package:application/model/Json.dart';

class EditorScreenElement implements Json {
  EditorScreenElement({this.widgetType, this.position, this.key});

  int position;
  String widgetType;
  String key;

  String display() {
    return 'Type: $widgetType, key: $key';
  }

  @override
  String toJson() {
    return '''
    {
      'type': '$widgetType',
      'key': '$key',
      'position': '$position'
    }
  ''';
  }
}
