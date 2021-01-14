import 'package:Todo/home/TaskPageDashboard.dart';
import 'package:Todo/home/homePageDashboard.dart';
import 'package:Todo/home/pendingPageDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:Todo/common/customBottomSheet.dart';
import 'package:Todo/db/databaseHelper.dart';

// ignore: must_be_immutable
class HomeTasksPage extends StatefulWidget {
  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  var tabs = [];
  var dbhelperProvider;
  int selectedIndex = 0;

  void _tabSelector() {
    tabs = [];
    tabs.add(HomePageDashboard());
    tabs.add(TaskPageDashboard());
    tabs.add(PendingPageDashboard());
  }

  @override
  void initState() {
    super.initState();
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (value) => pageChanged(value),
      children: <Widget>[
        HomePageDashboard(),
        TaskPageDashboard(),
        PendingPageDashboard(),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    _tabSelector();
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
              child: buildPageView(),
            ),
          ),
          bottomNavigationBar: _customBottomBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: OpenBottomSheet(),
        ),
      ),
    );
  }

  Widget _customBottomBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Color(0xFFBEBEBE),
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) => bottomTapped(value),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.widgets),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pending_actions),
          label: 'Pending',
        ),
      ],
    );
  }
}
