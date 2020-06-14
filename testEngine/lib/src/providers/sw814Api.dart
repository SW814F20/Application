import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT, DELETE }

class Sw814Api{

  Sw814Api (this._url, {this.client}) {
    client ??= http.Client();
  }

  final String _url;
  http.Client client;

  Future<Map<String, dynamic>> attemptLogin(String username, String password) async {
    final response = await _performCall('User/Authenticate', [], HttpMethod.POST,
        body: '{"username": "$username","password": "$password"}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login operation failed, please ensure credentials are correct!');
    }
  }

  Future<List<Map<String, dynamic>>> getScreens(int appId, String token) async {
    final response = await _performCall('App/GetScreens/$appId', [], HttpMethod.GET, token: token);
    if (response.statusCode == 200) {
      final dynamic res = jsonDecode(response.body);

      if(res.isEmpty){
        throw Exception('Was not able to fetch screens, either none exists yet or the id of the app is not correct.');
      }

      final list = List<Map<String, dynamic>>();
      for(var item in res){
        item['screenContent'] = jsonDecode(item['screenContent'].toString().replaceAll('\'', '\"'));
        list.add(item);
      }
      return list;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Was not able to fetch screens, either the token is invalid or the service is down.');
    }
  }


  Future<http.Response> _performCall(String endpoint, List<String> parameters, HttpMethod method,
      {String body = '', String token = '', String oauthToken = ''}) async {
    return _performCallToUrl(_url + endpoint, parameters, method, body: body, token: token, oauthToken: oauthToken);
  }

  Future<http.Response> _performCallToUrl(String url, List<String> parameters, HttpMethod method,
      {String body = '', String token = '', String oauthToken = ''}) async {
    for (var parameter in parameters) {
      url += '/' + parameter;
    }
    final headers = <String, String>{};
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
        response = await client.post(url, body: body, headers: headers);
        break;
      case HttpMethod.GET:
        response = await client.get(url, headers: headers);
        break;
      case HttpMethod.PUT:
        response = await client.put(url, body: body, headers: headers);
        break;
      case HttpMethod.DELETE:
        response = await client.delete(url, headers: headers);
        break;
    }
    return response;
  }
}