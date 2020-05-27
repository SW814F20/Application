import 'dart:ui';
import 'package:application/blocs/TaskBloc.dart';
import 'package:application/model/CustomColor.dart';
import 'package:application/model/Json.dart';
import 'package:application/providers/GithubApi.dart';

class Application implements Json {
  Application({this.id, this.appName, this.color, this.user}) {
    taskBloc = TaskBloc(this);
  }

  Application.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    user = json['user'];
    id = json['id'];
    color = CustomColor(json['appColor']);
    githubApi = GithubApi(user, repository());
  }

  GithubApi githubApi;
  String repository() => appName.replaceAll(' ', '-');
  TaskBloc taskBloc;
  int id;
  String appName;
  Color color;
  String user;

  @override
  String toJson() {
    return '''
    {
      "appName": "$appName",
      "repository": "$repository",
      "user": "$user",
    }
    ''';
  }
}
