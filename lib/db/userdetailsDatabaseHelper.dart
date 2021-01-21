import 'package:Todo/db/database.dart';
import 'package:Todo/model/userDetails.dart';
import 'package:flutter/cupertino.dart';

class UserdetailsDBHelper with ChangeNotifier {
  UserDetails _userDetails;

  UserDetails get userDetails => _userDetails;

  Future<UserDetails> getUserDetails() async {
    final db = await TodoDatabase.db.database;

    List<Map> result = await db.query(
      "Userdetails",
      columns: UserDetails.columns,
      orderBy: "id ASC",
      limit: 1,
    );

    result.forEach((element) {
      _userDetails = UserDetails.fromMap(element);
    });
    return _userDetails;
  }

  void addUserDetails(UserDetails userDetails) async {
    final db = await TodoDatabase.db.database;

    var maxId = await db.rawQuery(
      "SELECT MAX(ID)+1 as last_id FROM Userdetails",
    );
    var id = maxId.first['last_id'];
    await db.rawInsert(
      "INSERT INTO Userdetails (id, username, profilepicture)"
      "VALUES (?, ?, ?)",
      [
        id,
        userDetails.userName,
        userDetails.profilePicture,
      ],
    );

    notifyListeners();
  }

  updateUsernameDetails(UserDetails userDetails) async {
    final db = await TodoDatabase.db.database;

    await db.rawUpdate(
        "UPDATE Userdetails SET username = '${userDetails.userName}' WHERE id = ${userDetails.id}");
    notifyListeners();
  }

  deleteUserDetails(UserDetails userDetails) async {
    final db = await TodoDatabase.db.database;
    db.delete(
      "Userdetails",
      where: "id = ?",
      whereArgs: [userDetails.id],
    );
    notifyListeners();
  }
}
