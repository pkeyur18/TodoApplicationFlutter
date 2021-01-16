// import 'package:Todo/todoTasksGroup/homePageUpcomingTaskTile.dart';
import 'package:Todo/model/my_tasks.dart';
import 'package:Todo/todoTasksGroup/taskGroupbyCategoryTiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Todo/db/databaseHelper.dart';

class AllTasksTilesPage extends StatefulWidget {
  @override
  _AllTasksTilesPageState createState() => _AllTasksTilesPageState();
}

class _AllTasksTilesPageState extends State<AllTasksTilesPage> {
  var dbhelperProvider;
  String taskType;
  List<TodoTasksModel> list = new List();

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    taskType = args['taskType'];
    dbhelperProvider = Provider.of<DBHelper>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("$taskType tasks"),
        elevation: 0,
        backgroundColor: Color(0xFF3867D5),
      ),
      body: buildCustomTiles(),
    );
  }

  Widget buildCustomTiles() {
    return FutureBuilder(
      future: dbhelperProvider.fetchTasksByTypes(taskType),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Oops..! Some error has occured"),
            ],
          );
        }
        list = dbhelperProvider.tasksbyTaskType;
        return list.length > 0
            ? Container(
                margin: EdgeInsets.only(
                  top: 18,
                  left: 18,
                  right: 18,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox.shrink(),
                        Text(
                          "$taskType tasks - " +
                              dbhelperProvider.tasksbyTaskType.length
                                  .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xFF8B87B3),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            for (var item in list)
                              TaskGroupbyCategoryTiles(item),
                            SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : emptyNotesforCategory();
      },
    );
  }

  Widget emptyNotesforCategory() {
    final String assetImage = "assets/images/taskimages/$taskType.png";
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            assetImage,
            width: MediaQuery.of(context).size.width * 0.70,
          ),
          SizedBox(
            height: 70.3,
          ),
          Text(
            'No ${taskType.toLowerCase()} tasks',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF554E8F),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Text(
            'You do not have any ${taskType.toLowerCase()} task to do.',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFF82A0B7),
            ),
          ),
        ],
      ),
    );
  }
}
