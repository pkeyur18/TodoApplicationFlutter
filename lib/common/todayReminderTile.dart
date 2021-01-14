import 'package:Todo/common/customAppbar.dart';
import 'package:Todo/common/homeNotification.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayReminder extends StatefulWidget {
  @override
  _TodayReminderState createState() => _TodayReminderState();
}

class _TodayReminderState extends State<TodayReminder> {
  final String _user = "Keyur Patel";
  final String _subheading = "Today you have ";
  final String _image = "assets/images/keyur.jpg";
  var dbhelperProvider;

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return FutureBuilder(
      future: dbhelperProvider.getLatestTask(),
      builder: (context, snapshot) => Container(
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
                          "Hi " + _user,
                          _subheading +
                              "${dbhelperProvider.tasksCount} tasks remaining",
                          _image)
                      .build(context)
                  : CustomAppBar("Hi " + _user,
                          "You do not have any task yet.!", _image)
                      .build(context),
              dbhelperProvider.latestTask != null
                  ? HomeNotification(
                      dbhelperProvider.latestTask, "Next Reminder")
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
