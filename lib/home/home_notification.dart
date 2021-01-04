import 'package:Todo/model/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomeNotification extends StatefulWidget {
  final TodoTasksModel todoTask;
  final String todoNotification;
  bool showNotification = true;

  HomeNotification(this.todoTask, this.todoNotification);
  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  final TextStyle _subHeadingStyles = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return widget.showNotification
        ? Container(
            margin: EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.135,
                  width: MediaQuery.of(context).size.width,
                ),
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
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
                    left: 23,
                    top: MediaQuery.of(context).size.height * 0.135 / 4,
                    right: 34,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.todoNotification,
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
                              widget.todoTask.todoName,
                              style: _subHeadingStyles,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              _dateFormatter(),
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
                    top: 8,
                    // right: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.showNotification = !widget.showNotification;
                          });
                        },
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
          )
        : SizedBox.shrink();
  }

  String _dateFormatter() {
    var now = widget.todoTask.todoStartDate;
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }
}
