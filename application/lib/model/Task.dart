import 'dart:convert';

import 'package:application/model/Application.dart';
import 'package:application/model/Json.dart';
import 'package:application/model/github/Issue.dart';
import 'package:application/model/github/Label.dart';
import 'package:application/providers/BaseApi.dart';

enum Status {
  notStarted,
  workInProgress,
  done,
}

enum Priority { low, medium, high, critical }

class Task implements Json {
  Task({this.taskName, this.appId, this.screenId, this.taskDescription = '', this.application});

  @override
  Task.fromJson(this.application, Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['name'];
    appId = json['appId'];
    taskDescription = json['description'];
    screenId = <int>[];
    json['screenId'].forEach((dynamic element) {
      screenId.add(element);
    });
    issueUrl = json['issueUrl'];
  }
  Application application;
  String taskName;
  Status taskStatus;
  String taskDescription;
  int appId;
  int id;
  Priority taskPriority = Priority.low;
  bool newInformation = false;
  List<int> screenId;
  Issue githubIssue;
  String issueUrl;

  Future<Task> getGithubInformation() async {
    githubIssue = await application.githubApi.getIssue(issueUrl);
    setGithubInformation(githubIssue);
    return this;
  }

  void setGithubInformation(Issue issue) {
    taskStatus = getStatusFromGithubIssue(issue);
    taskPriority = getPriorityFromGithubIssue(issue);
    githubIssue = issue;
  }

  Status getStatusFromGithubIssue(Issue issue) {
    Status status;
    for (Label label in issue.labels) {
      try {
        status = BaseApi.convertStringToStatus(label.name);
      } catch (exception) {
        // Ignore
      }
    }
    return status;
  }

  Priority getPriorityFromGithubIssue(Issue issue) {
    Priority priority;
    for (Label label in issue.labels) {
      try {
        priority = BaseApi.convertStringToPriority(label.name);
      } catch (exception) {
        // Ignore
      }
    }
    return priority;
  }

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
