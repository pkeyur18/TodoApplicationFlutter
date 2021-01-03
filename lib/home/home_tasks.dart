import 'package:flutter/material.dart';

import 'package:Todo/common/custom_appbar.dart';
import 'package:Todo/TodoTiles.dart';
import 'package:Todo/home_notification.dart';
import 'package:intl/intl.dart';
import '../common/custom_bottom_bar.dart';
import 'package:Todo/common/floating_button.dart';
import 'package:Todo/model/my_tasks.dart';

// ignore: must_be_immutable
class HomeTasksPage extends StatefulWidget {
  DateTime today = DateTime.now();
  List<TodoTasksModel> todayTasks = [];
  List<TodoTasksModel> tomorrowTasks = [];
  List<TodoTasksModel> upcomingTasks = [];
  List<TodoTasksModel> pastTasks = [];
  TodoTasksModel latestTask;
  bool hasTodayTask = false;
  bool hasTomorrowTask = false;
  bool hasUpcomingTask = false;

  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  int _tasks = myTodoList.length;
  String _user = "Keyur Patel";
  String _subheading = "Today you have ";
  String _image = "assets/images/keyur.jpg";

  @override
  Widget build(BuildContext context) {
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
              child: Column(children: [
                _todayReminder(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: _homeDashboard(context),
                  ),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: CustomBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CustomFloatingButton(),
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
            CustomAppBar("Hi " + _user, _subheading + "$_tasks tasks", _image)
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

  Widget _homeDashboard(BuildContext context) {
    return Container(
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
                    for (var data in widget.todayTasks) CustomTodoTile(data),
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
                    for (var data in widget.tomorrowTasks) CustomTodoTile(data),
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
                    for (var data in widget.upcomingTasks) CustomTodoTile(data),
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
    );
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
