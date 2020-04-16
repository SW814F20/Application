import 'dart:convert';

import 'package:application/model/Application.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Screen.dart';
import 'package:application/model/Task.dart';
import 'package:application/model/User.dart';
import 'package:application/providers/BaseApi.dart';
import 'package:application/providers/GithubApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Sw814Api extends BaseApi {
  Sw814Api(String url) : super(url);

  Future<KeyValuePair<bool, User>> attemptLogin(String username, String password) async {
    final http.Response response = await performCall('User/Authenticate', [], HttpMethod.POST,
        body: '{\"username\": \"' + username + '\",\"password\": \"' + password + '\"}');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final dynamic json = jsonDecode(
        response.body,
      );
      return KeyValuePair(true, User.fromJson(json));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createUser(String username, String firstname, String lastname, String password) async {
    final String data =
        '{\"firstName\": \"$firstname\", \"lastName\": \"$lastname\", \"username\": \"$username\",\"password\": \"$password\"}';
    final http.Response response = await performCall('User/Register', [], HttpMethod.POST, body: data);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then the user has been created.
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<Application>> getApplications(String token) async {
    final http.Response response = await performCall('App', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final List<Application> output = <Application>[];
      for (var elem in body) {
        output.add(Application.fromJson(elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<Application> getApplicationInformation(String id, String token) async {
    final http.Response response = await performCall('App/$id', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final Application output = Application.fromJson(body);
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createApplication(String appName, String user, Color color, String token) async {
    final String appColor = color.toString();
    final String repositoryName = appName.replaceAll(' ', '-');
    final String data = '''
    {
      "appName": "$appName",
      "repository": "$repositoryName",
      "user": "$user",
      "appColor": "$appColor"
    }
    ''';
    final http.Response response = await performCall('App/Create', [], HttpMethod.POST, body: data, token: token);
    if (response.statusCode == 200) {
      final GithubApi api = GithubApi(user, repositoryName);
      await api.createRepo(repositoryName).then((bool t) => {api.createMissingLabels()});
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> deleteApplication(String id, String token) async {
    final http.Response response = await performCall('App/$id', [], HttpMethod.DELETE, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> deleteUser(String id, String token) async {
    final http.Response response = await performCall('User/$id', [], HttpMethod.DELETE, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<User> getUserData(String id, String token) async {
    final http.Response response = await performCall('User/$id', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final User outputUser = User.fromJson(jsonDecode(response.body));
      return outputUser;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<User>> getAllUsers(String token) async {
    final http.Response response = await performCall('User', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final List<User> output = <User>[];
      for (var elem in body) {
        output.add(User.fromJson(elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<Screen>> getScreens(int id, String token) async {
    final http.Response response = await performCall('App/GetScreens/$id', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final List<Screen> output = <Screen>[];
      for (var elem in body) {
        output.add(Screen.fromJson(elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  /// This method return a list of screens, given the access token of the user
  Future<List<Screen>> getAllScreens(String token) async {
    final http.Response response = await performCall('Screen', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final List<Screen> output = <Screen>[];
      for (var elem in body) {
        output.add(Screen.fromJson(elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  /// This is used to create new Screens
  Future<bool> createScreen(String screenName, String screenContent, String token) async {
    final String data = '''
    {
      "screenName": "$screenName",
      "screenContent": "$screenContent"
    }''';
    final http.Response response = await performCall('Screen/Create', [], HttpMethod.POST, body: data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> updateScreen(int id, String screenName, String screenContent, String token) async {
    final String data = '''
    {
      "screenName": "$screenName",
      "screenContent": "$screenContent"
    }''';
    final http.Response response = await performCall('Screen/$id', [], HttpMethod.PUT, body: data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<Task>> getTasks(Application application, String token) async {
    final int applicationId = application.id;
    final http.Response response = await performCall('App/GetTask/$applicationId', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final List<Task> output = <Task>[];
      for (var elem in body) {
        output.add(Task.fromJson(application, elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createTask(String name, int appId, List<int> screenId, String description, String issueUrl, String token) async {
    final String ids = jsonEncode(screenId);
    final String data = '''
    {
      "name": "$name",
      "appId": $appId,
      "screenId": $ids,
      "description": "$description",
      "issueUrl": "$issueUrl"
    }
    ''';
    final http.Response response = await performCall('Task/Create', [], HttpMethod.POST, body: data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }

    // TODO(tricky12321): This needs to be implemented, https://github.com/SW814F20/Application/issues/34
    // ignore: dead_code, unused_element
    Future<bool> deleteTask(String id, String token) async {
      final http.Response response = await performCall('Task/$id', [], HttpMethod.DELETE, token: token);
      if (response.statusCode == 200) {
        return true;
      } else {
        // If the server did not return a 200 OK response, then throw an exception.
        throw Exception('Failed to perform call');
      }
    }
  }
}
