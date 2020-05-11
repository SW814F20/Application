import 'package:testEngine/testEngine.dart';

import '../../helpers.dart';

class TextInputElement extends UIElement {
  final String name;
  final bool readOnly;
  final bool obscureText;
  final bool autoCorrect;
  final bool enableSuggestions;
  final bool enabled;

  TextInputElement({this.name, this.readOnly, this.obscureText, this.autoCorrect, this.enableSuggestions, this.enabled}): super(type: 'TextInput');

  static TextInputElement fromJson(Map<String, dynamic> data){
    String name = data['name'];
    var _readOnly = data['readOnly'];
    var _obscureText = data['obscureText'];
    var _autoCorrect = data['autoCorrect'];
    var _enableSuggestions = data['enableSuggestions'];
    var _enabled = data['enabled'];

    if(name == null || name.isEmpty){
      throw ArgumentError('A name for TextInput must be provided!');
    }

    if(_readOnly == null) {
      throw ArgumentError('readOnly setting for TextInput must be provided!');
    }

    if(_obscureText == null){
      throw ArgumentError('obscureText setting for TextInput must be provided!');
    }

    if(_autoCorrect == null){
      throw ArgumentError('autoCorrect setting for TextInput must be provided!');
    }

    if(_enableSuggestions == null){
      throw ArgumentError('enableSuggestions setting for TextInput must be provided!');
    }
    var enabled;
    if(_enabled != null){
      enabled = Helpers.toBool(_enabled);
    } else {
      enabled = null;
    }

    var readOnly = Helpers.toBool(_readOnly);
    var obscureText = Helpers.toBool(_obscureText);
    var autoCorrect = Helpers.toBool(_autoCorrect);
    var enableSuggestions = Helpers.toBool(_enableSuggestions);

    return TextInputElement(name: name, readOnly: readOnly, obscureText: obscureText, autoCorrect: autoCorrect, enableSuggestions: enableSuggestions, enabled: enabled);
  }
}