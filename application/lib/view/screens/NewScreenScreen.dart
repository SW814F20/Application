import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/AppBar.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:application/view/widgets/PrimaryButtonWidget.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewScreenScreen extends BaseScreen {
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
                onPressed: saveScreen,
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

  Future<bool> saveScreen() async {
    final String screenName = this.screenName.getValue();
    
    if (screenName.trim().length > 1) {
      if (true) {
        // User created successful
        showDialog<Center>(
            barrierDismissible: false,
            context: contextObject.getOutput(),
            builder: (BuildContext context) {
              return NotifyDialog(
                title: 'Success',
                description: 'Screen created successfuly!',
                key: const Key('ScreenCreated'),
                function: () => {Routes.pop(contextObject.getOutput())},
              );
            });
        return true;
      }
      // } else {
      //   // Server error
      //   showDialog<Center>(
      //       barrierDismissible: false,
      //       context: contextObject.getOutput(),
      //       builder: (BuildContext context) {
      //         return const NotifyDialog(title: 'Server Error', description: 'Screen creation refused', key: Key('ServerError'));
      //       });
      //   return false;
      // }
    } else {
      //Scree name is empty
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return const NotifyDialog(title: 'Input Error', description: 'Screen name cannot be empty', key: Key('screenNameEmpty'));
          });
      return false;
    }
  }
}
