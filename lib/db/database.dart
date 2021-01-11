import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase with ChangeNotifier {
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
}
