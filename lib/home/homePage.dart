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
  int _selectedIndex = 0;

  @override
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  var tabs = [];
  var dbhelperProvider;

  void _tabSelector() {
    tabs = [];
    tabs.add(HomePageDashboard());
    tabs.add(TaskPageDashboard());
    tabs.add(PendingPageDashboard());
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
              child: tabs[widget._selectedIndex],
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
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Color(0xFFBEBEBE),
      currentIndex: widget._selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTaped,
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
          icon: Icon(
            Icons.pending_actions,
          ),
          label: 'Pending',
        ),
      ],
    );
  }

  void _onItemTaped(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }
}
