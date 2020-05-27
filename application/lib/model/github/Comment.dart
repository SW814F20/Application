import 'package:application/model/github/User.dart';

class Comment {
  Comment.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    htmlUrl = json['html_url'];
    id = json['id'];
    nodeId = json['node_id'];
    user = User.fromJson(json['user']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    body = json['body'];
  }

  String url;
  String htmlUrl;
  int id;
  String nodeId;
  String body;
  User user;
  String createdAt;
  String updatedAt;
}