import 'dart:ui';
import 'package:application/blocs/TaskBloc.dart';
import 'package:application/model/CustomColor.dart';
import 'package:application/model/Json.dart';
import 'package:application/model/Task.dart';

class Application implements Json {
  Application({this.id, this.appName, this.color, this.appUrl}) {
    taskBloc = TaskBloc(id);
    taskBloc.getTasks().then((value) => value.forEach((element) {
          tasks.add(element);
        }));
  }
  Application.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    appUrl = json['appUrl'];
    id = json['id'];
    color = CustomColor(json['appColor']);
    taskBloc = TaskBloc(json['id']);
    taskBloc.getTasks().then((value) => value.forEach((element) {
          tasks.add(element);
        }));
  }

  TaskBloc taskBloc;
  int id;
  String appName;
  Color color;
  String appUrl;
  List<Task> tasks = <Task>[];

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
