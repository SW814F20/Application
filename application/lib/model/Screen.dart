import 'package:application/model/Json.dart';

class Screen implements Json {
  @override
  Screen.fromJson(Map<String, dynamic> json)
      : screenName = json['screenName'],
        screenContent = json['screenContent'],
        id = json['id'];

  String screenName;
  String screenContent;
  int id;

  @override
  String toJson() {
    return '''
    {
      "screenName": "$screenName",
      "screenContent": "$screenContent"
    }
    ''';
  }
}
