import 'dart:convert';

import 'package:application/model/Json.dart';

enum Status {
  notStarted,
  workInProgress,
  done,
}

enum Priority { low, medium, high, critical }

class Task implements Json {
  Task({this.taskName, this.appId, this.screenId, this.taskDescription = ''});
  @override
  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'],
        appId = json['appId'],
        taskDescription = json['description'],
        screenId = json['screenId'];

  String taskName;
  Status taskStatus;
  String taskDescription;
  int appId;
  Priority taskPriority = Priority.low;
  bool newInformation = false;
  List<int> screenId;

  // TODO(ALL): Implement github url, depends on https://github.com/SW814F20/Application/issues/37
  // TODO(ALL): Implement github url https://github.com/SW814F20/Application/issues/38
  String issueUrl;

  // TODO(ALL): Implement github api, https://github.com/SW814F20/Application/issues/36

  @override
  String toJson() {
    final String screensAsJson = jsonEncode(screenId);
    return '''
    {
      "name": "$taskName",
      "appId": $appId,
      "screenId": $screensAsJson,
      "description": "$taskDescription"
    }''';
  }
}
