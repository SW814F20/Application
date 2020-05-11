import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/Text.dart';
import 'package:testEngine/src/UIElement.dart';
import 'package:testEngine/src/UIElements/Text.dart';

void main() {
  UIElement text;
  FlutterTextGenerator generator;

  setUp(() {
    text = TextElement(name: 'header', data: 'I am a header!');
    generator = FlutterTextGenerator.build(text);
  });

  group('Text Code Generator basics', () {
    test('Should create a test with a proper name', () {
      expect(generator.title, 'Text named header should exists on page');
    });

    test('Should find Flutter Text widget by Key with name as Key', () {
      expect(generator.testContent[0], 'final headerWidget = find.byKey(Key("header"));');
    });

    test('Should expect exactly one widget with the given key', () {
      expect(generator.testContent[1], 'expect(headerWidget, findsOneWidget);');
    });

    test('Should expect test to eval widget', (){
      expect(generator.testContent[2], 'final headerWidgetEval = headerWidget.evaluate().first.widget;');
    });

    test('Should expect widget to be a Text widget', (){
      expect(generator.testContent[3], 'expect(headerWidgetEval, isA<Text>());');
    });

    test('Should expect content of widget to be as specified', (){
      expect(generator.testContent[4], 'expect((headerWidgetEval as Text).data, "I am a header!");');
    });

  });
}