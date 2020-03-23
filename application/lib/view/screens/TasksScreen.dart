import 'package:application/model/Application.dart';
import 'package:application/model/Task.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/NewTaskScreen.dart';
import 'package:application/view/screens/PlaceholderScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskScreen extends BaseScreen {
  TaskScreen(this.app);

  final Application app;

  @override
  Widget build(BuildContext context) {
    contextObject.setOutput(context);
    return isInPortraitMode() ? DefaultTabController(length: 3, child: generateScaffolding()) : generateScaffolding();
  }

  Widget generateScaffolding() {
    return Scaffold(
      appBar: isInPortraitMode() ? generateAppBarPortrait() : generateAppBarLandscape(),
      body: content(),
    );
  }

  @override
  Widget content() {
    return isInPortraitMode() ? contentPortrait() : contentLandscape();
  }

  Widget contentPortrait() {
    final List<Widget> notStartedWidgets = convertTasksToWidgets(getTasks(Status.notStarted));
    final List<Widget> workInProgressWidgets = convertTasksToWidgets(getTasks(Status.workInProgress));
    final List<Widget> doneWidgets = convertTasksToWidgets(getTasks(Status.done));
    return TabBarView(children: [
      Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: notStartedWidgets,
          ),
        ),
        color: const Color.fromRGBO(200, 200, 200, 1),
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

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget convertTaskToWidget(Task task) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(border: Border.all()),
      child: GestureDetector(
        onTap: () => Routes.push(contextObject.getOutput(), PlaceholderScreen()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 25,
                child: Text(
                  capitalize(task.taskPriority.toString().substring(9)),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 90,
                child: Text(
                  task.taskName,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 10,
                child: task.newInformation ? FaIcon(FontAwesomeIcons.exclamation) : Container(),
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
    return app.tasks.where((task) => task.taskStatus == status).toList();
  }

  List<Task> getAllTasks(Status status) {
    return app.tasks;
  }

  Widget contentLandscape() {
    final List<Widget> notStartedWidgets = convertTasksToWidgets(getTasks(Status.notStarted));
    final List<Widget> workInProgressWidgets = convertTasksToWidgets(getTasks(Status.workInProgress));
    final List<Widget> doneWidgets = convertTasksToWidgets(getTasks(Status.done));
    return Column(
      children: <Widget>[
        _columnHeader(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: const Color.fromRGBO(200, 200, 200, 1),
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
      title: Text(app.appName + ' - Select Task'),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(contextObject.getOutput()),
      ),
      actions: <Widget>[
        createNewTaskButton(),
      ],
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
                const Text(
                  'Not started',
                  style: TextStyle(fontSize: 16),
                ),
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
                const Text(
                  'WIP',
                  style: TextStyle(fontSize: 16),
                ),
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
                const Text(
                  // ignore: prefer_const_constructors
                  'Done',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )),
    ]);
  }

  Widget generateAppBarPortrait() {
    return AppBar(
      centerTitle: true,
      title: Text(app.appName + ' - Select Task'),
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () => Routes.pop(contextObject.getOutput()),
      ),
      actions: <Widget>[
        createNewTaskButton(),
      ],
      bottom: TabBar(
        tabs: [
          Tab(
              icon: Column(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.hourglass),
              const Text('Not started'),
            ],
          )),
          Tab(
              icon: Column(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.cog),
              const Text('WIP'),
            ],
          )),
          Tab(
              icon: Column(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.check),
              const Text('Done'),
            ],
          )),
        ],
      ),
    );
  }

  Widget createNewTaskButton() {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.plus),
      onPressed: () => {Routes.push(contextObject.getOutput(), NewTaskScreen(app))},
    );
  }
}
