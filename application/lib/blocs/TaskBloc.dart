import 'dart:async';
import 'dart:convert';

import 'package:application/blocs/ApiBloc.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Task.dart';
import 'package:application/model/github/Issue.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc extends ApiBloc {
  TaskBloc(this.application) {
    getTasks();
  }
  
  Application application;
  final BehaviorSubject<List<Task>> _tasks = BehaviorSubject<List<Task>>.seeded(<Task>[]);
  Stream<List<Task>> get tasks => _tasks.stream;
  List<Task> taskList = <Task>[];
  
  Future<bool> createTask(String taskName, int appId, List<int> screenId, String description, Priority priority) async {
    application.githubApi.createIssue(taskName, '', priority).then((newIssue) {
      api.createTask(taskName, appId, screenId, description, newIssue.url, authenticationBloc.getLoggedInUser().token).then((onValue) {
        final Task newTask = Task.fromJson(application, jsonDecode(onValue));
        newTask.getGithubInformation().then((task) {
          taskList.add(newTask);
          _tasks.add(taskList);
        });
      });
    });
    return true;
  }

  void getTasks() {
    api.getTasks(application, authenticationBloc.getLoggedInUser().token).then((value) {
      updateTasks(value);
      taskList = value;
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

  void deleteTask(Task task) {

    if(task.taskStatus != Status.notStarted){
      throw Exception('You can only delete task that has not been started yet !');
    }

    Issue githubIssue = task.githubIssue;
    githubIssue.state = 'closed';

    api.deleteTask(task.id.toString(), authenticationBloc.getLoggedInUser().token).then((_){
      application.githubApi.updateIssue(githubIssue).then((_) {
        taskList.remove(task);
        _tasks.add(taskList);
      });
    });
  }
}
