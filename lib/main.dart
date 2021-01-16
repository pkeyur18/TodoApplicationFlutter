import 'package:Todo/common/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'landingPage.dart';
import 'package:Todo/home/homePage.dart';

import 'db/databaseHelper.dart';
import 'db/database.dart';
import 'todoTasksGroup/taskGroupbyCategory.dart';

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
        ChangeNotifierProvider(
          create: (context) => ProfileImageProvider(),
        )
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
