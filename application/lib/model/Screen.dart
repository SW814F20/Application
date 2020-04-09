import 'dart:convert';
import 'package:application/model/Json.dart';

class Screen implements Json {
  Screen({this.screenName, this.screenContent, this.id});

  Screen.fromJson(Map<String, dynamic> json) {
    screenName = json['screenName'];
    screenContent = jsonDecode(json['screenContent']);
    id = json['id'];
  }

  String screenName;
  List<dynamic> screenContent;
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
