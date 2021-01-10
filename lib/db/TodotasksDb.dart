import 'package:Todo/db/database.dart';
import 'package:Todo/model/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodotasksDBProvider extends ChangeNotifier {
  List<TodoTasksModel> tasks = new List();
  List<TodoTasksModel> todayTasks = new List();
  List<TodoTasksModel> tomorrowTasks = new List();
  List<TodoTasksModel> upcomingTasks = new List();
  List<TodoTasksModel> pastTasks = new List();
  TodoTasksModel latestTask;

  Future<List<TodoTasksModel>> getAllTodotasks() async {
    final db = await TodoDatabase.db.database;
    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
      orderBy: "id ASC",
    );

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      tasks.add(taskModel);
      notifyListeners();
    });
    return tasks;
  }

  Future<int> getPersonalTasksCount() async {
    final db = await TodoDatabase.db.database;
    int count = 0;
    var results = await db.rawQuery(
      "SELECT COUNT(*) as count FROM Todolists WHERE todotype = 'Personal'",
    );
    results.forEach((element) {
      count = element['count'];
    });
    return count;
  }

  Future<int> getWorkTasksCount() async {
    final db = await TodoDatabase.db.database;
    int count = 0;
    var results = await db.rawQuery(
      "SELECT COUNT(*) as count FROM Todolists WHERE todotype = 'Work'",
    );
    results.forEach((element) {
      count = element['count'];
    });
    return count;
  }

  Future<int> getMeetingTasksCount() async {
    final db = await TodoDatabase.db.database;
    int count = 0;
    var results = await db.rawQuery(
      "SELECT COUNT(*) as count FROM Todolists WHERE todotype = 'Meeting'",
    );
    results.forEach((element) {
      count = element['count'];
    });
    return count;
  }

  Future<int> getShoppingTasksCount() async {
    final db = await TodoDatabase.db.database;
    int count = 0;
    var results = await db.rawQuery(
      "SELECT COUNT(*) as count FROM Todolists WHERE todotype = 'Shopping'",
    );
    results.forEach((element) {
      count = element['count'];
    });
    return count;
  }

  Future<int> getStudyTasksCount() async {
    final db = await TodoDatabase.db.database;
    int count = 0;
    var results = await db.rawQuery(
      "SELECT COUNT(*) as count FROM Todolists WHERE todotype = 'Study'",
    );
    results.forEach((element) {
      count = element['count'];
    });
    return count;
  }

  Future<int> getPartyTasksCount() async {
    final db = await TodoDatabase.db.database;
    int count = 0;
    var results = await db.rawQuery(
      "SELECT COUNT(*) as count FROM Todolists WHERE todotype = 'Party'",
    );
    results.forEach((element) {
      count = element['count'];
    });
    return count;
  }

  Future<TodoTasksModel> getLatestTask() async {
    final db = await TodoDatabase.db.database;
    List<Map> result = await db.rawQuery(
        "SELECT * FROM Todolists WHERE todostartdate > datetime('now','localtime') ORDER BY todostartdate ASC Limit 1");

    result.forEach((element) {
      latestTask = TodoTasksModel.fromMap(element);
    });
    return latestTask;
  }

  Future<List<TodoTasksModel>> getTodayTasks() async {
    final db = await TodoDatabase.db.database;
    todayTasks = [];
    List<TodoTasksModel> tempList = new List();

    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
    );

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      tempList.add(taskModel);
    });

    tempList.forEach((element) {
      int index = _dateComparator(element.todoStartDate);
      if (index == 0) todayTasks.add(element);
    });
    todayTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    notifyListeners();
    return todayTasks;
  }

  Future<List<TodoTasksModel>> getTommorowTasks() async {
    final db = await TodoDatabase.db.database;
    tomorrowTasks = [];
    List<TodoTasksModel> tempList = new List();

    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
    );

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      tempList.add(taskModel);
    });

    tempList.forEach((element) {
      int index = _dateComparatorForTomorrow(element.todoStartDate);
      if (index == 0) tomorrowTasks.add(element);
    });

    tomorrowTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    notifyListeners();
    return tomorrowTasks;
  }

  Future<List<TodoTasksModel>> getUpcomingTasks() async {
    final db = await TodoDatabase.db.database;
    upcomingTasks = [];
    List<TodoTasksModel> tempList = new List();

    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
    );

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      tempList.add(taskModel);
    });

    tempList.forEach((element) {
      int index = _dateComparator(element.todoStartDate);
      if (index == 1) {
        int newIndex = _dateComparatorForTomorrow(element.todoStartDate);
        if (newIndex == 1) {
          upcomingTasks.add(element);
        }
      }
    });

    upcomingTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );

    notifyListeners();
    return upcomingTasks;
  }

  int _dateComparator(DateTime todoStartDate) {
    var todayDate = DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');

    String formattedDate = formatter.format(todoStartDate);
    String formattedTodayDate = formatter.format(todayDate);

    DateTime todayNewDate = DateTime.parse(formattedTodayDate);
    DateTime newDate = DateTime.parse(formattedDate);

    return newDate.compareTo(todayNewDate);
  }

  int _dateComparatorForTomorrow(DateTime todoStartDate) {
    var tomorrowDate = DateTime.now().add(new Duration(days: 1));
    var formatter = new DateFormat('yyyyMMdd');

    String formattedDate = formatter.format(todoStartDate);
    DateTime newDate = DateTime.parse(formattedDate);

    String formattedTomorrowDate = formatter.format(tomorrowDate);
    DateTime tomorrowNewDate = DateTime.parse(formattedTomorrowDate);

    return newDate.compareTo(tomorrowNewDate);
  }
}
