import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoTasksModel {
  int todoId;
  String todoType;
  String todoName;
  bool setReminder;
  bool completed;
  DateTime todoStartDate;

  TodoTasksModel({
    this.todoId,
    this.todoType,
    this.todoName,
    this.setReminder,
    this.completed,
    this.todoStartDate,
  });
}

class TodoTasksProvider extends ChangeNotifier {
  List<TodoTasksModel> myTodoList = [
    new TodoTasksModel(
      todoId: 1,
      todoType: "Personal",
      todoName: "Go jogging with Christin",
      setReminder: false,
      completed: true,
      todoStartDate: new DateTime(2021, 01, 09, 07, 00),
    ),
    new TodoTasksModel(
      todoId: 2,
      todoType: "Work",
      todoName: "Send project file",
      setReminder: true,
      completed: true,
      todoStartDate: new DateTime(2021, 01, 09, 10, 00),
    ),
    new TodoTasksModel(
      todoId: 3,
      todoType: "Meeting",
      todoName: "Meeting with client",
      setReminder: false,
      completed: true,
      todoStartDate: new DateTime(2021, 01, 09, 12, 00),
    ),
    new TodoTasksModel(
      todoId: 4,
      todoType: "Work",
      todoName: "Email client",
      setReminder: true,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 10, 15, 00),
    ),
    new TodoTasksModel(
      todoId: 5,
      todoType: "Personal",
      todoName: "Morning yoga",
      setReminder: false,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 10, 07, 00),
    ),
    new TodoTasksModel(
      todoId: 6,
      todoType: "Work",
      todoName: "Send project file",
      setReminder: true,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 10, 12, 00),
    ),
    new TodoTasksModel(
      todoId: 7,
      todoType: "Meeting",
      todoName: "Meeting with client",
      setReminder: true,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 11, 15, 00),
    ),
    new TodoTasksModel(
      todoId: 8,
      todoType: "Personal",
      todoName: "Morning yoga",
      setReminder: true,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 11, 07, 00),
    ),
    new TodoTasksModel(
      todoId: 9,
      todoType: "Meeting",
      todoName: "Meeting with client",
      setReminder: true,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 11, 10, 00),
    ),
    new TodoTasksModel(
      todoId: 10,
      todoType: "Study",
      todoName: "Study",
      setReminder: true,
      completed: false,
      todoStartDate: new DateTime(2021, 01, 12, 07, 00),
    ),
  ];

  void submitTask(String selectedTaskType, String todoTaskName, DateTime date,
      TimeOfDay time, BuildContext context) {
    int id = TodoTasksProvider().myTodoList.length;
    TodoTasksProvider().myTodoList.add(
          new TodoTasksModel(
            todoId: id,
            todoType: selectedTaskType,
            todoName: todoTaskName,
            setReminder: false,
            completed: false,
            todoStartDate: new DateTime(
                date.year, date.month, date.day, time.hour, time.minute),
          ),
        );
    Navigator.pop(context);
    notifyListeners();
  }
}
