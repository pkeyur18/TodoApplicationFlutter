class TodoTasksModel {
  int todoId;
  String todoType;
  String todoName;
  bool setReminder;
  bool completed;
  DateTime todoStartDate;
  static final columns = [
    "id",
    "todotype",
    "todoname",
    "setreminder",
    "completed",
    "todostartdate",
  ];

  TodoTasksModel({
    this.todoId,
    this.todoType,
    this.todoName,
    this.setReminder,
    this.completed,
    this.todoStartDate,
  });

  factory TodoTasksModel.fromMap(Map<String, dynamic> data) {
    return TodoTasksModel(
      todoId: data['id'],
      todoType: data['todotype'],
      todoName: data['todoname'],
      setReminder: data['setreminder'] == 0 ? true : false,
      completed: data['completed'] == 0 ? true : false,
      todoStartDate: DateTime.parse(data['todostartdate']),
    );
  }
  Map<String, dynamic> toMap() => {
        "id": todoId,
        "todotype": todoType,
        "todoname": todoName,
        "setreminder": setReminder ? 0 : 1,
        "completed": completed ? 0 : 1,
        "todostartdate": todoStartDate.toString(),
      };
}
