import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField(this._textFieldKey, this._hintText, {this.obscureText = false, this.padding = const EdgeInsets.fromLTRB(0, 10, 0, 10)});
  final bool obscureText;
  final String _textFieldKey;
  final String _hintText;

  final TextEditingController controller = TextEditingController();

  final EdgeInsets padding;

  String get hintText => _hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          key: Key(_textFieldKey),
          controller: controller,
          style: const TextStyle(fontSize: 30),
          obscureText: obscureText,
          decoration: InputDecoration.collapsed(
            hintText: _hintText,
            hintStyle: const TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  String getValue() {
    return controller.text;
  }
}
