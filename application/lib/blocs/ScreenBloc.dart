import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/Screen.dart';

class ScreenBloc extends ApiBloc {
  Future<List<Screen>> getScreens(int id) {
    return api.getScreens(id, authenticationBloc.getLoggedInUser().token);
  }
}
