import 'package:application/blocs/TaskBloc.dart';
import 'package:application/model/KeyValuePair.dart';
import 'package:application/model/Task.dart';
import 'package:application/routes.dart';
import 'package:application/view/screens/BaseScreen.dart';
import 'package:application/view/widgets/AppBar.dart';
import 'package:application/view/widgets/ButtonWidget.dart';
import 'package:application/view/widgets/NotifyDIalog.dart';
import 'package:application/view/widgets/RoundedCombobox.dart';
import 'package:application/view/widgets/RoundedTextField.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends BaseScreen {
  NewTaskScreen(this.taskBloc);
  final TaskBloc taskBloc;
  final RoundedTextField taskName = RoundedTextField(
    'taskNameFieldKey',
    'Task name',
  );

  final RoundedTextField description = RoundedTextField(
    'descriptionFieldKey',
    'Description',
  );

  final RoundedCombobox taskPriority = RoundedCombobox<Priority>(
    [
      KeyValuePair(Priority.low, 'Low'),
      KeyValuePair(Priority.medium, 'Medium'),
      KeyValuePair(Priority.high, 'High'),
      KeyValuePair(Priority.critical, 'Critical'),
    ],
    label: true,
    labelText: 'Priority',
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
              description,
              taskPriority,
              Button(
                text: 'Create Task',
                onPressed: createTask,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createTask() {
    final String taskNameString = taskName.getValue().replaceAll('\t', '');
    final String descriptionString = description.getValue().replaceAll('\t', '');
    taskBloc
        .createTask(taskNameString, taskBloc.application.id, [0], descriptionString, taskPriority.getValue())
        .then((value) => {returnCall(value)});
  }

  void returnCall(bool success) {
    if (success) {
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return NotifyDialog(
              title: 'Task created',
              description: 'The task has been created',
              key: const Key('applicationCreatedKey'),
              function: () => Routes.pop(contextObject.getOutput()),
            );
          });
    } else {
      showDialog<Center>(
          barrierDismissible: false,
          context: contextObject.getOutput(),
          builder: (BuildContext context) {
            return NotifyDialog(
              title: 'Task creation failed',
              description: 'The task was not created, because an error happened.\nPlease check your connection and try again',
              key: const Key('applicationCreatedKey'),
              function: () => <void>{},
            );
          });
    }
  }

  @override
  Widget appBar() {
    return CustomAppBar(
      title: taskBloc.application.appName + ' - Create new task',
      centerTitle: true,
    );
  }
}
