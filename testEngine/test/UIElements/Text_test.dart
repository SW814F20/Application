import 'package:test/test.dart';
import 'package:testEngine/src/CanGenerate.dart';
import 'package:testEngine/src/UIElement.dart';
import 'package:testEngine/src/UIElements/Text.dart';

import '../JsonElementFactory.dart';

void expectArgumentError(Map<String, dynamic> data, String error_msg){
  return expect(
          () => TextElement.fromJson(data),
      throwsA(
          predicate((e) =>
          e is ArgumentError &&
              e.message == error_msg
          )
      )
  );
}

void main(){
  group('Text Widget UIElement', () {
    test('Should be able to construct given valid json', (){
      var parsedJson = JsonElementFactory.Text(name: 'Header', data: 'I am a header!');
      var el = TextElement.fromJson(parsedJson);
      expect(el, isA<TextElement>());
      expect(el, isA<UIElement>());
      expect(el, isA<CanGenerate>());
      expect(el.name, 'Header');
      expect(el.type, 'Text');
      expect(el.data, 'I am a header!');
    });

    test('Should require a name key present', (){
      expectArgumentError(JsonElementFactory.Text(name: null), 'A name for Text must be provided!');
    });

    test('Should require a data key present', (){
      expectArgumentError(JsonElementFactory.Text(data: null), 'A data for Text must be provided!');
    });

    test('Should require name to be not empty string', (){
      expectArgumentError(JsonElementFactory.Text(name: ''), 'A name for Text must be provided!');
    });

    test('Should require data to be not empty string', (){
      expectArgumentError(JsonElementFactory.Text(data: ''), 'A data for Text must be provided!');
    });
  });
}