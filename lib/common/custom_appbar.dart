import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String _username;
  final String _subHeading;
  final String _imageUrl;

  CustomAppBar(this._username, this._subHeading, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
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
      ),
      elevation: 0,
      actions: <Widget>[
        IconButton(
            iconSize: 50,
            alignment: Alignment.centerRight,
            icon: CircleAvatar(
              backgroundImage: AssetImage(_imageUrl),
              radius: 30,
            ),
            onPressed: () {})
      ],
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _username,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              _subHeading,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF1F1F1),
              ),
            ),
          ]),
      toolbarHeight: 90,
    );
  }
}
