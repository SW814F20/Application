import 'package:test/test.dart';
import 'package:testEngine/src/CodeGenerators/flutter/widgets/Button.dart';
import 'package:testEngine/src/UIElement.dart';
import 'package:testEngine/src/UIElements/Button.dart';

void main(){
  UIElement Button;
  FlutterButtonGenerator generator;

  setUp((){
    Button = ButtonElement(name: 'button', text: 'Click me');
    generator = FlutterButtonGenerator.build(Button);
  });

  group('Button Code Generator basics', () {
    test('Should create a test with a proper name', () {
      expect(generator.title, 'Button named button should exists on page');
    });

    test('Should find Flutter Button widget by Key with name as Key', () {
      expect(generator.testContent[0], 'final buttonWidget = find.byKey(Key("button"));');
    });

    test('Should expect exactly one widget with the given key', () {
      expect(generator.testContent[1], 'expect(buttonWidget, findsOneWidget);');
    });

    test('Should expect the widget to be either a materialebutton or cupertinobutton', (){
      expect(generator.testContent[2], 'expect(buttonWidget.evaluate().first.widget, (item) {');
      expect(generator.testContent[3], '\treturn item is MaterialButton || item is CupertinoButton;');
      expect(generator.testContent[4], '});');
    });

    test('Should expect that the button has a descendant textWidget with the value text', () {
      expect(generator.testContent[5], 'expect(find.descendant(of: buttonWidget, matching: find.text(\'Click me\')), findsOneWidget);');
    });

    test('Should expect the button isEnabled to be set correctly', (){

    });

    test('If value is set to null, it should not expect a descendant textWidget', (){
      var submitButtonWithOutValue = ButtonElement(name: 'button');
      generator = FlutterButtonGenerator.build(submitButtonWithOutValue);

      expect(generator.testContent.length, 5);
    });
  });
}