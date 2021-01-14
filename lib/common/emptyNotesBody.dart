import 'package:flutter/material.dart';

class EmptyNotesBody extends StatelessWidget {
  final String assetImage = "assets/images/emptypendingnotes.png";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          assetImage,
          width: MediaQuery.of(context).size.width * 0.50,
        ),
        SizedBox(
          height: 70.3,
        ),
        Text(
          'No Tasks',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF554E8F)),
        ),
        SizedBox(
          height: 11,
        ),
        Text(
          'You have no task to do.',
          style: TextStyle(
            fontSize: 17,
            color: Color(0xFF82A0B7),
          ),
        ),
      ],
    );
  }
}

class EmptyPendingNotes extends StatelessWidget {
  final String assetName = 'assets/images/celebration.png';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          assetName,
          width: MediaQuery.of(context).size.width * 0.65,
        ),
        SizedBox(
          height: 70.3,
        ),
        Text(
          'No Pending Tasks',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF554E8F)),
        ),
        SizedBox(
          height: 11,
        ),
        Text(
          "Hurray.! you don't have any pending task.",
          style: TextStyle(
            fontSize: 17,
            color: Color(0xFF82A0B7),
          ),
        ),
      ],
    );
  }
}
