import 'package:application/di.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/User.dart';
import 'package:application/providers/Sw814Api.dart';

class AuthenticationBloc {
  final Sw814Api _api = di.getDependency<Sw814Api>();
  User _user;
  bool loggedIn() => _user.getLoggedIn();

  Future<bool> login(String username, String password) async {
    final KeyValuePair<bool, User> loginResult = await _api.attemptLogin(username, password);

    if (loginResult.key) {
      _user = loginResult.value;
      return true;
    } else {
      return false;
    }
  }

  User getLoggedInUser() {
    return _user;
  }
}
