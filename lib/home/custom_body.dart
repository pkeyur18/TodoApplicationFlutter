import 'package:flutter/material.dart';

class EmptyNotesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/emptynotes.png',
          width: 120,
          height: 165,
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
          style: TextStyle(fontSize: 17, color: Color(0xFF82A0B7)),
        ),
      ],
    );
  }
}
