import 'dart:convert';

import 'package:test/test.dart';
import 'package:testEngine/src/UIElement.dart';
import 'package:testEngine/src/UIElements/Button.dart';
import 'package:testEngine/src/UIElements/Text.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';

import 'JsonElementFactory.dart';

void expectArgumentError(Map<String, dynamic> data, String error_msg){
  return expect(
          () => UIElement.fromJson(data),
      throwsA(
          predicate((e) =>
          e is ArgumentError &&
              e.message == error_msg
          )
      )
  );
}

void main() {
  group('UIElement factory', () {
    test('should be able to construct a TextInput type', () {
      TextInputElement el = UIElement.fromJson(JsonElementFactory.TextInput());
      expect(el, isA<TextInputElement>());
      expect(el.type, 'TextInput');
    });

    test('should be able to construct a Button type', () {
      ButtonElement el = UIElement.fromJson(JsonElementFactory.Button());
      expect(el, isA<ButtonElement>());
      expect(el.type, 'Button');
    });

    test('should be able to construct a Text type', (){
      TextElement el = UIElement.fromJson(JsonElementFactory.Text());
      expect(el, isA<TextElement>());
      expect(el.type, 'Text');
    });
  });

  group('UIElement json parsing', () {
    test('should throw error when unknow type is specified', (){
      expectArgumentError(json.decode('{"type": "UnknownType"}') , 'The specified type "UnknownType" is unknown!');
    });

    test('should throw error when type is not supplied', () {
      expectArgumentError(json.decode('{"name": "test"}'), 'A type for element must be provided!');
    });

    test('should throw error when type is provided but is empty', () {
      expectArgumentError(json.decode('{"name": "test", "type": ""}'), 'A type for element must be provided!');
    });

  });

}