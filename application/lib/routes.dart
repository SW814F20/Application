import 'package:flutter/material.dart';

/// Wrapper for Navigation class
class Routes {
  /// Push the given route onto the navigator that most tightly encloses the
  /// given context.
  static Future<T> push<T extends Object>(BuildContext context, Widget widget) {
    return Navigator.of(context).push<T>(
        MaterialPageRoute<T>(builder: (BuildContext context) => widget));
  }

  /// Pop the top-most route off the navigator that most tightly encloses the
  /// given context.
  static void pop<T extends Object>(BuildContext context, [T result]) {
    Navigator.of(context).pop<T>(result);
  }

  /// Go home is used to pop everything until the navigator is on the
  /// initialRoute.
  static void goHome(BuildContext context) {
    Navigator.of(context).popUntil((Route<dynamic> route) {
      return route.settings.isInitialRoute;
    });
  }
}
