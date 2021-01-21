import 'package:Todo/db/databaseHelper.dart';
import 'package:Todo/providers/todoDateTimeProvider.dart';
import 'package:Todo/providers/todoSetreminderProvider.dart';
import 'package:Todo/providers/todoTasktypeSelectorProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OpenBottomSheet extends StatefulWidget {
  String selectedTaskType;
  bool checkedValue = true;
  @override
  _OpenBottomSheetState createState() => _OpenBottomSheetState();
}

class _OpenBottomSheetState extends State<OpenBottomSheet> {
  final _todoTaskName = TextEditingController();
  var dbhelperProvider;

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    return WillPopScope(
      onWillPop: () => _backButtonPressed(),
      child: FloatingActionButton(
        elevation: 5,
        child: Container(
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        onPressed: () {
          _showMyBottomSheet();
        },
      ),
    );
  }

  void _showMyBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (builder) {
        return ChangeNotifierProvider(
          create: (context) => TodoDateTimeProvider(
            DateTime.now().add(Duration(hours: 1)),
            TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1))),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.70,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 15,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: 18,
                      right: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Add new task",
                          style: TextStyle(
                            color: Color(0xFF554E8F),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        TextFormField(
                          controller: _todoTaskName,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).cursorColor,
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: 'Task name',
                            hintText: 'Go jogging with Christin',
                            labelStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF554E8F),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF554E8F),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Divider(
                            color: Color(0xFFCFCFCF),
                          ),
                        ),
                        ChangeNotifierProvider(
                          create: (context) =>
                              TodoTasktypeSelectorProvider("Personal"),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Consumer<TodoTasktypeSelectorProvider>(
                                builder: (context, value, child) {
                              widget.selectedTaskType = value.selectedTaskType;
                              return Row(
                                children: [
                                  value.addPersonalSelector(
                                      "Personal", Color(0xFFFFD506)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  value.addWorkSelector(
                                      "Work", Color(0xFF5DE61A)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  value.addMeetingSelector(
                                      "Meeting", Color(0xFFD10263)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  value.addStudySelector(
                                      "Study", Color(0xFF3044F2)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  value.addShoppingSelector(
                                      "Shopping", Color(0xFFF29130)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  value.addPartySelector(
                                      "Party", Color(0xFFF857C3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Divider(
                            color: Color(0xFFCFCFCF),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Consumer<TodoDateTimeProvider>(
                            builder: (context, value, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<TodoDateTimeProvider>(
                                                context,
                                                listen: false)
                                            .openDatePicker(context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Choose date",
                                            style: TextStyle(
                                              color: Color(0xFF554E8F),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 15,
                                            ),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Color(0xFF554E8F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                        dateFormatter(value.dateTime),
                                        style: TextStyle(
                                          color: Color(0xFF404040),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<TodoDateTimeProvider>(
                                                context,
                                                listen: false)
                                            .openTimePicker(context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Choose time",
                                            style: TextStyle(
                                              color: Color(0xFF554E8F),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 15,
                                            ),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Color(0xFF554E8F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Text(
                                        _timeFormatter(value.timeOfDay),
                                        style: TextStyle(
                                          color: Color(0xFF404040),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 6,
                          ),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => TodosetreminderProvider(true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<TodosetreminderProvider>(
                                builder: (_, value, __) => GestureDetector(
                                  onTap: () {
                                    value.setreminderSet(!value.setreminder);
                                    widget.checkedValue = value.setreminder;
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Set Reminder?",
                                        style: TextStyle(
                                          color: Color(0xFF554E8F),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 12.0,
                                        ),
                                      ),
                                      Icon(
                                        value.setreminder
                                            ? Icons.check_circle
                                            : Icons.radio_button_unchecked,
                                        color: value.setreminder
                                            ? Color(0xFF91DC5A)
                                            : Color(0xFFD9D9D9),
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ChangeNotifierProvider(
                          create: (context) =>
                              TodoTasktypeSelectorProvider("Personal"),
                          child: Consumer<TodoDateTimeProvider>(
                            builder: (context, value, __) => Container(
                              margin: EdgeInsets.only(
                                top: 50,
                              ),
                              child: RaisedButton(
                                onPressed: () {
                                  dbhelperProvider.submitForm(
                                    value.dateTime,
                                    value.timeOfDay,
                                    _todoTaskName.text,
                                    widget.selectedTaskType,
                                    widget.checkedValue,
                                  );
                                  _todoTaskName.clear();
                                  Navigator.pop(context);
                                },
                                color: Color(0xFF),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF7EB6FF),
                                          Color(0xFF5F87E7),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 70,
                                    ),
                                    child: const Text(
                                      "Schedule",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      right: MediaQuery.of(context).size.width * 0.075,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _todoTaskName.clear();
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _backButtonPressed() {
    return Navigator.maybePop(context);
  }

  String dateFormatter(DateTime date) {
    String formattedTime = DateFormat('dd MMM yyyy').format(date);
    return formattedTime;
  }

  String _timeFormatter(TimeOfDay time) {
    return time.format(context);
  }
}
