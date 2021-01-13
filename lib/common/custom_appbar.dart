import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String _username;
  final String _subHeading;
  final String _imageUrl;

  CustomAppBar(this._username, this._subHeading, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 18,
        left: 18,
        right: 18,
      ),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF1F1F1),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  _subHeading,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF1F1F1),
                  ),
                ),
              ],
            ),
            Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(_imageUrl),
                radius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CUstomAppBarForPending extends StatelessWidget {
  final String _username;
  final String _imageUrl;

  CUstomAppBarForPending(this._username, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 18,
        left: 18,
        right: 18,
      ),
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFF1F1F1),
                  ),
                ),
              ],
            ),
            Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(_imageUrl),
                radius: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
