// TODO: Put public facing types in this file.

import 'dart:convert';
import 'package:testEngine/src/UISpec.dart';


class TestEngine{
  UISpec parseLayout(String simpleJson) {
    var parsedJson = json.decode(simpleJson);
    
    return UISpec.fromJson(parsedJson);
  }

  UISpec parseLayoutFromJson(Map<String, dynamic> json) {
    return UISpec.fromJson(json);
  }

}