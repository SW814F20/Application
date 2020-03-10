import 'package:curl/curl.dart';
import 'package:http/http.dart' as http;

enum Endpoints { App, Group, User }
enum HttpMethod { GET, POST, PUT }

class BaseApi {
  BaseApi(this._url);

  String _url;

  Future<String> getData(Endpoints endpoint, List<String> parameters, HttpMethod method) async {
    String url = _url + "/" + endpoint.toString();
    for (String parameter in parameters) {
      url += "/" + parameter;
    }
    final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return response.body;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
