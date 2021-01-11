import 'package:Todo/db/TodotasksDb.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OpenBottomSheet extends StatefulWidget {
  String selectedTaskType;
  @override
  _OpenBottomSheetState createState() => _OpenBottomSheetState();
}

class _OpenBottomSheetState extends State<OpenBottomSheet> {
  final _todoTaskName = TextEditingController();
  var dbhelperProvider;
  // var dateTimeprovider;
  // var tasktypeProvider;

  @override
  Widget build(BuildContext context) {
    dbhelperProvider = Provider.of<DBHelper>(context);
    // dateTimeprovider = Provider.of<TodoDateTimeProvider>(context);
    // tasktypeProvider = Provider.of<TodoTasktypeSelectorProvider>(context);
    return WillPopScope(
      onWillPop: () => _backButtonPressed(),
      child: SizedBox(
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
          create: (context) => TodoDateTimeProvider(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
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
                        create: (context) => TodoTasktypeSelectorProvider(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Consumer<TodoTasktypeSelectorProvider>(
                              builder: (context, value, child) {
                            widget.selectedTaskType = value._selectedTaskType;
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
                      ChangeNotifierProvider(
                        create: (context) => TodoTasktypeSelectorProvider(),
                        child: Consumer<TodoDateTimeProvider>(
                          builder: (context, value, __) => Container(
                            margin: EdgeInsets.only(
                              top: 50,
                            ),
                            child: RaisedButton(
                              onPressed: () {
                                dbhelperProvider.submitForm(
                                  context,
                                  value.dateTime,
                                  value.timeOfDay,
                                  _todoTaskName.text,
                                  widget.selectedTaskType,
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

class TodoDateTimeProvider with ChangeNotifier {
  DateTime _dateTime = DateTime.now().add(
    Duration(hours: 2),
  );
  TimeOfDay _timeOfDay = TimeOfDay.fromDateTime(
    DateTime.now().add(
      Duration(hours: 2),
    ),
  );

  DateTime get dateTime => _dateTime;

  TimeOfDay get timeOfDay => _timeOfDay;

  set dateTimeSet(DateTime date) {
    _dateTime = date;
    notifyListeners();
  }

  set timeOdDaySet(TimeOfDay time) {
    _timeOfDay = time;
    notifyListeners();
  }

  void openDatePicker(BuildContext context) async {
    var picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        new Duration(days: 1000),
      ),
      currentDate: DateTime.now(),
    );
    if (picked != null) {
      _dateTime = picked;
      notifyListeners();
    } else {
      _dateTime = DateTime.now();
      notifyListeners();
    }

    openTimePicker(context);
  }

  void openTimePicker(BuildContext context) async {
    var picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      _timeOfDay = picked;
    } else {
      _timeOfDay = TimeOfDay.fromDateTime(
        DateTime.now().add(
          new Duration(
            hours: 2,
          ),
        ),
      );
    }
    notifyListeners();
  }
}

class TodoTasktypeSelectorProvider extends ChangeNotifier {
  String _selectedTaskType = "Personal";

  String get selectedTaskType => _selectedTaskType;

  Widget addPersonalSelector(String taskName, Color color) {
    return GestureDetector(
      onTap: () {
        _selectedTaskType = taskName;
        notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: _selectedTaskType == taskName ? color : Color(0xFF),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          children: [
            _selectedTaskType != taskName
                ? CircleAvatar(
                    backgroundColor: color,
                    radius: 6,
                  )
                : SizedBox.shrink(),
            _selectedTaskType != taskName
                ? SizedBox(
                    width: 8,
                  )
                : SizedBox.shrink(),
            Text(
              taskName,
              style: TextStyle(
                color: _selectedTaskType == taskName
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF8E8E8E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addWorkSelector(String taskName, Color color) {
    return GestureDetector(
      onTap: () {
        _selectedTaskType = taskName;
        notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: _selectedTaskType == taskName ? color : Color(0xFF),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          children: [
            _selectedTaskType != taskName
                ? CircleAvatar(
                    backgroundColor: color,
                    radius: 6,
                  )
                : SizedBox.shrink(),
            _selectedTaskType != taskName
                ? SizedBox(
                    width: 8,
                  )
                : SizedBox.shrink(),
            Text(
              taskName,
              style: TextStyle(
                color: _selectedTaskType == taskName
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF8E8E8E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addMeetingSelector(String taskName, Color color) {
    return GestureDetector(
      onTap: () {
        _selectedTaskType = taskName;
        notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: _selectedTaskType == taskName ? color : Color(0xFF),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          children: [
            _selectedTaskType != taskName
                ? CircleAvatar(
                    backgroundColor: color,
                    radius: 6,
                  )
                : SizedBox.shrink(),
            _selectedTaskType != taskName
                ? SizedBox(
                    width: 8,
                  )
                : SizedBox.shrink(),
            Text(
              taskName,
              style: TextStyle(
                color: _selectedTaskType == taskName
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF8E8E8E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addStudySelector(String taskName, Color color) {
    return GestureDetector(
      onTap: () {
        _selectedTaskType = taskName;
        notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: _selectedTaskType == taskName ? color : Color(0xFF),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          children: [
            _selectedTaskType != taskName
                ? CircleAvatar(
                    backgroundColor: color,
                    radius: 6,
                  )
                : SizedBox.shrink(),
            _selectedTaskType != taskName
                ? SizedBox(
                    width: 8,
                  )
                : SizedBox.shrink(),
            Text(
              taskName,
              style: TextStyle(
                color: _selectedTaskType == taskName
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF8E8E8E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addShoppingSelector(String taskName, Color color) {
    return GestureDetector(
      onTap: () {
        _selectedTaskType = taskName;
        notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: _selectedTaskType == taskName ? color : Color(0xFF),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          children: [
            _selectedTaskType != taskName
                ? CircleAvatar(
                    backgroundColor: color,
                    radius: 6,
                  )
                : SizedBox.shrink(),
            _selectedTaskType != taskName
                ? SizedBox(
                    width: 8,
                  )
                : SizedBox.shrink(),
            Text(
              taskName,
              style: TextStyle(
                color: _selectedTaskType == taskName
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF8E8E8E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addPartySelector(String taskName, Color color) {
    return GestureDetector(
      onTap: () {
        _selectedTaskType = taskName;
        notifyListeners();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: _selectedTaskType == taskName ? color : Color(0xFF),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Row(
          children: [
            _selectedTaskType != taskName
                ? CircleAvatar(
                    backgroundColor: color,
                    radius: 6,
                  )
                : SizedBox.shrink(),
            _selectedTaskType != taskName
                ? SizedBox(
                    width: 8,
                  )
                : SizedBox.shrink(),
            Text(
              taskName,
              style: TextStyle(
                color: _selectedTaskType == taskName
                    ? Color(0xFFFFFFFF)
                    : Color(0xFF8E8E8E),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
