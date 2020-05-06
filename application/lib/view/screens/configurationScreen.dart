import 'package:application/elements/ButtonElement.dart';
import 'package:application/elements/TextElement.dart';
import 'package:application/elements/TextInputElement.dart';
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
      case 'textinput':
        return _ConfigurationTextInputScreenState(element: element);
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
      RoundedTextField('textNameField', 'Text name');
  final RoundedTextField widgetText =
      RoundedTextField('textTextField', 'Text body');

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

class _ConfigurationTextInputScreenState extends ConfigState {
  _ConfigurationTextInputScreenState({this.element}) {
    readOnly = element.readOnly;
    obscureText = (element.obscureText == null) ? false : element.obscureText;
    autoCorrect = (element.autoCorrect == null) ? false : element.autoCorrect;
    enableSuggestions =
        (element.enableSuggestions == null) ? false : element.enableSuggestions;
    enabled = (element.enabled == null) ? false : element.enabled;
  }

  final TextInputElement element;
  bool readOnly;
  bool obscureText;
  bool autoCorrect;
  bool enableSuggestions;
  bool enabled;

  final RoundedTextField widgetName =
      RoundedTextField('textInputNameField', 'Text Input Name');

  @override
  void dispose() {
    widgetName.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widgetName.controller.text = element.name;

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
            Row(
              children: <Widget>[
                const Text('Should be read only?'),
                Switch(
                    value: readOnly,
                    onChanged: (value) {
                      setState(() {
                        readOnly = value;
                      });
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Should be obscure text'),
                Switch(
                    value: obscureText,
                    onChanged: (value) {
                      setState(() {
                        obscureText = value;
                      });
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Should use auto correct'),
                Switch(
                    value: autoCorrect,
                    onChanged: (value) {
                      setState(() {
                        autoCorrect = value;
                      });
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Should use come with suggestions'),
                Switch(
                    value: enableSuggestions,
                    onChanged: (value) {
                      setState(() {
                        enableSuggestions = value;
                      });
                    }),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Should be enabled'),
                Switch(
                    value: enabled,
                    onChanged: (value) {
                      setState(() {
                        enabled = value;
                      });
                    }),
              ],
            ),
            createSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget createSaveButton() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          element.name = widgetName.controller.text;
          element.readOnly = readOnly;
          element.obscureText = obscureText;
          element.autoCorrect = autoCorrect;
          element.enableSuggestions = enableSuggestions;
          element.enabled = enabled;
          Navigator.pop(context);
        },
        child: const Text('Save'),
      ),
    );
  }
}
