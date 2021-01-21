import 'package:Todo/bottomsheet/emptyNotesBody.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/model/my_tasks.dart';
import 'package:Todo/todoTasksGroup/homePageTaskTile.dart';
import 'package:Todo/todoTasksGroup/homePageUpcomingTaskTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePageDashboard extends StatefulWidget {
  @override
  _HomePageDashboardState createState() => _HomePageDashboardState();
}

class _HomePageDashboardState extends State<HomePageDashboard> {
  var dbhelperProvider;
  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return FutureBuilder(
      future: dbhelperProvider.getAllTodotasks(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Oops, Error occured while fetching data',
            style: Theme.of(context).textTheme.headline1,
          );
        } else if (snapshot.hasData) {
          return dbhelperProvider.todayTasks.length > 0 ||
                  dbhelperProvider.tomorrowTasks.length > 0 ||
                  dbhelperProvider.upcomingTasks.length > 0
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
                          dbhelperProvider.todayTasks.length > 0
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
                          dbhelperProvider.todayTasks.length > 0
                              ? Column(
                                  children: [
                                    for (var item
                                        in dbhelperProvider.todayTasks)
                                      CustomTodoTile(item),
                                  ],
                                )
                              : SizedBox.shrink(),
                          Column(
                            children: [
                              dbhelperProvider.tomorrowTasks.length > 0
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
                              dbhelperProvider.tomorrowTasks.length > 0
                                  ? Column(
                                      children: [
                                        for (var item
                                            in dbhelperProvider.tomorrowTasks)
                                          CustomTodoTile(item),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          Column(
                            children: [
                              dbhelperProvider.upcomingTasks.length > 0
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
                              dbhelperProvider.upcomingTasks.length > 0
                                  ? Column(
                                      children: [
                                        for (var item
                                            in dbhelperProvider.upcomingTasks)
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
                )
              : Expanded(
                  child: EmptyNotesBody(),
                );
        } else {
          TodoTasksModel dummy = new TodoTasksModel(
            todoName: "dummy",
            todoStartDate: DateTime.now(),
            todoType: "Personal",
            todoId: 1,
            completed: false,
            setReminder: false,
          );
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
                          "Today",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF8B87B3),
                          ),
                        ),
                      ],
                    ),
                    Shimmer.fromColors(
                      child: CustomTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: CustomTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: CustomTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Container(
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
                    ),
                    Shimmer.fromColors(
                      child: CustomTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Shimmer.fromColors(
                      child: CustomTodoTile(dummy),
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.white,
                    ),
                    Container(
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
