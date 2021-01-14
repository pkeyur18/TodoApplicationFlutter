import 'package:Todo/todoTasksGroup/homePageUpcomingTaskTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Todo/db/databaseHelper.dart';

class AllTasksTilesPage extends StatefulWidget {
  AllTasksTilesPage({Key key}) : super(key: key);
  @override
  _AllTasksTilesPageState createState() => _AllTasksTilesPageState();
}

class _AllTasksTilesPageState extends State<AllTasksTilesPage> {
  String _user = "Keyur Patel";
  var dbhelperProvider;
  String taskType;

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    taskType = args['taskType'];
    dbhelperProvider = Provider.of<DBHelper>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi " + _user),
        elevation: 0,
        backgroundColor: Color(0xFF3867D5),
      ),
      body: buildCustomTiles(),
    );
  }

  Widget buildCustomTiles() {
    return FutureBuilder(
      future: dbhelperProvider.fetchTasksByTypes(taskType),
      builder: (context, snapshot) => Container(
        margin: EdgeInsets.only(
          top: 18,
          left: 18,
          right: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Your all ${taskType.toLowerCase()} tasks",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF8B87B3),
                  ),
                ),
                Text(
                  "$taskType tasks - " +
                      dbhelperProvider.tasksbyTaskType.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF8B87B3),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                for (var item in dbhelperProvider.tasksbyTaskType)
                  UpcomingTodoTile(item),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
