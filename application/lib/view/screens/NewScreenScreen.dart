import 'package:application/model/Application.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Task.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/AppBar.dart';
import 'package:application/view/widgets/ButtonWidget.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:application/view/widgets/RoundedCombobox.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

class NewScreenScreen extends BaseScreen {
  @override
  Widget content() {
    return Text("Hello World!");
  }
}
