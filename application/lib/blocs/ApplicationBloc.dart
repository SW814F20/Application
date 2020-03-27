import 'package:application/blocs/AuthenticationBloc.dart';
import 'package:application/di.dart';
import 'package:application/model/Application.dart';
import 'package:application/providers/BaseApi.dart';
import 'package:flutter/material.dart';

class ApplicationBloc {
  AuthenticationBloc authenticationBloc = di.getDependency<AuthenticationBloc>();
  BaseApi api = di.getDependency<BaseApi>();
  List<Application> data = <Application>[];

  Future<List<Application>> getApplications() async {
    data = await api.getApplications(authenticationBloc.getLoggedInUser().token);
    return data;
  }

  void mockData() {
    data.add(Application(id: 1, appName: 'App 1', color: Colors.red));
    data.add(Application(id: 2, appName: 'App 2', color: Colors.orange));
    data.add(Application(id: 3, appName: 'App 3', color: Colors.green));
    data.add(Application(id: 4, appName: 'App 4', color: Colors.yellow));
    data.add(Application(id: 5, appName: 'App 5', color: Colors.blue));
    data.add(Application(id: 6, appName: 'App 6', color: Colors.black));
    data.add(Application(id: 7, appName: 'App 7', color: Colors.grey));
    data.add(Application(id: 8, appName: 'App 8', color: Colors.purple));
    data.add(Application(id: 9, appName: 'App 9', color: Colors.lightGreen));
    data.add(Application(id: 10, appName: 'App 10', color: Colors.lightBlue));
    data.add(Application(id: 11, appName: 'App 11', color: Colors.teal));
    data.add(Application(id: 12, appName: 'App 12', color: Colors.lime));
    data.add(Application(id: 13, appName: 'App 13', color: Colors.brown));
    data.add(Application(id: 14, appName: 'App 14', color: Colors.greenAccent));
    return;
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
