import 'package:application/model/github/Label.dart';
import 'package:application/model/github/User.dart';

import 'Milestone.dart';

class Issue {
  Issue.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    repositoryUrl = json['repository_url'];
    labelsUrl = json['labels_url'];
    commentsUrl = json['comments_url'];
    eventsUrl = json['events_url'];
    htmlUrl = json['html_url'];
    id = json['id'];
    nodeId = json['node_id'];
    title = json['title'];
    number = json['number'];
    user = User.fromJson(json['user']);
    json['labels'].map((dynamic label) => labels.add(Label.fromJson(label)));
    milestone = json['milestone'] == null ? null : Milestone.fromJson(json['milestone']);
  }

  String url;
  String repositoryUrl;
  String labelsUrl;
  String commentsUrl;
  String eventsUrl;
  String htmlUrl;
  int id;
  String nodeId;
  String title;
  int number;
  User user;
  List<Label> labels = <Label>[];
  String state;
  String locked;
  User assignee;
  List<User> assignees = <User>[];
  Milestone milestone;
  int comments;
  String createdAt;
  String updatedAt;
  String closedAt;
  String authorAssociation;
  String pullRequest;
  String body;
}
