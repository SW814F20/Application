import 'dart:convert';

import 'package:test/test.dart';
import 'package:testEngine/src/UISpec.dart';

import 'JsonElementFactory.dart';
import 'JsonScreenFactory.dart';

void expectArgumentError(Map<String, dynamic> data, String error_msg){
  return expect(
          () => UISpec.fromJson(data),
      throwsA(
          predicate((e) =>
          e is ArgumentError &&
              e.message == error_msg
          )
      )
  );
}

void main() {
  group('UISpec', () {
      test('should be able to construct from json', (){
        var parsedJson = JsonScreenFactory.Screen(id: 1, name: 'TestPage', elements: [JsonElementFactory.TextInput(name: 'Username')]);
        var spec = UISpec.fromJson(parsedJson);
        expect(spec, isNotNull);
        expect(spec.runtimeType, UISpec);
        expect(spec.id, 1);
        expect(spec.name, 'TestPage');
        expect(spec.elements.length, 1);
        expect(spec.elements[0].type, 'TextInput');
      });

      test('should be able to construct from json - given multiple elements', (){
        var parsedJson = JsonScreenFactory.Screen(id: 1, name: 'TestPage', elements: [JsonElementFactory.TextInput(), JsonElementFactory.Button()]);
        var spec = UISpec.fromJson(parsedJson);
        expect(spec.elements.length, 2);
        expect(spec.elements[0].type, 'TextInput');
        expect(spec.elements[1].type, 'Button');
      });

      test('should throw error when name is not supplied', () {
        expectArgumentError(JsonScreenFactory.Screen(name: null), 'A name for page must be provided!');
      });

      test('should throw error when name is provided but empty', () {
        expectArgumentError(JsonScreenFactory.Screen(name: ''), 'A name for page must be provided!');
      });

      test('should throw error when id is not supplied', () {
        expectArgumentError(JsonScreenFactory.Screen(id: null), 'A id for page must be provided and must be bigger than zero (>0)!');
      });

      test('should throw error when id is provided but is 0', () {
        expectArgumentError(JsonScreenFactory.Screen(id: 0), 'A id for page must be provided and must be bigger than zero (>0)!');
      });
  });
}