// To parse this JSON data, do
//
//     final todoListUser = todoListUserFromJson(jsonString);

import 'dart:convert';

class TodoListUser {
  TodoListUser({
    this.user,
    this.image,
    this.todoList,
  });

  String user;
  String image;
  List<TodoList> todoList;
  Map<String, dynamic> jsonData;

  factory TodoListUser.fromRawJson(String str) =>
      TodoListUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodoListUser.fromJson(Map<String, dynamic> json) => TodoListUser(
        user: json["user"],
        image: json["image"],
        todoList: List<TodoList>.from(
            json["todoList"].map((x) => TodoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "image": image,
        "todoList": List<dynamic>.from(todoList.map((x) => x.toJson())),
      };

  Future<TodoListUser> loadTasks() {
    Map<String, dynamic> todoMap =
        TodoListUser.fromRawJson('assets/json/todo_list.json')
            as Map<String, dynamic>;
    print(todoMap);
    var todo = TodoListUser.fromJson(todoMap);
    return Future.value(todo);
  }
}

class TodoList {
  TodoList({
    this.todoId,
    this.todoType,
    this.todoStartDate,
    this.todoEndDate,
    this.todoStartTime,
    this.todoEndTime,
    this.todoName,
    this.completed,
    this.setReminder,
    this.reminderTime,
    this.snooze,
  });

  int todoId;
  TodoType todoType;
  String todoStartDate;
  String todoEndDate;
  String todoStartTime;
  String todoEndTime;
  String todoName;
  bool completed;
  bool setReminder;
  String reminderTime;
  bool snooze;

  factory TodoList.fromRawJson(String str) =>
      TodoList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodoList.fromJson(Map<String, dynamic> json) => TodoList(
        todoId: json["todoId"],
        todoType: todoTypeValues.map[json["todoType"]],
        todoStartDate: json["todoStartDate"],
        todoEndDate: json["todoEndDate"],
        todoStartTime: json["todoStartTime"],
        todoEndTime: json["todoEndTime"],
        todoName: json["todoName"],
        completed: json["completed"],
        setReminder: json["setReminder"],
        reminderTime: json["reminderTime"],
        snooze: json["snooze"],
      );

  Map<String, dynamic> toJson() => {
        "todoId": todoId,
        "todoType": todoTypeValues.reverse[todoType],
        "todoStartDate": todoStartDate,
        "todoEndDate": todoEndDate,
        "todoStartTime": todoStartTime,
        "todoEndTime": todoEndTime,
        "todoName": todoName,
        "completed": completed,
        "setReminder": setReminder,
        "reminderTime": reminderTime,
        "snooze": snooze,
      };
}

enum TodoType { PERSONAL, WORK, MEETING }

final todoTypeValues = EnumValues({
  "Meeting": TodoType.MEETING,
  "Personal": TodoType.PERSONAL,
  "Work": TodoType.WORK
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
