import 'package:flutter/material.dart';

import '../common/custom_appbar.dart';
import '../custom_body.dart';
import '../common/custom_bottom_bar.dart';
import 'package:Todo/common/floating_button.dart';

class HomePage extends StatelessWidget {
  final String _user = "Keyur Patel";
  final String _subheading = "Today you have no tasks";
  final String _image = "assets/images/keyur.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        toolbarOpacity: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
              child: CustomAppBar(_user, _subheading, _image).build(context),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBody(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingButton(),
    );
  }
}
