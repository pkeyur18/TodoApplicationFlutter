import 'dart:convert';

TodoTasksModel getTodoList() {
  TodoTasksModel data = TodoTasksModel.fromJson(jsonDecode(todoListJson));
  return data;
}

class TodoTasksModel {
  int todoId;
  String todoType;
  String todoName;
  bool setReminder;
  bool completed;
  DateTime todoStartDate;

  TodoTasksModel(
    this.todoId,
    this.todoType,
    this.todoName,
    this.setReminder,
    this.completed,
    this.todoStartDate,
  );

  factory TodoTasksModel.fromJson(dynamic json) {
    return TodoTasksModel(
      json['todoId'] as int,
      json['todoType'] as String,
      json['todoName'] as String,
      json['setReminder'] as bool,
      json['completed'] as bool,
      json['todoStartDate'] as DateTime,
    );
  }
}

List<TodoTasksModel> myTodoList = [
  new TodoTasksModel(
    1,
    "Personal",
    "Go jogging with Christin",
    false,
    true,
    new DateTime(2021, 01, 03, 07, 00),
  ),
  new TodoTasksModel(
    2,
    "Work",
    "Send project file",
    true,
    true,
    new DateTime(2021, 01, 03, 10, 00),
  ),
  new TodoTasksModel(
    3,
    "Meeting",
    "Meeting with client",
    false,
    true,
    new DateTime(2021, 01, 03, 12, 00),
  ),
  new TodoTasksModel(
    4,
    "Work",
    "Email client",
    true,
    false,
    new DateTime(2021, 01, 03, 15, 00),
  ),
  new TodoTasksModel(
    5,
    "Personal",
    "Morning yoga",
    false,
    false,
    new DateTime(2021, 01, 04, 07, 00),
  ),
  new TodoTasksModel(
    6,
    "Work",
    "Send project file",
    true,
    false,
    new DateTime(2021, 01, 04, 10, 00),
  ),
  new TodoTasksModel(
    7,
    "Meeting",
    "Meeting with client",
    true,
    false,
    new DateTime(2021, 01, 04, 15, 00),
  ),
  new TodoTasksModel(
    8,
    "Personal",
    "Morning yoga",
    true,
    false,
    new DateTime(2021, 01, 05, 07, 00),
  ),
  new TodoTasksModel(
    9,
    "Meeting",
    "Meeting with client",
    true,
    false,
    new DateTime(2021, 01, 05, 10, 00),
  ),
  new TodoTasksModel(
    10,
    "Personal",
    "Go jogging with Christin",
    true,
    false,
    new DateTime(2021, 01, 06, 07, 00),
  ),
];

String todoListJson =
    '{"todoId": 1, "todoType" : "Work", "todoStartTime": "07:00 AM","todoName":"Send project file", "completed":false, "setReminder":true}';
