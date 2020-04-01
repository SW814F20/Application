import 'package:application/model/Json.dart';

class User implements Json {
  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        username = json['username'],
        token = json['token'];

  final String username;

  final String firstName;

  final String lastName;

  final String token;

  bool getLoggedIn() {
    return token != null;
  }

  @override
  String toJson() {
    return '''
    {
      \"firstName\": \"$this->firstname\",
      \"lastName\": \"$this->lastname\",
      \"username\": \"$this->username\",
    }
  ''';
  }
}
