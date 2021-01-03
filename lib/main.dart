import 'package:flutter/material.dart';

import './landing_page.dart';
import 'home/home_page.dart';
import 'package:Todo/home/home_tasks.dart';

void main() => runApp(MyTodoApp());

class MyTodoApp extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/landing': (context) => LandingPage(),
        '/homepage': (context) => HomePage(),
        '/homepagetasks': (context) => HomeTasksPage(),
      },
      debugShowCheckedModeBanner: false,
      key: _scaffoldKey,
      title: 'Todo',
      home: LandingPage(),
    );
  }
}
