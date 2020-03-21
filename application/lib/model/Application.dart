import 'dart:ui';
import 'package:application/model/Task.dart';
import 'package:application/providers/environment_provider.dart' as environment;

class Application {
  Application({this.id, this.appName, this.color, this.appUrl, this.owner}) {
    if (environment.getVar<bool>('MOCK')) {
      this.mock();
    }
  }

  Application.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        appUrl = json['appUrl'],
        id = json['id'];

  int id;
  String appName;
  Color color;
  String appUrl;
  List<Task> tasks = new List<Task>();
  int owner;

  void mock() {
    this
        .tasks
        .add(new Task(taskName: "Create application", taskPriority: Priority.critical, taskStatus: Status.done, newInformation: false));
    this.tasks.add(
        new Task(taskName: "Move application", taskPriority: Priority.medium, taskStatus: Status.workInProgress, newInformation: false));
    this
        .tasks
        .add(new Task(taskName: "Create startup screen", taskPriority: Priority.high, taskStatus: Status.notStarted, newInformation: true));
    this
        .tasks
        .add(new Task(taskName: "Create login screen", taskPriority: Priority.low, taskStatus: Status.notStarted, newInformation: true));
    this.tasks.add(new Task(
        taskName: "Check username and password", taskPriority: Priority.medium, taskStatus: Status.workInProgress, newInformation: false));
    return;
  }
}
