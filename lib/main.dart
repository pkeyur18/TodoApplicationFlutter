import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'landingPage.dart';
import 'package:Todo/home/homePage.dart';

import 'db/databaseHelper.dart';
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
        },
        debugShowCheckedModeBanner: false,
        key: _scaffoldKey,
        title: 'Todo',
        home: LandingPage(),
      ),
    );
  }
}
