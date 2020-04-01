import 'dart:convert';
import 'dart:io';

import 'package:application/model/Application.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Screen.dart';
import 'package:application/model/Task.dart';
import 'package:application/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT, DELETE }

class BaseApi {
  BaseApi(this._url);

  final String _url;

  Future<http.Response> _performCall(String endpoint, List<String> parameters, HttpMethod method, String body, {String token = ''}) async {
    String url = _url + endpoint;
    for (String parameter in parameters) {
      url += '/' + parameter;
    }
    final Map<String, String> headers = <String, String>{};
    headers.addAll({HttpHeaders.contentTypeHeader: 'application/json'});
    if (token != '') {
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ' + token});
    }

    http.Response response;
    switch (method) {
      case HttpMethod.POST:
        response = await http.post(url, body: body, headers: headers);
        break;
      case HttpMethod.GET:
        response = await http.get(url, headers: headers);
        break;
      case HttpMethod.PUT:
        response = await http.put(url, body: body, headers: headers);
        break;
      case HttpMethod.DELETE:
        response = await http.delete(url, headers: headers);
        break;
    }
    return response;
  }

  Future<KeyValuePair<bool, User>> attemptLogin(String username, String password) async {
    final http.Response response = await _performCall(
        'User/Authenticate', [], HttpMethod.POST, '{\"username\": \"' + username + '\",\"password\": \"' + password + '\"}');

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
    final http.Response response = await _performCall('User/Register', [], HttpMethod.POST, data);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then the user has been created.
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<Application>> getApplications(String token) async {
    final http.Response response = await _performCall('App', [], HttpMethod.GET, '', token: token);
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
    final http.Response response = await _performCall('App/$id', [], HttpMethod.GET, '', token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final Application output = Application.fromJson(body);
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createApplications(String appName, String appUrl, Color color, String token) async {
    final String appColor = color.toString();
    final String data = '''
    {
      "appName": "$appName",
      "appUrl": "$appUrl",
      "appColor": "$appColor"
    }
    ''';
    final http.Response response = await _performCall('App/Create', [], HttpMethod.POST, data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> deleteApplication(String id, String token) async {
    final http.Response response = await _performCall('App/$id', [], HttpMethod.DELETE, '', token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> deleteUser(String id, String token) async {
    final http.Response response = await _performCall('User/$id', [], HttpMethod.DELETE, '', token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<User> getUserData(String id, String token) async {
    final http.Response response = await _performCall('User/$id', [], HttpMethod.GET, '', token: token);
    if (response.statusCode == 200) {
      final User outputUser = User.fromJson(jsonDecode(response.body));
      return outputUser;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<User>> getAllUsers(String token) async {
    final http.Response response = await _performCall('User', [], HttpMethod.GET, '', token: token);
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

  /// This method return a list of screens, given the access token of the user
  Future<List<Screen>> getAllScreens(String token) async {
    final http.Response response = await _performCall('Screen', [], HttpMethod.GET, '', token: token);
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
    final String data = '''{"screenName": "$screenName","screenContent": "$screenContent"}''';
    final http.Response response = await _performCall('Screen/Create', [], HttpMethod.POST, data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> updateScreen(int id, String screenName, String screenContent, String token) async {
    final String data = '''{"screenName": "$screenName","screenContent": "$screenContent"}''';
    final http.Response response = await _performCall('Screen/$id', [], HttpMethod.PUT, data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<List<Task>> getTasks(int applicationId, String token) async {
    final http.Response response = await _performCall('App/GetTask/$applicationId', [], HttpMethod.GET, '', token: token);
    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      final List<Task> output = <Task>[];
      for (var elem in body) {
        output.add(Task.fromJson(elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createTask(String name, int appId, List<int> screenId, String description, String token) async {
    final String ids = jsonEncode(screenId);
    final String data = '''
    {
    "name": "$name",
    "appId": $appId,
    "screenId": $ids,
    "description": "$description"
    }
    ''';
    final http.Response response = await _performCall('Task/Create', [], HttpMethod.POST, data, token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }
}
