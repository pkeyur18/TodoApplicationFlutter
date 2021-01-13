import 'package:flutter/material.dart';

class TaskTiles extends StatefulWidget {
  final String taskHeading;
  final String taskSubheading;
  final Widget taskImage;

  TaskTiles(this.taskHeading, this.taskSubheading, this.taskImage);

  @override
  _TaskTilesState createState() => _TaskTilesState();
}

class _TaskTilesState extends State<TaskTiles> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/tasktilepage",
          arguments: {"taskType": widget.taskHeading},
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 0,
              offset: Offset(
                5,
                5,
              ),
            ),
          ],
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.taskImage,
            SizedBox(
              height: 10,
            ),
            Text(
              widget.taskHeading,
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF686868),
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.taskSubheading,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFA1A1A1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
