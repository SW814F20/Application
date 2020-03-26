import 'package:application/blocs/ApplicationBloc.dart';
import 'package:application/blocs/AuthenticationBloc.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Output.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/AppSelectionScreen.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/RegisterUserScreen.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:flutter/material.dart';
import 'package:application/providers/environment_provider.dart' as environment;
import 'package:application/di.dart';

class LoginScreen extends BaseScreen {
  final AuthenticationBloc authenticationBloc = di.getDependency<AuthenticationBloc>();
  final ApplicationBloc applicationBloc = di.getDependency<ApplicationBloc>();

  @override
  Widget build(BuildContext context) {
    contextObject.setOutput(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: content(),
    );
  }

  /// This is the username control, that allows for username extraction
  final TextEditingController usernameCtrl = TextEditingController();

  /// This is the password control, that allows for password extraction
  final TextEditingController passwordCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Output<bool> _loginPressed = Output(false);

  @override
  Widget content() {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: isInLandscapemode() ? const EdgeInsets.fromLTRB(0, 10, 0, 0) : const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: isKeyboardShown()
                ? Container()
                : const Image(
                    image: AssetImage('assets/giraf_splash_logo.png'),
                  ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: isInPortraitMode() ? const EdgeInsets.fromLTRB(0, 20, 0, 10) : const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white),
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: TextField(
                              key: const Key('UsernameKey'),
                              style: const TextStyle(fontSize: 30),
                              keyboardType: TextInputType.text,
                              controller: usernameCtrl,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Username',
                                hintStyle: TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white),
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              key: const Key('PasswordKey'),
                              controller: passwordCtrl,
                              style: const TextStyle(fontSize: 30),
                              obscureText: true,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Container(
                            child: Transform.scale(
                              scale: 1.5,
                              child: RaisedButton(
                                key: const Key('LoginBtnKey'),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // This is to disallow multiple login attempts at the same time
                                  if (!_loginPressed.getOutput()) {
                                    _loginPressed.setOutput(true);
                                    authenticationBloc
                                        .login(usernameCtrl.text, passwordCtrl.text)
                                        .then((bool result) => loginAttempt(contextObject.getOutput(), result))
                                        .timeout(const Duration(seconds: 5), onTimeout: loginTimeout);
                                  }

                                  // This is where the action for the submit happens
                                },
                                color: const Color.fromRGBO(48, 81, 118, 1),
                              ),
                            ),
                          ),
                        ),
                        // Autologin button, only used for debugging
                        (environment.getVar<bool>('DEBUG')
                            ? Container(
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                    child: const Text(
                                      'Auto-Fill',
                                      key: Key('AutoLoginKey'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      usernameCtrl.text = environment.getVar<String>('USERNAME');
                                      passwordCtrl.text = environment.getVar<String>('PASSWORD');
                                    },
                                    color: const Color.fromRGBO(48, 81, 118, 1),
                                  ),
                                ),
                              )
                            : Container()),
                        Container(
                          child: Transform.scale(
                            scale: 1.2,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: const Text(
                                'Create User',
                                key: Key('CreateUserKey'),
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => {Routes.push(contextObject.getOutput(), RegisterUserScreen())},
                              color: const Color.fromRGBO(48, 81, 118, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void loginAttempt(BuildContext context, bool successful) {
    if (successful) {
      _loginPressed.setOutput(false);
      applicationBloc.getApplications().then((value) => Routes.push(context, AppSelectionScreen(Output<List<Application>>(value))));
      // Login successful
    } else {
      _loginPressed.setOutput(false);
      showDialog<Center>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const NotifyDialog(title: 'Error', description: 'Wrong username and/or password', key: Key('WrongUsernameOrPassword'));
          });
      // Login failed
    }
  }

  void loginTimeout() {
    _loginPressed.setOutput(false);
    showDialog<Center>(
        barrierDismissible: false,
        context: contextObject.getOutput(),
        builder: (BuildContext context) {
          return const NotifyDialog(
              title: 'Timeout', description: 'The connection to the server timed out', key: Key('WrongUsernameOrPassword'));
        });
  }

  void registerUserScreen() {
    Routes.push(contextObject.getOutput(), RegisterUserScreen());
  }
}
