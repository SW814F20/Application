import 'package:application/configurationElements/ConfigurationButtonScreenState.dart';
import 'package:application/configurationElements/ConfigurationTextInputScreenState.dart';
import 'package:application/configurationElements/ConfigurationTextScreenState.dart';
import 'package:application/model/ConfigState.dart';
import 'package:application/model/EditorScreenElement.dart';
import 'package:flutter/material.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({this.element});

  final EditorScreenElement element;

  @override
  ConfigState createState() {
    switch (element.type.toLowerCase()) {
      case 'text':
        return ConfigurationTextScreenState(element: element);
        break;
      case 'button':
        return ConfigurationButtonScreenState(element: element);
      case 'textinput':
        return ConfigurationTextInputScreenState(element: element);
      default:
        throw ArgumentError('Type not found in ConfigurationScreen');
        break;
    }
  }
}


