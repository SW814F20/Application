import 'dart:io';
import 'package:http/http.dart' as http;

enum HttpMethod { GET, POST, PUT, DELETE }

class BaseApi {
  BaseApi(this._url);
  final String _url;

  Future<http.Response> performCall(String endpoint, List<String> parameters, HttpMethod method,
      {String body = '', String token = ''}) async {
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
}
