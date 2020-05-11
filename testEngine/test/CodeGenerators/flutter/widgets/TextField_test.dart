import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/TextField.dart';
import 'package:testEngine/src/UIElement.dart';
import 'package:testEngine/src/UIElements/TextInput.dart';

void main(){
  group('TextField Code Generator basics', (){
    UIElement textInput;
    FlutterTextFieldGenerator generator;

    setUp((){
      textInput = TextInputElement(name: 'field', obscureText: true, autoCorrect: true, readOnly: true, enabled: true, enableSuggestions: true);
      generator = FlutterTextFieldGenerator.build(textInput);
    });

    test('Should create a test with a proper name', () {
      expect(generator.title, 'TextInput named field should exists on page');
    });

    test('Should find Flutter textField widget byKey with name as Key', () {
      expect(generator.testContent[0], 'final fieldWidget = find.byKey(Key("field"));');
    });

    test('Should expect exactly one widget with the given key', () {
      expect(generator.testContent[1], 'expect(fieldWidget, findsOneWidget);');
    });

    test('Should store evaluated widget in variable', (){
      expect(generator.testContent[2], 'final fieldWidgetEval = fieldWidget.evaluate().first.widget;');
    });

    test('Should expect the widget to be a TextField widget', () {
      expect(generator.testContent[3], 'expect(fieldWidgetEval, isA<TextField>());');
    });

    test('Should expect enabled to be null if set to null', (){
      UIElement textInput = TextInputElement(name: 'field', obscureText: true, autoCorrect: true, readOnly: true, enabled: null, enableSuggestions: true);
      FlutterTextFieldGenerator generator = FlutterTextFieldGenerator.build(textInput);
      expect(generator.testContent[7], 'expect((fieldWidgetEval as TextField).enabled, isNull);');
    });

  });

  group('TextField Code generate correctly on all true', (){
    UIElement textInput;
    FlutterTextFieldGenerator generator;

    setUp((){
      textInput = TextInputElement(name: 'field', obscureText: true, autoCorrect: true, readOnly: true, enabled: true, enableSuggestions: true);
      generator = FlutterTextFieldGenerator.build(textInput);
    });

    test('Should expect the widget to have obscureText', (){
      expect(generator.testContent[4], 'expect((fieldWidgetEval as TextField).obscureText, isTrue);');
    });

    test('Should expect the widget to have autoCorrect', (){
      expect(generator.testContent[5], 'expect((fieldWidgetEval as TextField).autocorrect, isTrue);');
    });

    test('Should expect the widget to have readOnly', (){
      expect(generator.testContent[6], 'expect((fieldWidgetEval as TextField).readOnly, isTrue);');
    });

    test('Should expect the widget to have enabled', (){
      expect(generator.testContent[7], 'expect((fieldWidgetEval as TextField).enabled, isTrue);');
    });

    test('Should expect the widget to have enableSuggestions', (){
      expect(generator.testContent[8], 'expect((fieldWidgetEval as TextField).enableSuggestions, isTrue);');
    });
  });

  group('TextField Code generate correctly on all false', (){
    UIElement textInput;
    FlutterTextFieldGenerator generator;

    setUp((){
      textInput = TextInputElement(name: 'field', obscureText: false, autoCorrect: false, readOnly: false, enabled: false, enableSuggestions: false);
      generator = FlutterTextFieldGenerator.build(textInput);
    });

    test('Should expect the widget to have obscureText', (){
      expect(generator.testContent[4], 'expect((fieldWidgetEval as TextField).obscureText, isFalse);');
    });

    test('Should expect the widget to have autoCorrect', (){
      expect(generator.testContent[5], 'expect((fieldWidgetEval as TextField).autocorrect, isFalse);');
    });

    test('Should expect the widget to have readOnly', (){
      expect(generator.testContent[6], 'expect((fieldWidgetEval as TextField).readOnly, isFalse);');
    });

    test('Should expect the widget to have enabled', (){
      expect(generator.testContent[7], 'expect((fieldWidgetEval as TextField).enabled, isFalse);');
    });

    test('Should expect the widget to have enableSuggestions', (){
      expect(generator.testContent[8], 'expect((fieldWidgetEval as TextField).enableSuggestions, isFalse);');
    });
  });
}