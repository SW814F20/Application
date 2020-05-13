import 'package:application/blocs/NewTaskBloc.dart';
import 'package:application/blocs/ScreenBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Screen.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/AppBar.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:application/view/widgets/PrimaryButtonWidget.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewScreenScreen extends BaseScreen {
  NewScreenScreen({this.returnScreen = false});

  final bool returnScreen;

  final ScreenBloc screenBloc = di.getDependency<ScreenBloc>();
  final NewTaskBloc newTaskBloc = di.getDependency<NewTaskBloc>();

  final RoundedTextField screenName = RoundedTextField(
    'screenNameField',
    'Screen Name',
  );

  @override
  Widget content() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              screenName,
              PrimaryButton(
                onPressed: createScreen,
                text: 'Save',
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget appBar() {
    return const CustomAppBar(
      title: 'Create new screen',
      centerTitle: true,
    );
  }

  Future<bool> createScreen() async {
    final String screenName = this.screenName.getValue();
    final Screen createdScreen = await screenBloc.createScreen(screenName, '[]');

    if (screenName.trim().length > 1) {
      if (createdScreen != null) {
        // Screen created successful
        showDialog<Center>(
            barrierDismissible: false,
            context: contextObject.getOutput(),
            builder: (BuildContext context) {
              return NotifyDialog(
                title: 'Success',
                description: 'Screen created successfuly!',
                key: const Key('ScreenCreated'),
                function: () {
                  if (returnScreen) {
                    newTaskBloc.newScreensStream.add(createdScreen);
                  }
                  Routes.pop(contextObject.getOutput());
                },
              );
            });
        return true;
      } else {
        // Server error
        showDialog<Center>(
            barrierDismissible: false,
            context: contextObject.getOutput(),
            builder: (BuildContext context) {
              return const NotifyDialog(
                  title: 'Server Error',
                  description: 'Screen creation refused',
                  key: Key('ServerError'));
            });
        return false;
      }
    } else {
      //Scree name is empty
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return const NotifyDialog(
                title: 'Input Error',
                description: 'Screen name cannot be empty',
                key: Key('screenNameEmpty'));
          });
      return false;
    }
  }
}
