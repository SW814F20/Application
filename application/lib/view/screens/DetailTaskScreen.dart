import 'dart:async';

import 'package:application/model/Application.dart';
import 'package:application/model/Task.dart';
import 'package:application/model/github/Comment.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailTaskScreen extends BaseScreen {
  DetailTaskScreen(this.task, this.application) {
    application.githubApi
        .getComments(task.githubIssue.number)
        .then((comments) => commentsStream.sink.add(comments));
  }

  final Task task;
  final Application application;

  final StreamController<List<Comment>> commentsStream =
      StreamController<List<Comment>>.broadcast();

  @override
  Widget content() {
    return isInPortraitMode()
        ? createPortraitLayout()
        : createLandscapeLayout();
  }

  Padding createLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                child: createTaskNameWidget(),
                height: getScreenHeight(),
              )),
              Expanded(
                  child: Container(
                      child: createCommentsWidget(),
                      height: getScreenHeight())),
            ],
          ),
        ),
      ),
    );
  }

  Padding createPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: createTaskNameWidget(),
              ),
              createCommentsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget createCommentsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Center(
            child: Text('Comments:',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: StreamBuilder<List<Comment>>(
                  stream: commentsStream.stream,
                  initialData: const [],
                  builder: (context, snapshot) {
                    return Text(commentsToString(snapshot.data));
                  }),
            ),
          ),
        ),
      ],
    );
  }

  String commentsToString(List<Comment> comments) {
    String data = '';
    for (var comment in comments) {
      data += comment.body + '\n\n';
    }
    return data;
  }

  Widget createTaskNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Center(
            child: Text('Task name:',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(task.githubIssue.title),
        )
      ],
    );
  }

  @override
  Widget appBar() {
    return AppBar(
        title: const Text('Task details'),
        centerTitle: true,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Routes.pop(contextObject.getOutput()),
        ));
  }
}
