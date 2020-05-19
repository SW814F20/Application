import 'dart:io';
import 'package:application/model/Task.dart' as task;
import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT, DELETE, PATCH }

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
      case HttpMethod.PATCH:
        response = await http.patch(url, body: body, headers: headers);
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

  static String convertPriorityToString(task.Priority priority) {
    switch (priority) {
      case task.Priority.low:
        return 'Priority: Low';
      case task.Priority.medium:
        return 'Priority: Medium';
      case task.Priority.high:
        return 'Priority: High';
      case task.Priority.critical:
        return 'Priority: Critical';
      default:
        throw Exception('Invalid string');
    }
  }

  static task.Status convertStringToStatus(String status) {
    switch (status) {
      case 'Status: Done':
        return task.Status.done;
      case 'Status: Work in Progress':
        return task.Status.workInProgress;
      case 'Status: Not Started':
        return task.Status.notStarted;
      default:
        throw Exception('Invalid input');
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
