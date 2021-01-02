import 'package:flutter/material.dart';

import 'package:Todo/common/custom_appbar.dart';
import '../common/custom_bottom_bar.dart';
import 'package:Todo/common/floating_button.dart';

class HomeTasksPage extends StatelessWidget {
  final int _tasks = 1;
  final String _user = "Keyur Patel";
  final String _subheading = "Today you have ";
  final String _image = "assets/images/keyur.jpg";

  final TextStyle _subHeadingStyles = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

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
          body: Column(children: [
            todayReminder(context),
          ]),
          bottomNavigationBar: CustomBottomBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CustomFloatingButton(),
        ),
      ),
    );
  }

  Widget todayReminder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: <Widget>[
            CustomAppBar(_user, _subheading + "$_tasks tasks", _image)
                .build(context),
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.135,
              width: MediaQuery.of(context).size.width,
            ),
            Opacity(
              opacity: 0.25,
              child: Container(
                margin: EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFFFFFFF),
                ),
                height: MediaQuery.of(context).size.height * 0.125,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 36,
                top: MediaQuery.of(context).size.height * 0.11 / 4,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today Reminder",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Meeting with client",
                          style: _subHeadingStyles,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1:00 PM",
                          style: _subHeadingStyles,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Image(
                      width: 52.32,
                      image: const AssetImage('assets/images/bell.png'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.clear,
                      color: Color(0xFFFFFFFF),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
