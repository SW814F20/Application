import 'package:application/elements/ButtonElement.dart';
import 'package:application/model/ConfigState.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

class ConfigurationButtonScreenState extends ConfigState {
  ConfigurationButtonScreenState({this.element});

  ButtonElement element;

  final RoundedTextField widgetName =
      RoundedTextField('buttonNameField', 'Button name');
  final RoundedTextField widgetText =
      RoundedTextField('buttonTextField', 'Button Text');

  @override
  void dispose() {
    widgetName.controller.dispose();
    widgetText.controller.dispose();
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Column(
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
        ),
      ),
    );
  }
}
