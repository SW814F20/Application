import 'package:application/elements/TextInputElement.dart';
import 'package:application/model/ConfigState.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

class ConfigurationTextInputScreenState extends ConfigState {
  ConfigurationTextInputScreenState({this.element}) {
    readOnly = element.readOnly;
    widgetName.controller.text = element.name;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings for: ' + element.display()),
      ),
      body: SingleChildScrollView(
              child: Padding(
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
                  const Text('Should text be obscured?'),
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
                  const Text('Should use auto correct?'),
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
                  const Text('Should come with suggestions?'),
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
                  const Text('Should be enabled?'),
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
