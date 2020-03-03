import 'package:application/view/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:application/bootstrap.dart';
import 'package:application/providers/environment_provider.dart' as environment;

void main() {
  // Register all dependencies for injector
  Bootstrap.register();
  WidgetsFlutterBinding.ensureInitialized();
  if (_isInDebugMode) {
    // If in DEBUG mode
    environment.setFile('assets/environments.json').whenComplete(() {});
    _runApp();
  } else {
    // Else Production
    environment.setFile('assets/environments.prod.json').whenComplete(() {});
    _runApp();
  }
}

/// Stores the last state of being logged in
bool lastState = false;

/// Stores if this is first time,
/// since this fixes a bug with logging in first time
bool first = true;

void _runApp() {
  runApp(MaterialApp(
      title: 'App Planner',
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: LoginScreen()));
}

bool get _isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
