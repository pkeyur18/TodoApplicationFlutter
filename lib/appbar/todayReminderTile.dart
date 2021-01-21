import 'package:Todo/appbar/customAppbar.dart';
import 'package:Todo/appbar/homeNotification.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/model/my_tasks.dart';
import 'package:Todo/model/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayReminder extends StatefulWidget {
  final UserDetails userDetails;

  TodayReminder(this.userDetails);

  @override
  _TodayReminderState createState() => _TodayReminderState();
}

class _TodayReminderState extends State<TodayReminder> {
  final String _subheading = "Today you have ";
  var dbhelperProvider;
  UserDetails dummyUser =
      new UserDetails(id: -1, profilePicture: null, userName: "Dummy user");
  TodoTasksModel dummyTask = new TodoTasksModel(
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
      future: dbhelperProvider.getLatestTask(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Oops..! Some error has occured."),
          );
        } else {
          return Container(
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
                  dbhelperProvider.tasks.length > 0
                      ? CustomAppBar(
                          widget.userDetails,
                          "$_subheading ${dbhelperProvider.tasksCount} tasks remaining",
                          false)
                      : CustomAppBar(widget.userDetails,
                          "You do not have any task yet.!", false),
                  dbhelperProvider.latestTask != null
                      ? HomeNotification(
                          dbhelperProvider.latestTask, "Next Reminder", false)
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
