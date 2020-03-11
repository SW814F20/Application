import 'package:application/model/Application.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Task.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/AppBar.dart';
import 'package:application/view/widgets/ButtonWidget.dart';
import 'package:application/view/widgets/RoundedCombobox.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends BaseScreen {
  NewTaskScreen(this.app);

  final Application app;

  final RoundedTextField taskName = RoundedTextField(
    "taskNameFieldKey",
    "Task name",
  );

  final RoundedCombobox taskPriority = RoundedCombobox<Priority>(
    [
      KeyValuePair(Priority.low, "Low"),
      KeyValuePair(Priority.medium, "Medium"),
      KeyValuePair(Priority.high, "High"),
      KeyValuePair(Priority.critical, "Critical"),
    ],
    label: true,
    labelText: "Priority",
  );

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              taskName,
              taskPriority,
              Button(
                text: "Create Task",
                onPressed: () => {createTask()},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createTask() {
    this
        .app
        .tasks
        .add(new Task(taskName: this.taskName.getValue(), taskPriority: this.taskPriority.getValue(), taskStatus: Status.notStarted));
    Routes.pop(this.contextObject.getOutput());
  }

  @override
  Widget appBar() {
    return CustomAppBar(
      title: app.appName + " - Create new task",
      centerTitle: true,
    );
  }
}
