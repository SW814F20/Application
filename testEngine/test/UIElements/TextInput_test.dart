import 'dart:convert';

import 'package:test/test.dart';
import 'package:testEngine/src/CanGenerate.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';

import 'package:testEngine/src/UIElement.dart';

import '../JsonElementFactory.dart';

void expectArgumentError(Map<String, dynamic> data, String error_msg){
  return expect(
          () => TextInputElement.fromJson(data),
      throwsA(
          predicate((e) =>
          e is ArgumentError &&
              e.message == error_msg
          )
      )
  );
}

void main(){
  group('TextInput UIElement', (){

    test('Should be able to construct given valid json', () {
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput());
      expect(el, isA<TextInputElement>());
      expect(el, isA<UIElement>());
      expect(el, isA<CanGenerate>());
      expect(el.name, 'Username');
      expect(el.type, 'TextInput');
      expect(el.readOnly, false);
      expect(el.obscureText, false);
      expect(el.autoCorrect, true);
      expect(el.enableSuggestions, true);
      expect(el.enabled, true);
    });

    test('Should allow the enabled key to be null', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(enabled: null));
      expect(el, isA<TextInputElement>());
      expect(el.enabled, isNull);
    });

    test('Should be able to parse int as bool for enabled', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(enabled: 1));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(enabled: 0));

      expect(el, isA<TextInputElement>());
      expect(el.enabled, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.enabled, false);
    });

    test('Should be able to parse string as bool for enabled', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(enabled: '"TRUE"'));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(enabled: '"false"'));

      expect(el, isA<TextInputElement>());
      expect(el.enabled, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.enabled, false);
    });

    test('Should require a enableSuggestions key present', (){
      var parsedJson = JsonElementFactory.TextInput(enableSuggestions: null);
      expectArgumentError(parsedJson, 'enableSuggestions setting for TextInput must be provided!');
    });

    test('Should be able to parse int as bool for enableSuggestions', (){
    var el = TextInputElement.fromJson(JsonElementFactory.TextInput(enableSuggestions: 1));
    var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(enableSuggestions: 0));

    expect(el, isA<TextInputElement>());
    expect(el.enableSuggestions, true);

    expect(el2, isA<TextInputElement>());
    expect(el2.enableSuggestions, false);
    });

    test('Should be able to parse string as bool for enableSuggestions', (){
    var el = TextInputElement.fromJson(JsonElementFactory.TextInput(enableSuggestions: '"TRUE"'));
    var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(enableSuggestions: '"false"'));

    expect(el, isA<TextInputElement>());
    expect(el.enableSuggestions, true);

    expect(el2, isA<TextInputElement>());
    expect(el2.enableSuggestions, false);
    });

    test('Should require a autoCorrect key present', (){
      var parsedJson = JsonElementFactory.TextInput(autoCorrect: null);
      expectArgumentError(parsedJson, 'autoCorrect setting for TextInput must be provided!');
    });

    test('Should be able to parse int as bool for autoCorrect', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(autoCorrect: 1));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(autoCorrect: 0));

      expect(el, isA<TextInputElement>());
      expect(el.autoCorrect, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.autoCorrect, false);
    });

    test('Should be able to parse string as bool for autoCorrect', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(autoCorrect: '"TRUE"'));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(autoCorrect: '"false"'));

      expect(el, isA<TextInputElement>());
      expect(el.autoCorrect, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.autoCorrect, false);
    });

    test('Should require a obscureText key present', (){
      var parsedJson = JsonElementFactory.TextInput(obscureText: null);
      expectArgumentError(parsedJson, 'obscureText setting for TextInput must be provided!');
    });

    test('Should be able to parse int as bool for obscureText', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(obscureText: 1));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(obscureText: 0));

      expect(el, isA<TextInputElement>());
      expect(el.obscureText, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.obscureText, false);
    });

    test('Should be able to parse string as bool for obscureText', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(obscureText: '"TRUE"'));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(obscureText: '"false"'));

      expect(el, isA<TextInputElement>());
      expect(el.obscureText, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.obscureText, false);
    });

    test('Should require a readOnly key present', (){
      var parsedJson = JsonElementFactory.TextInput(readOnly: null);
      expectArgumentError(parsedJson, 'readOnly setting for TextInput must be provided!');
    });

    test('Should be able to parse int as bool for readOnly', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(readOnly: 1));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(readOnly: 0));

      expect(el, isA<TextInputElement>());
      expect(el.readOnly, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.readOnly, false);
    });

    test('Should be able to parse string as bool for readOnly', (){
      var el = TextInputElement.fromJson(JsonElementFactory.TextInput(readOnly: '"TRUE"'));
      var el2 = TextInputElement.fromJson(JsonElementFactory.TextInput(readOnly: '"false"'));

      expect(el, isA<TextInputElement>());
      expect(el.readOnly, true);

      expect(el2, isA<TextInputElement>());
      expect(el2.readOnly, false);
    });

    test('Should require a name key present', (){
        var parsedJson = JsonElementFactory.TextInput(name: null);
        expectArgumentError(parsedJson, 'A name for TextInput must be provided!');
    });

    test('should require name to be none empty', () {
      var parsedJson = JsonElementFactory.TextInput(name: '');
      expectArgumentError(parsedJson, 'A name for TextInput must be provided!');
    });
  });
}