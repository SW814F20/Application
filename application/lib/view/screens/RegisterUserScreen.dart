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
    "usernameField",
    "Username",
  );

  final RoundedTextField firstname = RoundedTextField(
    "firstnameField",
    "Firstname",
  );

  final RoundedTextField lastname = RoundedTextField(
    "lastnameField",
    "Lastname",
  );

  final RoundedTextField password = RoundedTextField(
    "passwordField",
    "Password",
    obscureText: true,
  );

  final RoundedTextField confirmPassword = RoundedTextField(
    "confirmPasswordField",
    "Confirm password",
    obscureText: true,
  );

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
                text: "Create user",
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget appBar() {
    return CustomAppBar(
      title: "Create new user",
      centerTitle: true,
    );
  }

  Future<bool> createUser() async {
    String username = this.username.getValue();
    String firstname = this.firstname.getValue();
    String lastname = this.lastname.getValue();
    String password = this.password.getValue();
    String passwordConfirm = this.confirmPassword.getValue();

    if (password == passwordConfirm) {
      bool result = await api.createUser(username, firstname, lastname, password);
      if (result) {
        // User created successful
        showDialog<Center>(
            barrierDismissible: false,
            context: this.contextObject.getOutput(),
            builder: (BuildContext context) {
              return NotifyDialog(
                title: 'Success',
                description: 'User created successfuly!',
                key: Key('UserCreated'),
                function: () => {Routes.pop(this.contextObject.getOutput())},
              );
            });
        return true;
      } else {
        // Server error
        showDialog<Center>(
            barrierDismissible: false,
            context: this.contextObject.getOutput(),
            builder: (BuildContext context) {
              return NotifyDialog(title: 'Server Error', description: 'User creation refused', key: Key('ServerError'));
            });
        return false;
      }
    } else {
      // Password and confirm password does not match
      showDialog<Center>(
          barrierDismissible: false,
          context: this.contextObject.getOutput(),
          builder: (BuildContext context) {
            return NotifyDialog(title: 'Input Error', description: 'Password does not match', key: Key('PasswordsDoesNotMatch'));
          });
      return false;
    }
  }

  void serverTimeout() {
    showDialog<Center>(
        barrierDismissible: false,
        context: this.contextObject.getOutput(),
        builder: (BuildContext context) {
          return NotifyDialog(title: 'Server Error', description: 'Server timed out!\nPlease try again', key: Key('ServerError'));
        });
  }
}
