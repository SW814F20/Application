import 'package:application/elements/TextElement.dart';
import 'package:application/model/ConfigState.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

class ConfigurationTextScreenState extends ConfigState {
  ConfigurationTextScreenState({this.element});

  final TextElement element;
  final RoundedTextField widgetName =
      RoundedTextField('textNameField', 'Name');
  final RoundedTextField widgetText =
      RoundedTextField('textTextField', 'Body');

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
