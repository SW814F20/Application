import 'dart:convert';

import 'package:application/elements/ButtonElement.dart';
import 'package:application/elements/TextElement.dart';
import 'package:application/model/EditorScreenElement.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class mockElement extends EditorScreenElement{

  bool isCalled = false;

  @override
  String display() {
    // TODO: implement display
    throw UnimplementedError();
  }

  @override
  List<Widget> getSettingsWidgets() {
    // TODO: implement getSettingsWidgets
    throw UnimplementedError();
  }

  @override
  String toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  void saveSettings(){
    super.saveSettings();
  }

  @override
  Widget render() {
    // TODO: implement render
    throw UnimplementedError();
  }

}
void main() {
  group('EditorScreenElement JSON factory element constructor tests', () {
    test('Should be able to construct a Text-widget', (){
      final Map<String, dynamic> data = jsonDecode('{"type": "Text", "name": "AName", "position": 0}');

      final el = EditorScreenElement.fromJson(data);

      expect(el, isNotNull);
      expect(el is TextElement, isTrue);
      expect(el.name, 'AName');
      expect(el.position, 0);
    });

    test('Should be able to construct a Button-widget', (){
      final Map<String, dynamic> data = jsonDecode('{"type": "Button", "name": "AName", "position": 0}');

      final el = EditorScreenElement.fromJson(data);

      expect(el, isNotNull);
      expect(el is ButtonElement, isTrue);
      expect(el.name, 'AName');
      expect(el.position, 0);
    });
  });

  group('EditorScreenElement basic functionalities', (){
    test('Should allow for creating an in-memory Text-widget instance', (){
      final el = EditorScreenElement.create('Text', 0);

      expect(el, isNotNull);
      expect(el.name, isNull);
      expect(el is TextElement, isTrue);
      expect(el.position, 0);
    });

    test('Should allow for creating an in-memory Button-widget instance', (){
      final el = EditorScreenElement.create('Button', 0);

      expect(el, isNotNull);
      expect(el.name, isNull);
      expect(el is ButtonElement, isTrue);
      expect(el.position, 0);
    });

    test('Should be able to retrieve a settingsWidget', (){
      final el = EditorScreenElement.create('Text', 0);

      expect(el.getSettingsWidgets() is List<Widget>, isTrue);
    });

    test('Should be able to build the nameInputField', (){
      final el = EditorScreenElement.create('Text', 0);

      final RoundedTextField nameField = el.nameWidget();

      expect(nameField.hintText, 'Widget Name');
    });

    test('Should be able to build a saveButton-widget with onPressed-function', (){
      Function pres = () => { print('Hello world') };
      final el = EditorScreenElement.create('Text', 0);

      final RaisedButton saveBtn = el.saveSettingsWidget(pres);

      expect(saveBtn.onPressed, pres);
      expect(saveBtn.child is Text, isTrue);
      expect((saveBtn.child as Text).data, 'Save information');
    });

    test('Should invoke onSave, when calling saveSettings', (){
      final el = mockElement();
      var cb = (mockElement el) {
        el.isCalled = true;
      };
      el.onSave = cb;
      el.saveSettings();
      expectLater(el.isCalled, isTrue);
    });
  });


  group('EditorScreenElement JSON factory data-parsing tests', () {
    Map<String, dynamic> data;

    setUp(() {
      data = jsonDecode('{"type": "Text", "name": "IAmATest", "position": "0"}');
    });

    test('Should require a type', (){
        final Map<String, dynamic> data = jsonDecode('{"no-type": "Should fail"}');

        expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
            e is ArgumentError &&
            e.message == 'EditorScreenElement Factory Error: Type must be specified and cannot be empty!')
        ));
    });

    test('Should throw unknown type if type is unknown', (){
      final Map<String, dynamic> data = jsonDecode('{"type": "UnkownElement", "name": "AName", "position": 0}');

      expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
      e is ArgumentError &&
          e.message == 'EditorScreenElement Factory Error: The type \'UnkownElement\' is not known!')
      ));
    });

    test('Should be able to parse and set the name', () {
      final el = EditorScreenElement.fromJson(data);

      expect(el, isNotNull);
      expect(el.name, 'IAmATest');
    });

    test('Should throw an ArgumentError if name is not present in json', (){
      data = jsonDecode('{"type": "Text", "position": "0"}');

      expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
      e is ArgumentError &&
          e.message == 'EditorScreenElement Factory Error: A name must be present in the JSON')
      ));
    });

    test('Should throw an ArgumentError if name is present but an empty string', (){
      data = jsonDecode('{"type": "Text", "name": "", "position": "0"}');

      expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
      e is ArgumentError &&
          e.message == 'EditorScreenElement Factory Error: A name must be present in the JSON')
      ));
    });

    test('Should be able to parse and set position', (){
      final el = EditorScreenElement.fromJson(data);

      expect(el, isNotNull);
      expect(el.position, 0);
    });

    test('Should be able to parse and set position, if position is given as a int', (){
      data = jsonDecode('{"type": "Text", "name": "IAmATest", "position": 0}');

      final el = EditorScreenElement.fromJson(data);

      expect(el, isNotNull);
      expect(el.position, 0);
    });

    test('Should throw an ArgumentError if position is not present in json', (){
      data = jsonDecode('{"type": "Text", "name": "AName"}');

      expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
      e is ArgumentError &&
          e.message == 'EditorScreenElement Factory Error: A position must be present in the JSON')
      ));
    });

    test('Should throw an ArgumentError if position is present but an empty string', (){
      data = jsonDecode('{"type": "Text", "name": "AName", "position": ""}');

      expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
      e is ArgumentError &&
          e.message == 'EditorScreenElement Factory Error: A position must be present in the JSON')
      ));
    });

    test('Should throw an ArgumentError if position is present but not a digit', (){
      data = jsonDecode('{"type": "Text", "name": "AName", "position": "NotADigit"}');

      expect(() => EditorScreenElement.fromJson(data), throwsA(predicate<Error>((e) =>
      e is ArgumentError &&
          e.message == 'EditorScreenElement Factory Error: A position must be a digit in the JSON')
      ));
    });
  });
}