import 'package:Todo/model/todo_list_model.dart';
import 'package:flutter/material.dart';

class MyTasksList extends StatefulWidget {
  @override
  _MyTasksListState createState() => _MyTasksListState();
}

class _MyTasksListState extends State<MyTasksList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        // future: DefaultAssetBundle.of(context)
        //     .loadString("assets/json/todo_list.json"),
        // builder: (BuildContext context, AsyncSnapshot snapshot) {
        //   var showData = json.decode(snapshot.data.toString());
        //   return ListView.builder(
        //     itemCount: showData.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return ListTile(
        //         title: Text(showData[index]['user']),
        //       );
        //     },
        //   );
        // },
        future: TodoListUser().loadTasks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data.user),
                  subtitle: Text(snapshot.data.image),
                );
              },
            );
          }
        },
      ),
    );
  }
}
