import 'package:application/model/User.dart';

class Milestone {
  Milestone.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    htmlUrl = json['html_url'];
    labelsUrl = json['labels_url'];
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    number = json[number];
    title = json['title'];
    description = json['description'];
    creator = User.fromJson(json['creator']);
    openIssues = json['open_issues'];
    closedIssues = json['closed_issues'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dueOn = json['due_on'];
    closedAt = json['closed_at'];
  }

  String url;
  String htmlUrl;
  String labelsUrl;
  int id;
  String nodeId;
  String name;
  int number;
  String title;
  String description;
  User creator;
  int openIssues;
  int closedIssues;
  String state;
  String createdAt;
  String updatedAt;
  String dueOn;
  String closedAt;
}
