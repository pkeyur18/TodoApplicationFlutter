import 'package:Todo/db/TodotasksDb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../model/my_tasks.dart';

class UpcomingTodoTile extends StatefulWidget {
  final TodoTasksModel data;
  final DateTime today = DateTime.now();

  UpcomingTodoTile(this.data);

  @override
  _UpcomingTodoTileState createState() => _UpcomingTodoTileState();
}

class _UpcomingTodoTileState extends State<UpcomingTodoTile> {
  var dbhelperProvider;
  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 14,
      ),
      height: 70,
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
                  GestureDetector(
                    onTap: () {
                      dbhelperProvider.updateTasksCompletedStatus(
                          widget.data.todoId, !widget.data.completed);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 70,
                          decoration: BoxDecoration(
                            color: (widget.data.todoType == "Personal"
                                ? Color(0xFFFFD506)
                                : (widget.data.todoType == "Work"
                                    ? Color(0xFF1ED102)
                                    : (widget.data.todoType == "Meeting"
                                        ? Color(0xFFD10263)
                                        : (widget.data.todoType == "Study"
                                            ? Color(0xFF3044F2)
                                            : (widget.data.todoType ==
                                                    "Shopping"
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
                              dbhelperProvider.updateTasksCompletedStatus(
                                  widget.data.todoId, !widget.data.completed);
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _dateFormatter(),
                                style: TextStyle(
                                  color: Color(0xFFC6C6C8),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                _timeFormatter(),
                                style: TextStyle(
                                  color: Color(0xFFC6C6C8),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            widget.data.todoName,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
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
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        dbhelperProvider.updateTasksReminderStatus(
                            widget.data.todoId, !widget.data.setReminder);
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
              onTap: () {
                dbhelperProvider.deleteTask(
                  widget.data,
                );
              }),
        ],
      ),
    );
  }

  String _timeFormatter() {
    var now = widget.data.todoStartDate;
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }

  String _dateFormatter() {
    var now = widget.data.todoStartDate;
    String formattedTime = DateFormat('MMM dd yyyy').format(now);
    return formattedTime;
  }
}
