import 'package:application/elements/TextElement.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TextElement should return type and name, when calling display', (){
    final el = TextElement('Headline', 0, 'text');

    expect(el.display(), 'Text: Headline');
  });

  test('TextElement should return type and position, when calling display and name is null', (){
    final el = TextElement(null, 0, 'text');

    expect(el.display(), 'Text: 0');
  });

  test('TextElement should be able to serialize to json', (){
    final el = TextElement('Headline', 0, 'text');

    expect(el.toJson(), '{"type": "Text", "name": "Headline", "data": "", "position": 0}');
  });
}