enum Status {
  notStarted,
  workInProgress,
  done,
}

enum Priority { low, medium, high, critical }

class Task {
  Task({this.taskName, this.taskStatus, this.taskPriority, this.taskDescription = '', this.newInformation = false});
  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'],
        taskStatus = json['taskStatus'],
        taskDescription = json['description'];

  String taskName;
  Status taskStatus;
  String taskDescription;
  Priority taskPriority;
  bool newInformation;
}
