import 'dart:async';
import 'dart:io';
import 'package:Todo/model/my_tasks.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  TodoDatabase._();
  static final TodoDatabase db = TodoDatabase._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Todolists.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Todolists ("
          "id INTEGER PRIMARY KEY,"
          "todotype TEXT,"
          "todoname TEXT,"
          "setreminder INTEGER,"
          "completed INTEGER,"
          "todostartdate TEXT"
          ")");
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          1,
          "Personal",
          "Go jogging with Christin",
          1,
          0,
          DateTime(2021, 01, 10, 07, 00).toString()
        ],
      );
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          2,
          "Work",
          "Send project file",
          1,
          0,
          DateTime(2021, 01, 10, 10, 00).toString()
        ],
      );
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          3,
          "Meeting",
          "Meeting with client",
          1,
          1,
          DateTime(2021, 01, 10, 15, 00).toString()
        ],
      );
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          4,
          "Work",
          "Email client",
          1,
          1,
          DateTime(2021, 01, 11, 10, 00).toString()
        ],
      );
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          5,
          "Personal",
          "Morning yoga",
          1,
          1,
          DateTime(2021, 01, 11, 07, 00).toString()
        ],
      );
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          6,
          "Work",
          "Send project file",
          1,
          1,
          DateTime(2021, 01, 12, 10, 00).toString()
        ],
      );
      await db.execute(
        "INSERT INTO Todolists ('id', 'todotype', 'todoname', 'setreminder', 'completed', 'todostartdate') values (?, ?, ?, ?, ?, ?)",
        [
          7,
          "Meeting",
          "Meeting with client",
          1,
          1,
          DateTime(2021, 01, 13, 15, 00).toString()
        ],
      );
    });
  }

  Future<List<TodoTasksModel>> getAllTodotasks() async {
    final db = await database;
    List<Map> results = await db.query(
      "Todolists",
      columns: TodoTasksModel.columns,
      orderBy: "id ASC",
    );

    List<TodoTasksModel> tasks = new List();

    results.forEach((element) {
      TodoTasksModel taskModel = TodoTasksModel.fromMap(element);
      tasks.add(taskModel);
    });
    return tasks;
  }
}
