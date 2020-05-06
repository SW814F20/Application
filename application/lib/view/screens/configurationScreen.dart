import 'package:application/elements/ButtonElement.dart';
import 'package:application/elements/TextElement.dart';
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
  const ConfigurationScreen({this.element});

  final EditorScreenElement element;

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

  ButtonElement element;

  final RoundedTextField widgetName =
      RoundedTextField('widgetNameField', 'Widget name');
  final RoundedTextField widgetText =
      RoundedTextField('widgetTextField', 'Widget Text');

  @override
  Widget build(BuildContext context) {
    widgetName.controller.text = element.name;
    widgetText.controller.text = element.text;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings for: ' + element.display()),
      ),
      body: Column(
        children: <Widget>[
          const Text('Widget Name'),
          widgetName,
          const Text('Widget Text'),
          widgetText,
          RaisedButton(
            onPressed: () {
              element.name = widgetName.controller.text;
              element.text = widgetText.controller.text;
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

  final TextElement element;
  final RoundedTextField widgetName =
      RoundedTextField('widgetNameField', 'Widget name');
  final RoundedTextField widgetText =
      RoundedTextField('widgetTextField', 'Widget Text');

  @override
  Widget build(BuildContext context) {
    widgetName.controller.text = element.name;
    widgetText.controller.text = element.text;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings for: ' + element.display()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Widget Name'),
            widgetName,
            const Text('Widget Text'),
            widgetText,
            Center(
              child: RaisedButton(
                onPressed: () {
                  element.name = widgetName.controller.text;
                  element.text = widgetText.controller.text;
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
