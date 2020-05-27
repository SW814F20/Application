import 'dart:convert';
import 'package:flutter/services.dart';

String _file = '';
String _content = '';
dynamic _jsonDecoded;

/// Get variable from environment
T getVar<T>(String variableName) {
  return _jsonDecoded[variableName];
}

/// Set environment from file
Future<void> setFile(String fileLocation) async {
  _file = fileLocation;
  _content = await rootBundle.loadString(_file);
  _jsonDecoded = jsonDecode(_content);
}

/// Set environment from json string
void setContent(String content) {
  _content = content;
  _jsonDecoded = jsonDecode(_content);
}
