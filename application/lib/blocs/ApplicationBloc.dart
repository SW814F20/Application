import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/Application.dart';
import 'package:flutter/material.dart';

class ApplicationBloc extends ApiBloc {
  List<Application> data = <Application>[];
  Future<List<Application>> getApplications() {
    return api.getApplications(authenticationBloc.getLoggedInUser().token);
  }

  Future<bool> addApplication(
    int id,
    String name,
    Color color,
    String url,
  ) async {
    final bool success = await api.createApplications(name, url, color, authenticationBloc.getLoggedInUser().token);
    if (success) {
      data.add(Application(id: id, appName: name, color: color, appUrl: url));
      return true;
    } else {
      return false;
    }
  }
}
