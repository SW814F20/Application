import 'package:application/blocs/TaskBloc.dart';
import 'package:application/model/Application.dart';
import 'package:application/model/Task.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/screens/DetailTaskScreen.dart';
import 'package:application/view/screens/NewTaskScreen.dart';
import 'package:application/view/widgets/ConfirmDIalog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskScreen extends BaseScreen {
  TaskScreen(this.app, this.taskBloc);
  final TaskBloc taskBloc;
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
    return StreamBuilder<List<Task>>(
      stream: taskBloc.tasks,
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if(snapshot.data == null){
          return const Text('Fetching tasks...');
        }
        final List<Widget> notStartedWidgets = convertTasksToWidgets(getTasks(snapshot.data, Status.notStarted));
        final List<Widget> workInProgressWidgets = convertTasksToWidgets(getTasks(snapshot.data, Status.workInProgress));
        final List<Widget> doneWidgets = convertTasksToWidgets(getTasks(snapshot.data, Status.done));
        return TabBarView(children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: notStartedWidgets,
              ),
            ),
            color: const Color.fromRGBO(200, 200, 200, 1),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: workInProgressWidgets,
              ),
            ),
            color: Colors.white,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: doneWidgets,
              ),
            ),
            color: Colors.lightGreen,
          ),
        ]);
      },
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget convertTaskToWidget(Task task) {
    if(task.taskStatus != Status.notStarted){
      return _createTaskWidgetItem(task);
    } else {
      return Dismissible(
        key: Key('task-'+task.id.toString()),
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.all(8),
          child: FaIcon(FontAwesomeIcons.trash, color: Colors.white,),
          alignment: AlignmentDirectional.centerEnd,
        ),
        direction: DismissDirection.endToStart,
        dismissThresholds: const { DismissDirection.endToStart: 0.4 },
        child: _createTaskWidgetItem(task),
        confirmDismiss: (_) async {
          return await showDialog(
              barrierDismissible: false,
              context: contextObject.getOutput(),
              builder: (BuildContext context) {
                return ConfirmDialog(
                  title: 'Delete',
                  description: 'Are you sure you want to delete?',
                  functionAbort: () => <void>{},
                  functionConfirm: () => { taskBloc.deleteTask(task) }
                );
              });


        },
      );
    }
  }

  Widget _createTaskWidgetItem(Task task){
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      child: GestureDetector(
        onTap: () => Routes.push(contextObject.getOutput(), DetailTaskScreen(task, taskBloc, app)),
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

  List<Task> getTasks(List<Task> tasksToSearchIn, Status status) {
    return tasksToSearchIn.where((task) => task.taskStatus == status).toList();
  }

  Widget contentLandscape() {
    return StreamBuilder(
      stream: taskBloc.tasks,
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if(snapshot.data == null){
          return const Text('Fetching tasks...');
        }
        final List<Widget> notStartedWidgets = convertTasksToWidgets(getTasks(snapshot.data, Status.notStarted));
        final List<Widget> workInProgressWidgets = convertTasksToWidgets(getTasks(snapshot.data, Status.workInProgress));
        final List<Widget> doneWidgets = convertTasksToWidgets(getTasks(snapshot.data, Status.done));
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
      },
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
      onPressed: () => {Routes.push(contextObject.getOutput(), NewTaskScreen(taskBloc))},
    );
  }
}
