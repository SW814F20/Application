import 'package:application/model/Application.dart';
import 'package:application/model/Task.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/PlaceholderScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskScreen extends BaseScreen {
  TaskScreen(this.app);

  Application app;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return this.isInPortraitMode()
        ? DefaultTabController(length: 3, child: generateScaffolding())
        : generateScaffolding();
  }

  Widget generateScaffolding() {
    return Scaffold(
      appBar: this.isInPortraitMode()
          ? generateAppBarPortrait()
          : generateAppBarLandscape(),
      body: content(),
    );
  }

  @override
  Widget content() {
    return this.isInPortraitMode() ? contentPortrait() : contentLandscape();
  }

  Widget contentPortrait() {
    List<Widget> notStartedWidgets =
        convertTasksToWidgets(getTasks(Status.notStarted));
    List<Widget> workInProgressWidgets =
        convertTasksToWidgets(getTasks(Status.workInProgress));
    List<Widget> doneWidgets = convertTasksToWidgets(getTasks(Status.done));
    return TabBarView(children: [
      Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: notStartedWidgets,
          ),
        ),
        color: Color.fromRGBO(200, 200, 200, 1),
      ),
      Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: workInProgressWidgets,
          ),
        ),
        color: Colors.white,
      ),
      Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: doneWidgets,
          ),
        ),
        color: Colors.lightGreen,
      ),
    ]);
  }

  Widget convertTaskToWidget(Task task) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: GestureDetector(
        onTap: () => Routes.push(this.context, new PlaceholderScreen()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 90,
                child: Text(task.taskName),
              ),
              Expanded(
                flex: 10,
                child: task.newInformation
                    ? FaIcon(FontAwesomeIcons.exclamation)
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> convertTasksToWidgets(List<Task> tasks) {
    return tasks.map((task) => convertTaskToWidget(task)).toList();
  }

  List<Task> getTasks(Status status) {
    return this.app.tasks.where((task) => task.taskStatus == status).toList();
  }

  List<Task> getAllTasks(Status status) {
    return this.app.tasks;
  }

  Widget contentLandscape() {
    List<Widget> notStartedWidgets =
        convertTasksToWidgets(getTasks(Status.notStarted));
    List<Widget> workInProgressWidgets =
        convertTasksToWidgets(getTasks(Status.workInProgress));
    List<Widget> doneWidgets = convertTasksToWidgets(getTasks(Status.done));
    return Column(
      children: <Widget>[
        _columnHeader(),
        Row(
          children: <Widget>[
            Expanded(
                flex: 33,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: notStartedWidgets,
                    ),
                  ),
                  color: Color.fromRGBO(200, 200, 200, 1),
                )),
            Expanded(
                flex: 33,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: workInProgressWidgets,
                    ),
                  ),
                  color: Colors.white,
                )),
            Expanded(
                flex: 33,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: doneWidgets,
                    ),
                  ),
                  color: Colors.lightGreen,
                )),
          ],
        )
      ],
    );
  }

  Widget generateAppBarLandscape() {
    return AppBar(
      centerTitle: true,
      title: Text(this.app.appName + " - Select Task"),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(this.context),
      ),
    );
  }

  Widget _columnHeader() {
    return Row(children: <Widget>[
      Expanded(
          flex: 33,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.hourglass),
                Text("Not started"),
              ],
            ),
          )),
      Expanded(
          flex: 33,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.cog),
                Text("WIP"),
              ],
            ),
          )),
      Expanded(
          flex: 33,
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.check),
                Text("Done"),
              ],
            ),
          )),
    ]);
  }

  Widget generateAppBarPortrait() {
    return AppBar(
      centerTitle: true,
      title: Text(this.app.appName + " - Select Task"),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(this.context),
      ),
      bottom: TabBar(
        tabs: [
          Tab(
              icon: Column(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.hourglass),
              Text("Not started"),
            ],
          )),
          Tab(
              icon: Column(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.cog),
              Text("WIP"),
            ],
          )),
          Tab(
              icon: Column(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.check),
              Text("Done"),
            ],
          )),
        ],
      ),
    );
  }
}
