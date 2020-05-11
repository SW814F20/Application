import 'package:test/test.dart';
import 'package:testEngine/src/CanGenerate.dart';
import 'package:testEngine/src/UIElements/Button.dart';
import 'package:testEngine/src/UIElement.dart';

import '../JsonElementFactory.dart';

void expectArgumentError(Map<String, dynamic> data, String error_msg){
  return expect(
          () => ButtonElement.fromJson(data),
      throwsA(
          predicate((e) =>
          e is ArgumentError &&
              e.message == error_msg
          )
      )
  );
}

void main() {
  group('Button UIElement', (){
    test('Should be able to construct given valid json', (){
      var parsedJson = JsonElementFactory.Button(name: 'Btn', text: 'Click here!');
      var el = ButtonElement.fromJson(parsedJson);
      expect(el, isA<ButtonElement>());
      expect(el, isA<UIElement>());
      expect(el, isA<CanGenerate>());
      expect(el.name, 'Btn');
      expect(el.type, 'Button');
      expect(el.text, 'Click here!');
    });

    test('Should require a name key present', (){
      expectArgumentError(JsonElementFactory.Button(name: null), 'A name for Button must be provided!');
    });

    test('should require name to be none empty', () {
      expectArgumentError(JsonElementFactory.Button(name: ''), 'A name for Button must be provided!');
    });

    test('should not require a button text', () {
      var btn = ButtonElement.fromJson(JsonElementFactory.Button(text: null));

      expect(btn.type, 'Button');
      expect(btn.text, isNull);
    });

    test('should allow button text to be a empty string', () {
      var btn = ButtonElement.fromJson(JsonElementFactory.Button(text: ''));

      expect(btn.type, 'Button');
      expect(btn.text, isNull);
    });

  });
}