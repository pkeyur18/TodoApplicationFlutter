import 'package:Todo/common/customAppbar.dart';
import 'package:Todo/common/emptyNotesBody.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/todoTasksGroup/homePageUpcomingTaskTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingPageDashboard extends StatefulWidget {
  @override
  _PendingPageDashboardState createState() => _PendingPageDashboardState();
}

class _PendingPageDashboardState extends State<PendingPageDashboard> {
  var dbhelperProvider;
  final String _user = "Keyur Patel";
  final String _image = "assets/images/keyur.jpg";

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: <Color>[
                Color(0xFF81C7F5),
                Color(0xFF3867D5),
              ],
            ),
          ),
          child: Container(
            child: Column(
              children: [
                CUstomAppBarForPending("Hi " + _user, _image).build(context)
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: dbhelperProvider.getAllPastTasks(),
          builder: (context, snapshot) => dbhelperProvider.pastTasks.length > 0
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
                ),
        ),
      ],
    );
  }
}
