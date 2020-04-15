import 'dart:convert';
import 'package:application/model/EditorScreenElement.dart';
import 'package:application/model/Json.dart';

class Screen implements Json {
  Screen({this.screenName, this.screenContent, this.id});

  Screen.fromJson(Map<String, dynamic> json) {
    screenName = json['screenName'];
    screenContent = [];
    List<dynamic> screenContentJson = jsonDecode(json['screenContent'].toString().replaceAll('\'', '\"'));
    id = json['id'];
    for (Map<String, dynamic> widget in screenContentJson) {
      screenContent.add(EditorScreenElement.fromJson(widget));
    }
  }

  String screenName;
  List<EditorScreenElement> screenContent;
  int id;

  @override
  String toJson() {
    return '''
    {
      "screenName": "$screenName",
      "screenContent": "${screenContent.map((e) => e.toJson())}"
    }
    ''';
  }
}
