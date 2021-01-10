import 'package:Todo/home/UpcomingTodoTiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:Todo/common/bottom_sheet.dart';
import 'package:Todo/db/TodotasksDb.dart';
import 'package:Todo/home/task_tiles.dart';
import 'package:Todo/common/custom_appbar.dart';
import 'package:Todo/home/TodoTiles.dart';
import 'package:Todo/home/home_notification.dart';

// ignore: must_be_immutable
class HomeTasksPage extends StatefulWidget {
  int _selectedIndex = 0;

  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  String _user = "Keyur Patel";
  String _subheading = "Today you have ";
  String _image = "assets/images/keyur.jpg";
  var tabs = [];

  void _tabSelector() {
    tabs = [];
    tabs.add(_homeDashboard());
    tabs.add(_taskDashboard());
  }

  @override
  Widget build(BuildContext context) {
    _tabSelector();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        toolbarOpacity: 0,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => TodotasksDBProvider(),
          child: Scaffold(
            body: Container(
              child: Container(
                child: Column(
                  children: [
                    _todayReminder(context),
                    tabs[widget._selectedIndex],
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _customBottomBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: OpenBottomSheet(),
          ),
        ),
      ),
    );
  }

  Widget _todayReminder(BuildContext context) {
    return Consumer<TodotasksDBProvider>(
      builder: (context, value, __) => FutureBuilder(
        future: value.getLatestTask(),
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
                value.tasks.length > 0
                    ? CustomAppBar("Hi " + _user,
                            _subheading + "${value.tasksCount} tasks", _image)
                        .build(context)
                    : CustomAppBar("Hi " + _user,
                            "Today you do not have any task", _image)
                        .build(context),
                value.latestTask != null
                    ? HomeNotification(value.latestTask, "Next Reminder")
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeDashboard() {
    return Consumer<TodotasksDBProvider>(
      builder: (context, value, __) => FutureBuilder(
        future: value.getAllTodotasks(),
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
                  value.todayTasks.length > 0
                      ? Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xFF8B87B3),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                  value.todayTasks.length > 0
                      ? Column(
                          children: [
                            for (var item in value.todayTasks)
                              CustomTodoTile(item),
                          ],
                        )
                      : SizedBox.shrink(),
                  Column(
                    children: [
                      value.tomorrowTasks.length > 0
                          ? Container(
                              margin: EdgeInsets.only(
                                top: 18.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tomorrow",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF8B87B3),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      value.tomorrowTasks.length > 0
                          ? Column(
                              children: [
                                for (var item in value.tomorrowTasks)
                                  CustomTodoTile(item),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  Column(
                    children: [
                      value.upcomingTasks.length > 0
                          ? Container(
                              margin: EdgeInsets.only(
                                top: 18.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Upcoming",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xFF8B87B3),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      value.upcomingTasks.length > 0
                          ? Column(
                              children: [
                                for (var item in value.upcomingTasks)
                                  UpcomingTodoTile(item),
                              ],
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 18.0,
                      top: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _taskDashboard() {
    return Consumer<TodotasksDBProvider>(
      builder: (context, value, __) => FutureBuilder(
        future: value.todoTaskpageBuilder(),
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
                        TaskTiles("Personal", "${value.personalCount} Tasks",
                            _personalImageBuilder()),
                        TaskTiles("Work", "${value.workCount} Tasks",
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
                        TaskTiles("Meeting", "${value.meetingCount} Tasks",
                            _meetingImageBuilder()),
                        TaskTiles("Shopping", "${value.shoppingCount} Tasks",
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
                        TaskTiles("Party", "${value.partyCount} Tasks",
                            _partyImageBuilder()),
                        TaskTiles("Study", "${value.studyCount} Tasks",
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

  Widget _customBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Color(0xFFBEBEBE),
      currentIndex: widget._selectedIndex,
      onTap: _onItemTaped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          label: 'Tasks',
        ),
      ],
    );
  }

  void _onItemTaped(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }
}
