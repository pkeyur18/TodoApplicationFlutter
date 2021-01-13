import 'package:Todo/todoTasksGroup/allTasksTiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './landing_page.dart';
import 'package:Todo/home/home_page.dart';

import 'db/TodotasksDb.dart';
import 'db/database.dart';

void main() => runApp(MyTodoApp());

class MyTodoApp extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/landing': (context) => LandingPage(),
          '/homepage': (context) => HomeTasksPage(),
          '/tasktilepage': (context) => AllTasksTilesPage(),
        },
        debugShowCheckedModeBanner: false,
        key: _scaffoldKey,
        title: 'Todo',
        home: LandingPage(),
      ),
    );
  }
}
