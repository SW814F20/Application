import 'dart:ui';
import 'package:application/model/Json.dart';
import 'package:application/model/Task.dart';
import 'package:application/providers/environment_provider.dart' as environment;

class Application implements Json {
  Application({this.id, this.appName, this.color, this.appUrl}) {
    if (environment.getVar<bool>('MOCK')) {
      mock();
    }
  }

  @override
  Application.fromJson(Map<String, dynamic> json)
      : appName = json['appName'],
        appUrl = json['appUrl'],
        id = json['id'];

  int id;
  String appName;
  Color color;
  String appUrl;
  List<Task> tasks = <Task>[];

  void mock() {
    tasks.add(Task(taskName: 'Create application', taskPriority: Priority.critical, taskStatus: Status.done, newInformation: false));
    tasks.add(Task(taskName: 'Move application', taskPriority: Priority.medium, taskStatus: Status.workInProgress, newInformation: false));
    tasks.add(Task(taskName: 'Create startup screen', taskPriority: Priority.high, taskStatus: Status.notStarted, newInformation: true));
    tasks.add(Task(taskName: 'Create login screen', taskPriority: Priority.low, taskStatus: Status.notStarted, newInformation: true));
    tasks.add(Task(
        taskName: 'Check username and password', taskPriority: Priority.medium, taskStatus: Status.workInProgress, newInformation: false));
    return;
  }

  @override
  String toJson() {
    return '''{
      "appName": "$appName",
      "appUrl": "$appUrl",
      "appColor": "$color"
    }
    ''';
  }
}
