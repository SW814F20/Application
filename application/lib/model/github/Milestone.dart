/*
      "url": "https://api.github.com/repos/aau-giraf/weekplanner/milestones/8",
            "html_url": "https://github.com/aau-giraf/weekplanner/milestone/8",
            "labels_url": "https://api.github.com/repos/aau-giraf/weekplanner/milestones/8/labels",
            "id": 5283526,
            "node_id": "MDk6TWlsZXN0b25lNTI4MzUyNg==",
            "number": 8,
            "title": "2020S2",
            "description": "",
            "creator": {
            },
            "open_issues": 29,
            "closed_issues": 0,
            "state": "open",
            "created_at": "2020-04-07T06:56:01Z",
            "updated_at": "2020-04-09T12:42:53Z",
            "due_on": "2020-05-01T07:00:00Z",
            "closed_at": null
 */
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
