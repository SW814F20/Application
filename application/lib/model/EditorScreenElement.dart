import 'package:application/elements/ButtonElement.dart';
import 'package:application/elements/TextElement.dart';
import 'package:application/elements/TextInputElement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum elementType { Text, Button }

abstract class EditorScreenElement {
  EditorScreenElement({this.name, this.position, this.type});

  String name;
  String type;
  int position;

  String display();
  String toJson();
  Widget render();

  static EditorScreenElement create(String type, int position) {
    type = _validateType(type);
    position = _validatePosition(position);

    return _factory(type, position);
  }

  static EditorScreenElement fromJson(Map<String, dynamic> json) {
    final String type = _validateType(json['type']);
    final String name = _validateName(json['name']);
    final int position = _validatePosition(json['position']);

    return _factory(type, position, name: name, json: json);
  }

  static EditorScreenElement _factory(String type, int position,
      {String name, Map<String, dynamic> json}) {
    switch (type) {
      case 'Text':
        return TextElement.fromJson(name, position, json);
        break;
      case 'Button':
        return ButtonElement.fromJson(name, position, json);
        break;
      case 'TextInput':
        return TextInputElement.fromJson(name, position, json);
        break;
      default:
        throw ArgumentError(
            'EditorScreenElement Factory Error: The type \'$type\' is not known!');
    }
  }

  static String _validateType(String input) {
    if (input == null || input == '') {
      throw ArgumentError(
          'EditorScreenElement Factory Error: Type must be specified and cannot be empty!');
    }

    return input;
  }

  static String _validateName(String input) {
    if (input == null || input.isEmpty) {
      throw ArgumentError(
          'EditorScreenElement Factory Error: A name must be present in the JSON');
    }
    return input;
  }

  static int _validatePosition(dynamic input) {
    if (input == null || input.toString().isEmpty) {
      throw ArgumentError(
          'EditorScreenElement Factory Error: A position must be present in the JSON');
    }

    if (!(input is int)) {
      input = int.tryParse(input);
      if (input == null) {
        throw ArgumentError(
            'EditorScreenElement Factory Error: A position must be a digit in the JSON');
      }
    }

    return input;
  }
}
