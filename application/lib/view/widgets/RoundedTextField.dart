import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField(this._textFieldKey, this._hintText,
      {this.obscureText = false,
      this.padding = const EdgeInsets.fromLTRB(0, 10, 0, 10)});
  final bool obscureText;
  final String _textFieldKey;
  final String _hintText;

  final TextEditingController controller = new TextEditingController();

  final EdgeInsets padding;

  Widget build(BuildContext context) {
    return Padding(
      padding: this.padding,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white),
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          key: Key(this._textFieldKey),
          controller: controller,
          style: const TextStyle(fontSize: 30),
          obscureText: this.obscureText,
          decoration: InputDecoration.collapsed(
            hintText: this._hintText,
            hintStyle: TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  String getValue() {
    return this.controller.text;
  }
}
