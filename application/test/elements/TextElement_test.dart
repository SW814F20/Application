import 'package:application/elements/TextElement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TextElement should return type and name, when calling display', (){
    var el = TextElement('Headline', 0);

    expect(el.display(), 'Text: Headline');
  });

  test('TextElement should return type and position, when calling display and name is null', (){
    var el = TextElement(null, 0);

    expect(el.display(), 'Text: 0');
  });

  test('TextElement should be able to serialize to json', (){
    var el = TextElement('Headline', 0);

    expect(el.toJson(), '{"type": "Text", "name": "Headline", "position": 0}');
  });
}