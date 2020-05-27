import 'package:application/view/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:application/bootstrap.dart';
import 'package:application/providers/environment_provider.dart' as environment;
import 'package:application/providers/github_provider.dart' as github_provider;

void main() {
  // Register all dependencies for injector

  Bootstrap.register();
  WidgetsFlutterBinding.ensureInitialized();

  if (_isInDebugMode) {
    // If in DEBUG mode
    github_provider.setFile('assets/github.json').whenComplete(() {
      environment.setFile('assets/environments.json').whenComplete(() {
        _runApp();
      });
    });
  } else {
    // Else Production
    github_provider.setFile('assets/github.json').whenComplete(() {
      environment.setFile('assets/environments.prod.json').whenComplete(() {
        _runApp();
      });
    });
  }
}

/// Stores the last state of being logged in
bool lastState = false;

/// Stores if this is first time,
/// since this fixes a bug with logging in first time
bool first = true;

void _runApp() {
  runApp(MaterialApp(title: 'App Planner', theme: ThemeData(fontFamily: 'Quicksand'), home: LoginScreen()));
}

bool get _isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
