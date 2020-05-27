import 'dart:async';

import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/EditorScreenElement.dart';
import 'package:application/model/Screen.dart';

class ScreenBloc extends ApiBloc {

  final StreamController<List<EditorScreenElement>> editorScreenStream  = StreamController<List<EditorScreenElement>>.broadcast();
  final StreamController<List<Screen>> screensStream  = StreamController<List<Screen>>.broadcast();

  Future<List<Screen>> getScreens(int id) {
    return api.getScreens(id, authenticationBloc.getLoggedInUser().token);
  }

  Future<Screen> createScreen(String screenName, String screenContent) async {
    return api.createScreen(
        screenName, screenContent, authenticationBloc.getLoggedInUser().token);
  }

  Future<bool> updateScreen(
      int id, String screenName, String screenContent) async {
    return api.updateScreen(id, screenName, screenContent,
        authenticationBloc.getLoggedInUser().token);
  }
}
