import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFFF857C3),
                Color(0xFFE0139C),
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x50F456C3),
                blurRadius: 20.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0,
                  7,
                ),
              ),
            ],
          ),
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
