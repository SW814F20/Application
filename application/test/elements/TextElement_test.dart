import 'package:application/elements/TextElement.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TextElement should return type and name, when calling display', (){
    final el = TextElement('Headline', 0);

    expect(el.display(), 'Text: Headline');
  });

  test('TextElement should return type and position, when calling display and name is null', (){
    final el = TextElement(null, 0);

    expect(el.display(), 'Text: 0');
  });

  test('TextElement should be able to serialize to json', (){
    final el = TextElement('Headline', 0);

    expect(el.toJson(), '{"type": "Text", "name": "Headline", "position": 0}');
  });

  group('TextElement Settings Widget', () {
    TextElement el;

    setUp((){
      el = TextElement('The name', 0);
    });

    test('Should have a setting for name', (){
      expect(el.getSettingsWidgets()[0] is RoundedTextField, isTrue);
    });

    test('Should provide save settings as last widget', (){
      expect((el.getSettingsWidgets().last is RaisedButton), isTrue);
      expect((el.getSettingsWidgets().last as RaisedButton).onPressed, el.saveSettings);
    });

    test('Should set name when clicking save-button', () {
      RoundedTextField nameField = el.getSettingsWidgets()[0];

      nameField.controller.text = 'New name';

      el.saveSettings();

      expect(el.name, 'New name');
    });

    test('Should call super saveSettings', (){
      el.onSave = (TextElement cbEl) {
        cbEl.name = 'Success!';
      };
      RoundedTextField nameField = el.getSettingsWidgets()[0];
      nameField.controller.text = 'This name should get overridden by super call';

      el.saveSettings();

      expect(el.name, 'Success!');
    });

  });
}