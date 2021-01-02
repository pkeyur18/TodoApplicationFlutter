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
      appBar: CustomAppBar(_user, _subheading, _image).build(context),
      body: CustomBody(),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingButton(),
    );
  }
}
