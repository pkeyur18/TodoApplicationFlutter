// import 'package:Todo/common/customBottomSheet.dart';
import 'package:Todo/db/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/my_tasks.dart';

// ignore: must_be_immutable
class CustomTodoTile extends StatefulWidget {
  final TodoTasksModel data;
  final DateTime today = DateTime.now();

  String selectedTaskType;
  bool checkedValue = true;

  CustomTodoTile(this.data);

  @override
  _CustomTodoTileState createState() => _CustomTodoTileState();
}

class _CustomTodoTileState extends State<CustomTodoTile> {
  // final _todoTaskName = TextEditingController();
  var dbhelperProvider;
  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return Container(
      margin: EdgeInsets.only(
        top: 14,
      ),
      height: 55,
      child: Dismissible(
        onDismissed: (direction) {
          dbhelperProvider.deleteTask(
            widget.data,
          );
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${widget.data.todoName} dismissed",
              ),
            ),
          );
        },
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                title: const Text(
                  "Delete Confirmation",
                ),
                content: Text(
                  "Are you sure you want to delete task ${widget.data.todoName} ?",
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color(0xFF838383),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      "Delete",
                    ),
                  ),
                ],
              );
            },
          );
        },
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Color(0xFFFFCFCF),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            child: Icon(
              Icons.delete,
              color: Color(0xFFFB3636),
            ),
          ),
        ),
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
                      setState(() {
                        widget.data.completed = !widget.data.completed;
                      });
                      dbhelperProvider.updateTasksCompletedStatus(
                          widget.data.todoId, widget.data.completed);
                    },
                    child: Row(
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
                              setState(() {
                                widget.data.completed = !widget.data.completed;
                              });
                              dbhelperProvider.updateTasksCompletedStatus(
                                  widget.data.todoId, widget.data.completed);
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
                              fontSize: 12,
                            ),
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.data.setReminder = !widget.data.setReminder;
                        });
                        dbhelperProvider.updateTasksReminderStatus(
                            widget.data.todoId, widget.data.setReminder);
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
                  Container(
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // _openBottomsheetForEdit();
                      },
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _dateFormatter() {
    var now = widget.data.todoStartDate;
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }
}
