import 'package:flutter/material.dart';

import 'package:Todo/common/custom_appbar.dart';
import 'package:Todo/TodoTiles.dart';
import 'package:Todo/home_notification.dart';
import '../common/custom_bottom_bar.dart';
import 'package:Todo/common/floating_button.dart';
import 'package:Todo/model/my_tasks.dart';

class HomeTasksPage extends StatefulWidget {
  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  int _tasks = myTodoList.length;
  String _user = "Keyur Patel";
  String _subheading = "Today you have ";
  String _image = "assets/images/keyur.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        toolbarOpacity: 0,
      ),
      body: SafeArea(
        child: Scaffold(
          body: Container(
            child: Container(
              child: Column(children: [
                _todayReminder(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: _homeDashboard(context),
                  ),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: CustomBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CustomFloatingButton(),
        ),
      ),
    );
  }

  Widget _todayReminder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: <Color>[
            Color(0xFF81C7F5),
            Color(0xFF3867D5),
          ],
        ),
      ),
      child: Container(
        child: Column(
          children: [
            CustomAppBar(_user, _subheading + "$_tasks tasks", _image)
                .build(context),
            HomeNotification().build(context),
          ],
        ),
      ),
    );
  }

  Widget _homeDashboard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 18,
        left: 18,
        right: 18,
      ),
      child: Column(
        children: [
          Container(
            child: Row(
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
          ),
          for (var data in myTodoList) CustomTodoTile(data),
        ],
      ),
    );
  }
}
