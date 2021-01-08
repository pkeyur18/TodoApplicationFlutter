import 'package:Todo/common/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:Todo/home/task_tiles.dart';
import 'package:Todo/common/custom_appbar.dart';
import 'package:Todo/home/TodoTiles.dart';
import 'package:Todo/home/home_notification.dart';
import 'package:Todo/model/my_tasks.dart';

import 'custom_body.dart';

// ignore: must_be_immutable
class HomeTasksPage extends StatefulWidget {
  DateTime today = DateTime.now();
  List<TodoTasksModel> todayTasks;
  List<TodoTasksModel> tomorrowTasks;
  List<TodoTasksModel> upcomingTasks;
  List<TodoTasksModel> pastTasks;
  List<TodoTasksModel> personalTasks;
  List<TodoTasksModel> workTasks;
  List<TodoTasksModel> meetingTasks;
  List<TodoTasksModel> shoppingTasks;
  List<TodoTasksModel> partyTasks;
  List<TodoTasksModel> studyTasks;
  TodoTasksModel latestTask;
  bool hasTodayTask = false;
  bool hasTomorrowTask = false;
  bool hasUpcomingTask = false;
  int _selectedIndex = 0;

  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  int _tasks = 0;
  int _personalTasksCount = 0;
  int _workTasksCount = 0;
  int _meetingTasksCount = 0;
  int _shoppingTasksCount = 0;
  int _studyTasksCount = 0;
  int _partyTasksCount = 0;
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
    );
  }

  Widget _todayReminder(BuildContext context) {
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
            myTodoList.length > 0
                ? CustomAppBar(
                        "Hi " + _user, _subheading + "$_tasks tasks", _image)
                    .build(context)
                : CustomAppBar("Hi " + _user, _subheading + "no tasks", _image)
                    .build(context),
            widget.hasTodayTask
                ? HomeNotification(widget.latestTask, "Today Reminder")
                : (widget.hasTomorrowTask
                    ? HomeNotification(widget.latestTask, "Tomorrow Reminder")
                    : (widget.hasUpcomingTask
                        ? HomeNotification(
                            widget.latestTask, "Upcoming Reminder")
                        : SizedBox.shrink())),
          ],
        ),
      ),
    );
  }

  Widget _homeDashboard() {
    _sortingTasks();
    return myTodoList.length > 0
        ? Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: 18,
                  left: 18,
                  right: 18,
                ),
                child: Column(
                  children: [
                    widget.todayTasks.length > 0
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
                    widget.todayTasks.length > 0
                        ? Column(
                            children: [
                              for (var data in widget.todayTasks)
                                CustomTodoTile(data),
                            ],
                          )
                        : SizedBox.shrink(),
                    widget.tomorrowTasks.length > 0
                        ? Container(
                            margin: EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    widget.tomorrowTasks.length > 0
                        ? Column(
                            children: [
                              for (var data in widget.tomorrowTasks)
                                CustomTodoTile(data),
                            ],
                          )
                        : SizedBox.shrink(),
                    widget.upcomingTasks.length > 0
                        ? Container(
                            margin: EdgeInsets.only(
                              top: 18.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    widget.upcomingTasks.length > 0
                        ? Column(
                            children: [
                              for (var data in widget.upcomingTasks)
                                CustomTodoTile(data),
                            ],
                          )
                        : SizedBox.shrink(),
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
          )
        : Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmptyNotesBody(),
              ],
            ),
          );
  }

  _taskDashboard() {
    return Expanded(
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
                    TaskTiles("Personal", "$_personalTasksCount Tasks",
                        _personalImageBuilder()),
                    TaskTiles(
                        "Work", "$_workTasksCount Tasks", _workImageBuilder()),
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
                    TaskTiles("Meeting", "$_meetingTasksCount Tasks",
                        _meetingImageBuilder()),
                    TaskTiles("Shopping", "$_shoppingTasksCount Tasks",
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
                    TaskTiles("Party", "$_partyTasksCount Tasks",
                        _partyImageBuilder()),
                    TaskTiles("Study", "$_studyTasksCount Tasks",
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

  void _sortingTasks() {
    widget.todayTasks = [];
    widget.tomorrowTasks = [];
    widget.upcomingTasks = [];
    widget.pastTasks = [];
    for (var data in myTodoList) {
      int index = _dateComparator(data.todoStartDate);
      if (index == 0) {
        widget.todayTasks.add(data);
      } else if (index == 1) {
        int newIndex = _dateComparatorForTomorrow(data.todoStartDate);
        if (newIndex == 0) {
          widget.tomorrowTasks.add(data);
        } else if (newIndex == 1) {
          widget.upcomingTasks.add(data);
        } else {
          widget.pastTasks.add(data);
        }
      } else {
        widget.pastTasks.add(data);
      }
    }

    widget.todayTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    widget.tomorrowTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    widget.upcomingTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );
    widget.pastTasks.sort(
      (a, b) => a.todoStartDate.compareTo(b.todoStartDate),
    );

    for (var data in widget.todayTasks) {
      int index = _findLatestTask(data.todoStartDate);
      if (index == 1) {
        widget.latestTask = data;
        widget.hasTodayTask = true;
        widget.hasTomorrowTask = false;
        widget.hasUpcomingTask = false;
        break;
      }
    }
    if (!widget.hasTodayTask) {
      for (var data in widget.tomorrowTasks) {
        int index = _findLatestTask(data.todoStartDate);
        if (index == 1) {
          widget.latestTask = data;
          widget.hasTodayTask = false;
          widget.hasTomorrowTask = true;
          widget.hasUpcomingTask = false;
          break;
        }
      }
    }

    if (!widget.hasTodayTask && !widget.hasTomorrowTask) {
      for (var data in widget.upcomingTasks) {
        int index = _findLatestTask(data.todoStartDate);
        if (index == 1) {
          widget.latestTask = data;
          widget.hasTodayTask = false;
          widget.hasTomorrowTask = false;
          widget.hasUpcomingTask = true;
          break;
        }
      }
    }
    _tasks = widget.todayTasks.length;

    widget.personalTasks = [];
    widget.workTasks = [];
    widget.shoppingTasks = [];
    widget.meetingTasks = [];
    widget.partyTasks = [];
    widget.studyTasks = [];

    for (var data in myTodoList) {
      if (data.todoType.toLowerCase() == "personal") {
        widget.personalTasks.add(data);
      } else if (data.todoType.toLowerCase() == "work") {
        widget.workTasks.add(data);
      } else if (data.todoType.toLowerCase() == "meeting") {
        widget.meetingTasks.add(data);
      } else if (data.todoType.toLowerCase() == "shopping") {
        widget.shoppingTasks.add(data);
      } else if (data.todoType.toLowerCase() == "party") {
        widget.partyTasks.add(data);
      } else if (data.todoType.toLowerCase() == "study") {
        widget.studyTasks.add(data);
      }
    }

    _personalTasksCount = widget.personalTasks.length;
    _workTasksCount = widget.workTasks.length;
    _meetingTasksCount = widget.meetingTasks.length;
    _studyTasksCount = widget.studyTasks.length;
    _shoppingTasksCount = widget.shoppingTasks.length;
    _partyTasksCount = widget.partyTasks.length;
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

  int _findLatestTask(DateTime date) {
    DateTime now = new DateTime.now();
    return date.compareTo(now);
  }
}
