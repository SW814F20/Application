enum Status {
  notStarted,
  workInProgress,
  done,
}

enum Priority { low, medium, high, critical }

class Task {
  Task({this.taskName, this.taskStatus, this.taskPriority, this.newInformation = false});
  String taskName;
  Status taskStatus;
  Priority taskPriority;
  bool newInformation;
}
