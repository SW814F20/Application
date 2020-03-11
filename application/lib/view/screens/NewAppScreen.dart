import 'dart:math';

import 'package:application/blocs/ApplicationBloc.dart';
import 'package:application/di.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/ButtonWidget.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewAppScreen extends BaseScreen {
  final RoundedTextField appNameInput = new RoundedTextField("app_name", "Application name");
  final ApplicationBloc applicationBloc = di.getDependency<ApplicationBloc>();

  Widget content() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        child: Column(
          children: <Widget>[
            appNameInput,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Button(
                text: "Create Application",
                onPressed: () => {createApplication()},
              ),
            )
          ],
        ),
      ),
    );
  }

  void createApplication() {
    String applicationName = this.appNameInput.controller.text;
    applicationBloc.addApplication(
        "8", applicationName, Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1));
    showDialog<Center>(
        barrierDismissible: false,
        context: this.contextObject.getOutput(),
        builder: (BuildContext context) {
          return NotifyDialog(
            title: 'Application created',
            description: 'The application ' + applicationName + ' has been created',
            key: Key('applicationCreatedKey'),
            function: () => Routes.pop(context),
          );
        });
  }

  @override
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Create new application"),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(this.contextObject.getOutput()),
      ),
    );
  }
}
