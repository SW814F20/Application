import 'dart:convert';

import 'package:application/model/Task.dart';
import 'package:application/model/github/Issue.dart';
import 'package:application/model/github/Label.dart';
import 'package:application/providers/BaseApi.dart';
import 'package:http/http.dart' as http;
import 'package:application/providers/github_provider.dart' as github_provider;

class GithubApi extends BaseApi {
  GithubApi(this.user, this.repository) : super('https://api.github.com/repos/$user/$repository/');
  String user;
  String repository;

  String oauthToken() => github_provider.getVar<String>('token');

  Future<List<Issue>> getIssues() async {
    final http.Response response = await performCall('issues', [], HttpMethod.GET);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final dynamic json = jsonDecode(
        response.body,
      );
      final List<Issue> issues = <Issue>[];
      for (var elem in json) {
        issues.add(Issue.fromJson(elem));
      }
      return issues;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call.\nhttp status code:' + response.statusCode.toString());
    }
  }

  Future<Issue> getIssue(String url) async {
    final http.Response response = await performCallToUrl(url, [], HttpMethod.GET);
    if (response.statusCode == 200) {
      return Issue.fromJson(jsonDecode(
        response.body,
      ));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call.\nhttp status code:' + response.statusCode.toString());
    }
  }

  Future<Issue> createIssue(String title, String body, Priority priority) async {
    final String statusString = BaseApi.convertStatusToString(Status.notStarted);
    final String priotiryString = BaseApi.convertPriorityToString(priority);
    final String labelsString = '\"$priotiryString\",\"$statusString\"';
    final String data = '''
        {
      "title": "$title",
      "body": "$body",
      "labels": [
        $labelsString
      ]
    }
    ''';
    final http.Response response = await performCall('issues', [], HttpMethod.POST, body: data, oauthToken: oauthToken());
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response, then parse the JSON.
      return Issue.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response, then throw an exception.
      throw Exception('Failed to perform call.\nhttp status code:' + response.statusCode.toString());
    }
  }

  Future<List<Label>> getLabels() async {
    final http.Response response = await performCall('labels', [], HttpMethod.GET);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      final dynamic json = jsonDecode(
        response.body,
      );
      final List<Label> labels = <Label>[];
      for (var elem in json) {
        labels.add(Label.fromJson(elem));
      }
      return labels;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call.\nhttp status code:' + response.statusCode.toString());
    }
  }

  Future<bool> createLabel(String name, String color, String description) async {
    final String data = '''
        {
      "name": "$name",
      "color": "$color",
      "description": "$description"
    }
    ''';
    final http.Response response = await performCall('labels', [], HttpMethod.POST, body: data, oauthToken: oauthToken());
    if (response.statusCode == 201) {
      // If the server did return a 200 OK response, then parse the JSON.
      return true;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to perform call.\nhttp status code:' + response.statusCode.toString());
    }
  }

  Future<bool> createRepo(String name) async {
    final String data = '''
    {
      "name": "$name",
      "has_issues": true
    }
    ''';
    final http.Response response =
        await performCallToUrl('https://api.github.com/orgs/$user/repos', [], HttpMethod.POST, body: data, oauthToken: oauthToken());
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response, then parse the JSON.
      return true;
    } else {
      // If the server did not return a 201 CREATED response, then throw an exception.
      throw Exception('Failed to perform call.\nhttp status code:' + response.statusCode.toString());
    }
  }

  Future<bool> createMissingLabels() async {
    final List<Label> existingLabels = await getLabels();

    bool critialPriority = false;
    bool highPriority = false;
    bool mediumPriority = false;
    bool lowPriority = false;

    bool notStartedStatus = false;
    bool workInProgressStatus = false;
    bool doneStatus = false;

    existingLabels.forEach((Label elem) {
      switch (elem.name) {
        case 'Priority: Critical':
          critialPriority = true;
          break;
        case 'Priority: High':
          highPriority = true;
          break;
        case 'Priority: Medium':
          mediumPriority = true;
          break;
        case 'Priority: Low':
          lowPriority = true;
          break;
        case 'Status: Not Started':
          notStartedStatus = true;
          break;
        case 'Status: Work in Progress':
          workInProgressStatus = true;
          break;
        case 'Status: Done':
          doneStatus = true;
          break;
      }
    });

    if (!critialPriority) {
      createLabel('Priority: Critical', 'fc0303', 'This is the critical priority created by the ProductOwnerBot');
    }

    if (!highPriority) {
      createLabel('Priority: High', 'ffa600', 'This is the high priority created by the ProductOwnerBot');
    }

    if (!mediumPriority) {
      createLabel('Priority: Medium', 'ffff00', 'This is the medium priority created by the ProductOwnerBot');
    }

    if (!lowPriority) {
      createLabel('Priority: Low', '99ff00', 'This is the low priority created by the ProductOwnerBot');
    }

    if (!notStartedStatus) {
      createLabel('Status: Not Started', '989799', 'This is the Not started status created by the ProductOwnerBot');
    }

    if (!workInProgressStatus) {
      createLabel('Status: Work in Progress', '4000ff', 'This is the Work in Progress status created by the ProductOwnerBot');
    }

    if (!doneStatus) {
      createLabel('Status: Done', '00ff00', 'This is the Done status created by the ProductOwnerBot');
    }

    return true;
  }
}
