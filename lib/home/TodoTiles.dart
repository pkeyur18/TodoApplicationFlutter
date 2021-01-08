import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/my_tasks.dart';

class CustomTodoTile extends StatefulWidget {
  final TodoTasksModel data;
  final DateTime today = DateTime.now();

  CustomTodoTile(this.data);

  @override
  _CustomTodoTileState createState() => _CustomTodoTileState();
}

class _CustomTodoTileState extends State<CustomTodoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 14,
      ),
      height: 55,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.20,
        child: Container(
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
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 55,
                        decoration: BoxDecoration(
                          color: (widget.data.todoType == "Personal"
                              ? Color(0xFFFFD506)
                              : (widget.data.todoType == "Work"
                                  ? Color(0xFF1ED102)
                                  : (widget.data.todoType == "Meeting"
                                      ? Color(0xFFD10263)
                                      : (widget.data.todoType == "Study"
                                          ? Color(0xFF3044F2)
                                          : (widget.data.todoType == "Shopping"
                                              ? Color(0xFFF29130)
                                              : Color(0xFFF857C3)))))),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.data.completed = !widget.data.completed;
                            });
                          },
                          child: Icon(
                            widget.data.completed
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: widget.data.completed
                                ? Color(0xFF91DC5A)
                                : Color(0xFFD9D9D9),
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 12,
                        ),
                        child: Text(
                          _dateFormatter(),
                          style: TextStyle(
                            color: Color(0xFFC6C6C8),
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Text(
                          widget.data.todoName,
                          style: widget.data.completed
                              ? TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                )
                              : TextStyle(
                                  color: Color(0xFF554E8F),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.data.setReminder = !widget.data.setReminder;
                        });
                      },
                      child: Icon(
                        Icons.notifications,
                        color: widget.data.setReminder
                            ? Color(0xFFFFDC00)
                            : Color(0xFFD9D9D9),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Color(0xFF),
            foregroundColor: Color(0xFFFB3636),
            closeOnTap: true,
            icon: Icons.delete,
            onTap: () => _deleteTask(widget.data.todoId),
          ),
        ],
      ),
    );
  }

  String _dateFormatter() {
    var now = widget.data.todoStartDate;
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }

  void _deleteTask(int id) {}
}
