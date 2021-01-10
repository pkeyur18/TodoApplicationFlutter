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

  int personalCount = 0;
  int workCount = 0;
  int meetingCount = 0;
  int shoppingCount = 0;
  int studyCount = 0;
  int partyCount = 0;
  int tasksCount = 0;

  getAllTodotasks() async {
    final db = await TodoDatabase.db.database;
    todayTasks = [];
    tomorrowTasks = [];
    upcomingTasks = [];
    pastTasks = [];

    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
      orderBy: "id ASC",
    );

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      tasks.add(taskModel);
      int index = _dateComparator(taskModel.todoStartDate);
      if (index == 0) {
        todayTasks.add(taskModel);
      } else {
        int newIndex = _dateComparatorForTomorrow(taskModel.todoStartDate);
        if (newIndex == 0)
          tomorrowTasks.add(taskModel);
        else
          upcomingTasks.add(taskModel);
      }
    });

    todayTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    tomorrowTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    upcomingTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    notifyListeners();
  }

  todoTaskpageBuilder() async {
    personalCount = await getPersonalTasksCount();
    workCount = await getWorkTasksCount();
    meetingCount = await getMeetingTasksCount();
    shoppingCount = await getShoppingTasksCount();
    partyCount = await getPartyTasksCount();
    studyCount = await getStudyTasksCount();
    notifyListeners();
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

  getLatestTask() async {
    final db = await TodoDatabase.db.database;
    List<Map> result = await db.rawQuery(
        "SELECT * FROM Todolists WHERE todostartdate > datetime('now','localtime') ORDER BY todostartdate ASC Limit 1");

    if (result.length == 0) {
      latestTask = null;
    } else {
      result.forEach((element) {
        latestTask = TodoTasksModel.fromMap(element);
      });
    }

    List<Map> count = await db.rawQuery(
        "SELECT COUNT(*) as count FROM Todolists WHERE todostartdate > datetime('now','localtime')");

    tasksCount = count.first['count'];
  }

  addNewTask(TodoTasksModel task) async {
    final db = await TodoDatabase.db.database;
    var maxId = await db.rawQuery(
      "SELECT MAX(ID)+1 as last_id FROM Todolists",
    );
    int setReminder = task.setReminder ? 0 : 1;
    int completed = task.completed ? 0 : 1;
    String todoStartdate = task.todoStartDate.toString();
    var id = maxId.first['last_id'];
    var result = await db.rawInsert(
      "INSERT INTO Todolists (id, todotype, todoname, setreminder, completed, todostartdate)"
      "VALUES (?, ?, ?, ?, ?, ?)",
      [
        id,
        task.todoType,
        task.todoName,
        setReminder,
        completed,
        todoStartdate,
      ],
    );
    notifyListeners();
    return result;
  }

  deleteTask(TodoTasksModel task) async {
    final db = await TodoDatabase.db.database;
    db.delete(
      "Todolists",
      where: "id = ?",
      whereArgs: [task.todoId],
    );
    notifyListeners();
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
