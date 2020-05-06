import 'dart:io';
import 'package:application/model/Task.dart' as task;
import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT, DELETE }

class BaseApi {
  BaseApi(this._url);

  final String _url;

  Future<http.Response> performCall(String endpoint, List<String> parameters, HttpMethod method,
      {String body = '', String token = '', String oauthToken = ''}) async {
    return performCallToUrl(_url + endpoint, parameters, method, body: body, token: token, oauthToken: oauthToken);
  }

  Future<http.Response> performCallToUrl(String url, List<String> parameters, HttpMethod method,
      {String body = '', String token = '', String oauthToken = ''}) async {
    for (String parameter in parameters) {
      url += '/' + parameter;
    }
    final Map<String, String> headers = <String, String>{};
    headers.addAll({HttpHeaders.contentTypeHeader: 'application/json'});

    if (token != '') {
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ' + token});
    }

    if (oauthToken != '') {
      headers.addAll({HttpHeaders.authorizationHeader: 'token ' + oauthToken});
      headers.addAll({'X-OAuth-Scopes': 'public_repo, user'});
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

  static task.Priority convertStringToPriority(String priority) {
    switch (priority) {
      case 'Priority: Critical':
        return task.Priority.critical;
      case 'Priority: High':
        return task.Priority.high;
      case 'Priority: Medium':
        return task.Priority.medium;
      case 'Priority: Low':
        return task.Priority.low;
      default:
        throw Exception('Invalid input');
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

  static String convertStatusToString(task.Status status) {
    switch (status) {
      case task.Status.notStarted:
        return 'Status: Not Started';
      case task.Status.workInProgress:
        return 'Status: Work in Progress';
      case task.Status.done:
        return 'Status: Done';
      default:
        throw Exception('Invalid input');
    }
  }
}
