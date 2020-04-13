import 'dart:convert';

import 'package:application/model/github/Issue.dart';
import 'package:application/providers/BaseApi.dart';
import 'package:http/http.dart' as http;

class GithubApi extends BaseApi {
  GithubApi(this.user, this.repository) : super('https://api.github.com/repos/$user/$repository/');
  String user;
  String repository;

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
}
