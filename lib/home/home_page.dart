import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:Todo/common/bottom_sheet.dart';
import 'package:Todo/db/TodotasksDb.dart';
import 'package:Todo/home/task_tiles.dart';
import 'package:Todo/common/custom_appbar.dart';
import 'package:Todo/home/TodoTiles.dart';
import 'package:Todo/home/home_notification.dart';
import 'package:Todo/model/my_tasks.dart';
import 'custom_body.dart';

// ignore: must_be_immutable
class HomeTasksPage extends StatefulWidget {
  List<TodoTasksModel> personalTasks;
  List<TodoTasksModel> workTasks;
  List<TodoTasksModel> meetingTasks;
  List<TodoTasksModel> shoppingTasks;
  List<TodoTasksModel> partyTasks;
  List<TodoTasksModel> studyTasks;
  int _selectedIndex = 0;

  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  String _user = "Keyur Patel";
  String _subheading = "Today you have ";
  String _image = "assets/images/keyur.jpg";
  var tabs = [];

  Future<List<TodoTasksModel>> todayTasksList;
  Future<List<TodoTasksModel>> tomorrowTasksList;
  Future<List<TodoTasksModel>> upcomingTasksList;
  Future<List<TodoTasksModel>> allTasksList;
  Future<TodoTasksModel> latestTask;

  Future<int> _personalTasksCount;
  Future<int> _workTasksCount;
  Future<int> _meetingTasksCount;
  Future<int> _shoppingTasksCount;
  Future<int> _studyTasksCount;
  Future<int> _partyTasksCount;

  void _tabSelector() {
    tabs = [];
    tabs.add(_homeDashboard());
    tabs.add(_taskDashboard());
  }

  @override
  Widget build(BuildContext context) {
    allTasksList = TodotasksDBProvider().getAllTodotasks();
    todayTasksList = TodotasksDBProvider().getTodayTasks();
    tomorrowTasksList = TodotasksDBProvider().getTommorowTasks();
    upcomingTasksList = TodotasksDBProvider().getUpcomingTasks();
    latestTask = TodotasksDBProvider().getLatestTask();
    _personalTasksCount = TodotasksDBProvider().getPersonalTasksCount();
    _workTasksCount = TodotasksDBProvider().getWorkTasksCount();
    _meetingTasksCount = TodotasksDBProvider().getMeetingTasksCount();
    _shoppingTasksCount = TodotasksDBProvider().getShoppingTasksCount();
    _studyTasksCount = TodotasksDBProvider().getStudyTasksCount();
    _partyTasksCount = TodotasksDBProvider().getPartyTasksCount();

    _tabSelector();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        toolbarOpacity: 0,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => TodoTasksProvider(),
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
      child: FutureBuilder(
        future: todayTasksList,
        builder: (context, tasks) => FutureBuilder(
          future: latestTask,
          builder: (context, snapshot) => Container(
            child: Column(
              children: [
                snapshot.hasData
                    ? CustomAppBar("Hi " + _user,
                            _subheading + "${tasks.data.length} tasks", _image)
                        .build(context)
                    : CustomAppBar(
                            "Hi " + _user, _subheading + "no tasks", _image)
                        .build(context),
                snapshot.hasData
                    ? HomeNotification(snapshot.data, "Next Reminder")
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeDashboard() {
    return FutureBuilder(
      future: allTasksList,
      builder: (context, alltasks) => alltasks.hasData
          ? Consumer<TodoTasksProvider>(
              builder: (context, value, child) => Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: todayTasksList,
                          builder: (context, snapshot) => Column(
                            children: [
                              snapshot.hasData
                                  ? Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                              snapshot.hasData
                                  ? Column(
                                      children: [
                                        for (var item in snapshot.data)
                                          CustomTodoTile(item),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: tomorrowTasksList,
                          builder: (context, snapshot) => Column(
                            children: [
                              snapshot.hasData
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
                              snapshot.hasData
                                  ? Column(
                                      children: [
                                        for (var item in snapshot.data)
                                          CustomTodoTile(item),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: upcomingTasksList,
                          builder: (context, snapshot) => Column(
                            children: [
                              snapshot.hasData
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
                              snapshot.hasData
                                  ? Column(
                                      children: [
                                        for (var item in snapshot.data)
                                          CustomTodoTile(item),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
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
            )
          : Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EmptyNotesBody(),
                ],
              ),
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
                    FutureBuilder(
                      future: _personalTasksCount,
                      builder: (context, snapshot) => TaskTiles("Personal",
                          "${snapshot.data} Tasks", _personalImageBuilder()),
                    ),
                    FutureBuilder(
                      future: _workTasksCount,
                      builder: (context, snapshot) => TaskTiles("Work",
                          "${snapshot.data} Tasks", _workImageBuilder()),
                    ),
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
                    FutureBuilder(
                      future: _meetingTasksCount,
                      builder: (context, snapshot) => TaskTiles("Meeting",
                          "${snapshot.data} Tasks", _meetingImageBuilder()),
                    ),
                    FutureBuilder(
                      future: _shoppingTasksCount,
                      builder: (context, snapshot) => TaskTiles("Shopping",
                          "${snapshot.data} Tasks", _shoppingImageBuilder()),
                    ),
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
                    FutureBuilder(
                      future: _partyTasksCount,
                      builder: (context, snapshot) => TaskTiles("Party",
                          "${snapshot.data} Tasks", _partyImageBuilder()),
                    ),
                    FutureBuilder(
                      future: _studyTasksCount,
                      builder: (context, snapshot) => TaskTiles("Study",
                          "${snapshot.data} Tasks", _studyImageBuilder()),
                    ),
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
