import 'package:Todo/bottomsheet/emptyNotesBody.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/model/my_tasks.dart';
import 'package:Todo/todoTasksGroup/homePageUpcomingTaskTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PendingPageDashboard extends StatefulWidget {
  @override
  _PendingPageDashboardState createState() => _PendingPageDashboardState();
}

class _PendingPageDashboardState extends State<PendingPageDashboard> {
  var dbhelperProvider;
  TodoTasksModel dummy = new TodoTasksModel(
    todoName: "dummy",
    todoStartDate: DateTime.now(),
    todoType: "Personal",
    todoId: -1,
    completed: false,
    setReminder: false,
  );

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return FutureBuilder(
      future: dbhelperProvider.getAllPastTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Oops..! some error has occured.");
        } else if (snapshot.hasData) {
          return dbhelperProvider.pastTasks.length > 0
              ? Expanded(
                  child: SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                      bottom: 24,
                    ),
                    child: Column(
                      children: [
                        dbhelperProvider.pastTasks.length > 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "All pending tasks",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF8B87B3),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                        dbhelperProvider.pastTasks.length > 0
                            ? Column(
                                children: [
                                  for (var item in dbhelperProvider.pastTasks)
                                    UpcomingTodoTile(item),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  )),
                )
              : Expanded(
                  child: EmptyPendingNotes(),
                );
        } else {
          return Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All pending tasks",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF8B87B3),
                          ),
                        ),
                      ],
                    ),
                    Shimmer.fromColors(
                      child: UpcomingTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: UpcomingTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: UpcomingTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: UpcomingTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: UpcomingTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
