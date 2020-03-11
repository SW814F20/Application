import 'package:application/di.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/User.dart';
import 'package:application/providers/BaseApi.dart';

class AuthenticationBloc {
  BaseApi _api = di.getDependency<BaseApi>();
  User _user;
  bool loggedIn() => _user.getLoggedIn();

  Future<bool> login(String username, String password) async {
    KeyValuePair<bool, User> loginResult = (await _api.attemptLogin(username, password));

    if (loginResult.key) {
      this._user = loginResult.value;
      return true;
    } else {
      return false;
    }
  }

  User getLoggedInUser() {
    return this._user;
  }
}
