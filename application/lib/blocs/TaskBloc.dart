import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/Task.dart';

class TaskBloc extends ApiBloc {
  TaskBloc(this.applicationId);
  int applicationId;

  Future<List<Task>> getTasks() {
    return api.getTasks(applicationId, authenticationBloc.getLoggedInUser().token);
  }

  Future<bool> createTask(String taskName, int appId, List<int> screenId, String description) async {
    return api.createTask(taskName, appId, screenId, description, authenticationBloc.getLoggedInUser().token);
  }
}
