import 'package:application/view/screens/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:application/providers/environment_provider.dart' as environment;

class LoginScreen extends BaseScreen {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: this.body(context),
    );
  }

  /// This is the username control, that allows for username extraction
  final TextEditingController usernameCtrl = TextEditingController();

  /// This is the password control, that allows for password extraction
  final TextEditingController passwordCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: this.isKeyboardShown(context)
                ? Container()
                : Image(
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
                          padding: this.isInPortraitMode(context)
                              ? const EdgeInsets.fromLTRB(0, 20, 0, 10)
                              : const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                color: Colors.white),
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: TextField(
                              key: const Key('UsernameKey'),
                              style: const TextStyle(fontSize: 30),
                              keyboardType: TextInputType.text,
                              controller: usernameCtrl,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Brugernavn',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(170, 170, 170, 1)),
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                color: Colors.white),
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              key: const Key('PasswordKey'),
                              controller: passwordCtrl,
                              style: const TextStyle(fontSize: 30),
                              obscureText: true,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Adgangskode',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(170, 170, 170, 1)),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  // This is where the action for the submit happens
                                },
                                color: const Color.fromRGBO(48, 81, 118, 1),
                              ),
                            ),
                          ),
                        ),
                        // Autologin button, only used for debugging
                        environment.getVar<bool>('DEBUG')
                            ? Container(
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: const Text(
                                      'Auto-Fill',
                                      key: Key('AutoLoginKey'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      usernameCtrl.text = environment
                                          .getVar<String>('USERNAME');
                                      passwordCtrl.text = environment
                                          .getVar<String>('PASSWORD');
                                    },
                                    color: const Color.fromRGBO(48, 81, 118, 1),
                                  ),
                                ),
                              )
                            : Container(),
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
}
