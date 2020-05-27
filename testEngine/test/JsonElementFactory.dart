import 'dart:convert';

class JsonElementFactory {

  static Map<String, dynamic> TextInput({
    name = 'Username',
    readOnly = false,
    obscureText = false,
    autoCorrect = true,
    enableSuggestions = true,
    enabled = true
  }){
    var _name = (name != null) ? '"name":"$name",' : '';
    var _readOnly = (readOnly != null) ? '"readOnly": $readOnly,' : '';
    var _obscureText = (obscureText != null) ? '"obscureText":  $obscureText,' : '';
    var _autoCorrect = (autoCorrect != null) ? '"autoCorrect":  $autoCorrect,': '';
    var _enableSuggestions = (enableSuggestions != null) ? '"enableSuggestions": $enableSuggestions,' : '';
    var _enabled = (enabled != null) ? '"enabled": $enabled,': '';

    return _combineAndDecode('TextInput', [_name, _readOnly, _obscureText, _autoCorrect, _enableSuggestions, _enabled]);
  }

  static Map<String, dynamic> Button({name = 'Login', text = 'Login'}){
    var _name = (name != null) ? '"name":"$name",' : '';
    var _text = (text != null) ? '"text":"$text",' : '';

    return _combineAndDecode('Button', [_name, _text]);
  }

  static Map<String, dynamic> Text({name = 'Text Widget', data = 'I am a Text Widget'}) {
    var _name = (name != null) ? '"name":"$name",' : '';
    var _data = (data != null) ? '"data":"$data",' : '';

    return _combineAndDecode('Text', [_name, _data]);
  }

  static Map<String, dynamic> _combineAndDecode(String type, List<String> attr){
    var _combinedFields = '';

    attr.forEach((field) {
      _combinedFields += field;
    });

    return json.decode('{"type": "$type", ${_combinedFields.substring(0,_combinedFields.length-1)}}');
  }


}