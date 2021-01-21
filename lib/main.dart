import 'package:Todo/db/userdetailsDatabaseHelper.dart';
import 'package:Todo/model/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'landingPage.dart';
import 'package:Todo/home/homePage.dart';

import 'db/databaseHelper.dart';
import 'db/database.dart';
import 'todoTasksGroup/taskGroupbyCategory.dart';

void main() => runApp(MyTodoApp());

class MyTodoApp extends StatelessWidget {
  final UserDetails userDetails = new UserDetails(
    id: 1,
    profilePicture: null,
    userName: null,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoDatabase.db,
        ),
        ChangeNotifierProvider(
          create: (context) => DBHelper(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserdetailsDBHelper(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/landing': (context) => LandingPage(),
          '/homepage': (context) => HomeTasksPage(userDetails),
          '/tasktilepage': (context) => AllTasksTilesPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Todo',
        home: LandingPage(),
      ),
    );
  }
}
