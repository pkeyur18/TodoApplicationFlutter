import 'package:Todo/db/database.dart';
import 'package:Todo/model/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DBHelper with ChangeNotifier {
  List<TodoTasksModel> _tasks = new List();
  List<TodoTasksModel> _todayTasks = new List();
  List<TodoTasksModel> _tomorrowTasks = new List();
  List<TodoTasksModel> _upcomingTasks = new List();
  List<TodoTasksModel> _pastTasks = new List();
  List<TodoTasksModel> _tasksByTaskType = new List();
  TodoTasksModel _latestTask;

  int _personalCount = 0;
  int _workCount = 0;
  int _meetingCount = 0;
  int _shoppingCount = 0;
  int _studyCount = 0;
  int _partyCount = 0;
  int _tasksCount = 0;

  List<TodoTasksModel> get tasks => _tasks;
  List<TodoTasksModel> get todayTasks => _todayTasks;
  List<TodoTasksModel> get tomorrowTasks => _tomorrowTasks;
  List<TodoTasksModel> get upcomingTasks => _upcomingTasks;
  List<TodoTasksModel> get pastTasks => _pastTasks;
  List<TodoTasksModel> get tasksbyTaskType => _tasksByTaskType;

  TodoTasksModel get latestTask => _latestTask;

  int get personalCount => _personalCount;
  int get meetingCount => _meetingCount;
  int get shoppingCount => _shoppingCount;
  int get studyCount => _studyCount;
  int get partyCount => _partyCount;
  int get workCount => _workCount;
  int get tasksCount => _tasksCount;

  getAllTodotasks() async {
    final db = await TodoDatabase.db.database;
    _todayTasks = [];
    _tomorrowTasks = [];
    _upcomingTasks = [];
    _pastTasks = [];

    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
      orderBy: "id ASC",
    );

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      _tasks.add(taskModel);
      int index = _dateComparator(taskModel.todoStartDate);
      if (index == 0) {
        _todayTasks.add(taskModel);
      } else {
        int newIndex = _dateComparatorForTomorrow(taskModel.todoStartDate);
        if (newIndex == 0)
          _tomorrowTasks.add(taskModel);
        else {
          int pastIndex = _dateComparator(taskModel.todoStartDate);
          if (pastIndex < 0) {
            pastTasks.add(taskModel);
          } else {
            _upcomingTasks.add(taskModel);
          }
        }
      }
    });

    _todayTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    _tomorrowTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    _upcomingTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
  }

  todoTaskpageBuilder() async {
    _personalCount = await TodoDatabase.db.getPersonalTasksCount();

    _workCount = await TodoDatabase.db.getWorkTasksCount();

    _meetingCount = await TodoDatabase.db.getMeetingTasksCount();

    _shoppingCount = await TodoDatabase.db.getShoppingTasksCount();

    _partyCount = await TodoDatabase.db.getPartyTasksCount();

    _studyCount = await TodoDatabase.db.getStudyTasksCount();
  }

  getLatestTask() async {
    final db = await TodoDatabase.db.database;
    List<Map> result = await db.rawQuery(
        "SELECT * FROM Todolists WHERE todostartdate > datetime('now','localtime') AND completed = 1 ORDER BY todostartdate ASC Limit 1");

    if (result.length == 0) {
      _latestTask = null;
    } else {
      result.forEach((element) {
        _latestTask = TodoTasksModel.fromMap(element);
      });
    }

    List<Map> countList = await db.rawQuery(
      "SELECT * FROM Todolists WHERE todostartdate > datetime('now','localtime') AND completed = 1",
    );

    _tasksCount = 0;
    countList.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      int index = _dateComparator(taskModel.todoStartDate);
      if (index == 0) _tasksCount = _tasksCount + 1;
    });
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
    await db.rawInsert(
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
  }

  submitForm(DateTime date, TimeOfDay time, String todoTaskName,
      String selectedTaskType, bool setReminder) {
    TodoTasksModel tasksModel = new TodoTasksModel(
      completed: false,
      setReminder: setReminder,
      todoName: todoTaskName,
      todoType: selectedTaskType,
      todoStartDate:
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
    addNewTask(tasksModel);
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

  fetchTasksByTypes(String taskType) async {
    _tasksByTaskType = [];
    final db = await TodoDatabase.db.database;
    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
      orderBy: "todostartdate ASC",
      where: "todotype = ?",
      whereArgs: [taskType],
    );
    results.forEach((element) {
      TodoTasksModel model = TodoTasksModel.fromMap(element);
      _tasksByTaskType.add(model);
    });
  }

  getAllPastTasks() async {
    final db = await TodoDatabase.db.database;

    List<Map> results = await db.rawQuery(
      "SELECT * FROM Todolists WHERE todostartdate < datetime('now','localtime') AND completed = 1 ORDER BY todostartdate ASC",
    );
    _pastTasks = [];
    results.forEach((element) {
      TodoTasksModel model = TodoTasksModel.fromMap(element);
      _pastTasks.add(model);
    });
  }

  updateTasksCompletedStatus(int id, bool data) async {
    final db = await TodoDatabase.db.database;
    int index = data ? 0 : 1;
    await db
        .rawUpdate("UPDATE Todolists SET completed = $index WHERE id = $id");
    notifyListeners();
  }

  updateTasksReminderStatus(int id, bool data) async {
    final db = await TodoDatabase.db.database;
    int index = data ? 0 : 1;
    await db
        .rawUpdate("UPDATE Todolists SET setreminder = $index WHERE id = $id");
    notifyListeners();
  }

  updateTask(TodoTasksModel tasksModel) async {
    final db = await TodoDatabase.db.database;

    var row = tasksModel.toMap();

    await db.update(
      "Todolists",
      row,
      where: "id = ?",
      whereArgs: [tasksModel.todoId],
    );
    notifyListeners();
  }

  submitEditForm(int id, DateTime date, TimeOfDay time, String todoTaskName,
      String selectedTaskType, bool setReminder) {
    TodoTasksModel tasksModel = new TodoTasksModel(
      todoId: id,
      completed: false,
      setReminder: setReminder,
      todoName: todoTaskName,
      todoType: selectedTaskType,
      todoStartDate:
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
    updateTask(tasksModel);
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
