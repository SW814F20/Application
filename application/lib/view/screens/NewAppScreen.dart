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
  final RoundedTextField appNameInput = RoundedTextField('app_name', 'Application name');
  final RoundedTextField appUser = RoundedTextField('User', 'Username of owner of repository');
  final ApplicationBloc applicationBloc = di.getDependency<ApplicationBloc>();

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        child: Column(
          children: <Widget>[
            appNameInput,
            appUser,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Button(
                text: 'Create Application',
                onPressed: () => {createApplication()},
              ),
            )
          ],
        ),
      ),
    );
  }

  void createApplication() async {
    final String applicationName = appNameInput.controller.text.replaceAll('\t', '');
    final String applicationUser = appUser.controller.text.replaceAll('\t', '');
    final bool success = await applicationBloc.addApplication(
        8, applicationName, Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1), applicationUser);
    if (success) {
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return NotifyDialog(
              title: 'Application created',
              description: 'The application \'' + applicationName + '\' has been created',
              key: const Key('applicationCreatedKey'),
              function: () => Routes.pop(context),
            );
          });
    } else {
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return NotifyDialog(
              title: 'Application creation failed',
              description: 'The application ' +
                  applicationName +
                  ' was not created, because an error happened.\nPlease check your connection and try again',
              key: const Key('applicationCreatedKey'),
              function: () => <void>{},
            );
          });
    }
  }

  @override
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Create new application'),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(contextObject.getOutput()),
      ),
    );
  }
}
