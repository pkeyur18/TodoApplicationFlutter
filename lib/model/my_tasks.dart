// import 'package:Todo/model/todo_list_model.dart';
// import 'package:flutter/material.dart';

import 'dart:convert';

TodoTasksModel getTodoList() {
  TodoTasksModel data = TodoTasksModel.fromJson(jsonDecode(todoListJson));
  return data;
}

class TodoTasksModel {
  int todoId;
  String todoType;
  String todoStartTime;
  String todoName;
  bool setReminder;
  bool completed;

  TodoTasksModel(
    this.todoId,
    this.todoType,
    this.todoStartTime,
    this.todoName,
    this.setReminder,
    this.completed,
  );

  factory TodoTasksModel.fromJson(dynamic json) {
    return TodoTasksModel(
      json['todoId'] as int,
      json['todoType'] as String,
      json['todoStartTime'] as String,
      json['todoName'] as String,
      json['setReminder'] as bool,
      json['completed'] as bool,
    );
  }
}

List<TodoTasksModel> myTodoList = [
  new TodoTasksModel(
    1,
    "Personal",
    "07:00 AM",
    "Go jogging with Christin",
    false,
    true,
  ),
  new TodoTasksModel(
    2,
    "Work",
    "10:00 AM",
    "Send project file",
    true,
    true,
  ),
  new TodoTasksModel(
    3,
    "Meeting",
    "12:00 PM",
    "Meeting with client",
    false,
    true,
  ),
  new TodoTasksModel(
    4,
    "Study",
    "03:00 PM",
    "Email client",
    true,
    false,
  ),
  new TodoTasksModel(
    5,
    "Personal",
    "07:00 AM",
    "Morning yoga",
    false,
    false,
  ),
  new TodoTasksModel(
    6,
    "Work",
    "10:00 AM",
    "Send project file",
    true,
    false,
  ),
  new TodoTasksModel(
    7,
    "Meeting",
    "03:00 PM",
    "Meeting with client",
    true,
    false,
  ),
  new TodoTasksModel(
    8,
    "Personal",
    "07:00 AM",
    "Morning yoga",
    true,
    false,
  ),
  new TodoTasksModel(
    9,
    "Meeting",
    "03:00 PM",
    "Meeting with client",
    true,
    false,
  ),
  new TodoTasksModel(
    10,
    "Personal",
    "07:00 AM",
    "Go jogging with Christin",
    true,
    false,
  ),
];

String todoListJson =
    '{"todoId": 1, "todoType" : "Work", "todoStartTime": "07:00 AM","todoName":"Send project file", "completed":false, "setReminder":true}';

// class MyTasksList extends StatefulWidget {
//   @override
//   _MyTasksListState createState() => _MyTasksListState();
// }

// class _MyTasksListState extends State<MyTasksList> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder(
//         future: DefaultAssetBundle.of(context)
//             .loadString("assets/json/todo_list.json"),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           var showData = json.decode(snapshot.data.toString());
//           return ListView.builder(
//             itemCount: showData.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 title: Text(showData[index]['user']),
//               );
//             },
//           );
//         },
//         future: TodoListUser().loadTasks(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return Center(
//               child: Text("Loading..."),
//             );
//           } else {
//             return ListView.builder(
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(snapshot.data.user),
//                   subtitle: Text(snapshot.data.image),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
