import 'dart:convert';
import 'dart:io';

import 'package:application/model/Application.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/User.dart';
import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT }

class BaseApi {
  BaseApi(this._url);

  String _url;

  Future<http.Response> _getData(String endpoint, List<String> parameters, HttpMethod method, String body, {String token = ""}) async {
    String url = _url + endpoint;
    for (String parameter in parameters) {
      url += "/" + parameter;
    }
    Map<String, String> headers = new Map<String, String>();
    headers.addAll({HttpHeaders.contentTypeHeader: "application/json"});
    if (token != "") {
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer " + token});
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
    }
    return response;
  }

  Future<KeyValuePair<bool, User>> attemptLogin(String username, String password) async {
    http.Response response =
        await _getData("User/Authenticate", [], HttpMethod.POST, "{\"username\": \"" + username + "\",\"password\": \"" + password + "\"}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var json = jsonDecode(
        response.body,
      );
      return KeyValuePair(true, User.fromJson(json));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createUser(String username, String firstname, String lastname, String password) async {
    String data = "{\"firstName\": \"$firstname\", \"lastName\": \"$lastname\", \"username\": \"$username\",\"password\": \"$password\"}";
    http.Response response = await _getData("User/Register", [], HttpMethod.POST, data);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then the user has been created.
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // return false;
      throw Exception('Failed to perform call');
    }
  }

  Future<List<Application>> getApplications(String token) async {
    http.Response response = await _getData("App", [], HttpMethod.GET, "", token: token);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      List<Application> output = List<Application>();
      for (var elem in body) {
        output.add(Application.fromJson(elem));
      }
      return output;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // return false;
      throw Exception('Failed to perform call');
    }
  }

  Future<bool> createApplications(String appName, String appUrl, String token) async {
    http.Response response =
        await _getData("App/Create", [], HttpMethod.POST, "{\"appName\": \"$appName\",\"appUrl\": \"$appUrl/\"}", token: token);
    if (response.statusCode == 200) {
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      // return false;
      throw Exception('Failed to perform call');
    }
  }
}
