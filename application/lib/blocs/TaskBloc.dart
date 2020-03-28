import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/Task.dart';

class TaskBloc extends ApiBloc {
  TaskBloc(this.applicationId);
  int applicationId;

  Future<List<Task>> getTasks() {
    return api.getTasks(applicationId, authenticationBloc.getLoggedInUser().token);
  }
}
