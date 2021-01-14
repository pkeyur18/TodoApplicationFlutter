import 'package:Todo/common/todayReminderTile.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/todoTasksGroup/taskPageTiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskPageDashboard extends StatefulWidget {
  @override
  _TaskPageDashboardState createState() => _TaskPageDashboardState();
}

class _TaskPageDashboardState extends State<TaskPageDashboard> {
  var dbhelperProvider;

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return Column(
      children: [
        TodayReminder(),
        FutureBuilder(
          future: dbhelperProvider.todoTaskpageBuilder(),
          builder: (context, snapshot) => Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: 18,
                  left: 18,
                  right: 18,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Projects",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF8B87B3),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TaskTiles(
                              "Personal",
                              "${dbhelperProvider.personalCount} Tasks",
                              _personalImageBuilder()),
                          TaskTiles(
                              "Work",
                              "${dbhelperProvider.workCount} Tasks",
                              _workImageBuilder()),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TaskTiles(
                              "Meeting",
                              "${dbhelperProvider.meetingCount} Tasks",
                              _meetingImageBuilder()),
                          TaskTiles(
                              "Shopping",
                              "${dbhelperProvider.shoppingCount} Tasks",
                              _shoppingImageBuilder()),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TaskTiles(
                              "Party",
                              "${dbhelperProvider.partyCount} Tasks",
                              _partyImageBuilder()),
                          TaskTiles(
                              "Study",
                              "${dbhelperProvider.studyCount} Tasks",
                              _studyImageBuilder()),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _personalImageBuilder() {
    return CircleAvatar(
      radius: 34,
      backgroundColor: Color(0x78FFEE9B),
      child: Image(
        width: 28,
        height: 34,
        image: AssetImage('assets/images/user.png'),
      ),
    );
  }

  Widget _workImageBuilder() {
    return CircleAvatar(
      radius: 34,
      backgroundColor: Color(0x78B5FF9B),
      child: Image(
        width: 30,
        height: 34,
        image: AssetImage('assets/images/briefcase.png'),
      ),
    );
  }

  Widget _meetingImageBuilder() {
    return CircleAvatar(
      radius: 34,
      backgroundColor: Color(0x78FF9BCD),
      child: Image(
        width: 30,
        height: 34,
        image: AssetImage('assets/images/presentation.png'),
      ),
    );
  }

  Widget _shoppingImageBuilder() {
    return CircleAvatar(
      radius: 34,
      backgroundColor: Color(0x78FFD09B),
      child: Image(
        width: 30,
        height: 34,
        image: AssetImage('assets/images/shopping-basket.png'),
      ),
    );
  }

  Widget _partyImageBuilder() {
    return CircleAvatar(
      radius: 34,
      backgroundColor: Color(0x709BFFF8),
      child: Image(
        width: 30,
        height: 34,
        image: AssetImage('assets/images/confetti.png'),
      ),
    );
  }

  Widget _studyImageBuilder() {
    return CircleAvatar(
      radius: 34,
      backgroundColor: Color(0x78F59BFF),
      child: Image(
        width: 30,
        height: 34,
        image: AssetImage('assets/images/molecule.png'),
      ),
    );
  }
}
