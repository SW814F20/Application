import 'package:application/di.dart';
import 'package:application/providers/BaseApi.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/AppBar.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:application/view/widgets/PrimaryButtonWidget.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterUserScreen extends BaseScreen {
  final BaseApi api = di.getDependency<BaseApi>();

  final RoundedTextField username = RoundedTextField(
    'usernameField',
    'Username',
  );

  final RoundedTextField firstname = RoundedTextField(
    'firstnameField',
    'Firstname',
  );

  final RoundedTextField lastname = RoundedTextField(
    'lastnameField',
    'Lastname',
  );

  final RoundedTextField password = RoundedTextField(
    'passwordField',
    'Password',
    obscureText: true,
  );

  final RoundedTextField confirmPassword = RoundedTextField(
    'confirmPasswordField',
    'Confirm password',
    obscureText: true,
  );

  @override
  Widget content() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              firstname,
              lastname,
              username,
              password,
              confirmPassword,
              PrimaryButton(
                onPressed: createUser,
                text: 'Create user',
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
      title: 'Create new user',
      centerTitle: true,
    );
  }

  Future<bool> createUser() async {
    final String username = this.username.getValue();
    final String firstname = this.firstname.getValue();
    final String lastname = this.lastname.getValue();
    final String password = this.password.getValue();
    final String passwordConfirm = confirmPassword.getValue();

    if (password == passwordConfirm) {
      final bool result = await api.createUser(username, firstname, lastname, password);
      if (result) {
        // User created successful
        showDialog<Center>(
            barrierDismissible: false,
            context: contextObject.getOutput(),
            builder: (BuildContext context) {
              return NotifyDialog(
                title: 'Success',
                description: 'User created successfuly!',
                key: const Key('UserCreated'),
                function: () => {Routes.pop(contextObject.getOutput())},
              );
            });
        return true;
      } else {
        // Server error
        showDialog<Center>(
            barrierDismissible: false,
            context: contextObject.getOutput(),
            builder: (BuildContext context) {
              return const NotifyDialog(title: 'Server Error', description: 'User creation refused', key: Key('ServerError'));
            });
        return false;
      }
    } else {
      // Password and confirm password does not match
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return const NotifyDialog(title: 'Input Error', description: 'Password does not match', key: Key('PasswordsDoesNotMatch'));
          });
      return false;
    }
  }

  void serverTimeout() {
    showDialog<Center>(
        barrierDismissible: false,
        context: contextObject.getOutput(),
        builder: (BuildContext context) {
          return const NotifyDialog(title: 'Server Error', description: 'Server timed out!\nPlease try again', key: Key('ServerError'));
        });
  }
}
