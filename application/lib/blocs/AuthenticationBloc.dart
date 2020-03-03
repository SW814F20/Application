import 'package:application/model/User.dart';

class AuthenticationBloc {
  String _username;
  bool _loggedIn = false;

  bool loggedIn() {
    return _loggedIn;
  }

  bool login(String username, String password) {
    if (username == "admin" && password == "1234") {
      this._username = username;
      _loggedIn = true;
      return true;
    } else {
      _loggedIn = false;
      return false;
    }
  }

  User getLoggedInUser() {
    return new User(username: this._username);
  }
}
