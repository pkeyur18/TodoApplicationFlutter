import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OpenBottomSheet extends StatefulWidget {
  @override
  _OpenBottomSheetState createState() => _OpenBottomSheetState();
}

class _OpenBottomSheetState extends State<OpenBottomSheet> {
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
          top: Radius.elliptical(
            MediaQuery.of(context).size.width * 0.75,
            50.0,
          ),
        ),
      ),
      builder: (builder) {
        return ChangeNotifierProvider(
          create: (context) => TodoDateTimeProvider(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: Theme.of(context).cursorColor,
                        initialValue: '',
                        maxLength: 50,
                        decoration: InputDecoration(
                          labelText: 'Task name',
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _addTaskBottomPageSelector(
                                "Personal", Color(0xFFFFD506)),
                            _addTaskBottomPageSelector(
                                "Work", Color(0xFF5DE61A)),
                            _addTaskBottomPageSelector(
                                "Meeting", Color(0xFFD10263)),
                            _addTaskBottomPageSelector(
                                "Study", Color(0xFF3044F2)),
                            _addTaskBottomPageSelector(
                                "Shopping", Color(0xFFF29130)),
                            _addTaskBottomPageSelector(
                                "Party", Color(0xFFF857C3)),
                          ],
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
                                      Provider.of<TodoDateTimeProvider>(context,
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
                                      Provider.of<TodoDateTimeProvider>(context,
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
                        margin: EdgeInsets.only(
                          top: 50,
                        ),
                        child: RaisedButton(
                          onPressed: () {},
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
                                "Add Task ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
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
                    top: 30,
                    right: 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addTaskBottomPageSelector(String taskName, Color color) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 6,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          taskName,
          style: TextStyle(
            color: Color(0xFF8E8E8E),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  String dateFormatter(DateTime date) {
    String formattedTime = DateFormat('dd MMM yyyy').format(date);
    return formattedTime;
  }

  String _timeFormatter(TimeOfDay time) {
    return time.format(context);
  }
}

class TodoDateTimeProvider extends ChangeNotifier {
  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  void openDatePicker(BuildContext context) async {
    var picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        new Duration(days: 1000),
      ),
      currentDate: DateTime.now(),
    );
    if (picked != null) {
      dateTime = picked;
      notifyListeners();
    }
  }

  void openTimePicker(BuildContext context) async {
    var picked = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    if (picked != null) {
      timeOfDay = picked;
      notifyListeners();
    }
  }
}
