import 'package:Todo/model/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeNotification extends StatefulWidget {
  final TodoTasksModel todoTask;
  final String todoNotification;
  bool showNotification = true;
  final bool loading;

  HomeNotification(this.todoTask, this.todoNotification, this.loading);
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
              bottom: 18,
            ),
            height: MediaQuery.of(context).size.height * 0.135,
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.25,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFFFFFFF),
                    ),
                    height: MediaQuery.of(context).size.height * 0.135,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 35,
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
                                  height: 8,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.54,
                                  child: widget.loading
                                      ? Shimmer.fromColors(
                                          child: Text(
                                            "Loading...",
                                            style: _subHeadingStyles,
                                          ),
                                          baseColor: Colors.grey.shade200,
                                          highlightColor: Colors.white,
                                        )
                                      : Text(
                                          widget.todoTask.todoName,
                                          style: _subHeadingStyles,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                        ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.loading
                                    ? Shimmer.fromColors(
                                        child: Text(
                                          "Loading...",
                                          style: _subHeadingStyles,
                                        ),
                                        baseColor: Colors.grey.shade200,
                                        highlightColor: Colors.white,
                                      )
                                    : Text(
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
                  ],
                ),
                Row(
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
              ],
            ),
          )
        : SizedBox.shrink();
  }

  String _dateFormatter() {
    var now = widget.todoTask.todoStartDate;
    String formattedTime = DateFormat('hh:mm a, MMM dd yyyy').format(now);
    return formattedTime;
  }
}
