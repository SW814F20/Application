import 'dart:async';

import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Task.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc extends ApiBloc {
  TaskBloc(this.application) {
    getTasks();
  }
  Application application;
  final BehaviorSubject<List<Task>> _tasks = BehaviorSubject<List<Task>>.seeded(<Task>[]);
  Stream<List<Task>> get tasks => _tasks.stream;

  Future<bool> createTask(String taskName, int appId, List<int> screenId, String description, Priority priority) async {
    application.githubApi.createIssue(taskName, '', priority).then((newIssue) {
      api.createTask(taskName, appId, screenId, description, newIssue.url, authenticationBloc.getLoggedInUser().token).then((onValue) {
        getTasks();
      });
    });
    return true;
  }

  void getTasks() {
    api.getTasks(application, authenticationBloc.getLoggedInUser().token).then((value) {
      updateTasks(value);
    });
  }

  void updateTasks(List<Task> taskList) {
    application.githubApi.getIssues().then((issues) {
      taskList.forEach((Task task) {
        task.setGithubInformation(issues.where((issue) => issue.url == task.issueUrl).first);
      });
      _tasks.add(taskList);
    });
  }
}
