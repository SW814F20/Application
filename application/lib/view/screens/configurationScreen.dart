import 'package:application/model/EditorScreenElement.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

abstract class ConfigState extends State<ConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class ConfigurationScreen extends StatefulWidget {
  ConfigurationScreen({Key key, this.element}) : super(key: key);

  EditorScreenElement element;

  @override
  ConfigState createState() {
    switch (element.type.toLowerCase()) {
      case 'text':
        return _ConfigurationTextScreenState(element: element);
        break;
      case 'button':
        return _ConfigurationButtonScreenState(element: element);
      default:
        return _ConfigurationTextScreenState(element: element);
        break;
    }
  }
}

class _ConfigurationButtonScreenState extends ConfigState {
  _ConfigurationButtonScreenState({this.element});

  EditorScreenElement element;
  final RoundedTextField test = RoundedTextField('textInput', 'Widget name');

  @override
  Widget build(BuildContext context) {
    test.controller.text = element.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings for: ' + element.display()),
      ),
      body: Column(
        children: <Widget>[
          test,
          RaisedButton(
            onPressed: () {
              element.name = test.controller.text;
              print(element.name);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}

class _ConfigurationTextScreenState extends ConfigState {
  _ConfigurationTextScreenState({this.element});

  EditorScreenElement element;
  final RoundedTextField test = RoundedTextField('textInput', 'Widget name');

  @override
  Widget build(BuildContext context) {
    test.controller.text = element.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings for: ' + element.display()),
      ),
      body: Column(
        children: <Widget>[
          test,
          RaisedButton(
            onPressed: () {
              element.name = test.controller.text;
              print(element.name);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
