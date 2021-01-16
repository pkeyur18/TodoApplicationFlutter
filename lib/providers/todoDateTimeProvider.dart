import 'package:flutter/material.dart';

class TodoDateTimeProvider with ChangeNotifier {
  DateTime _dateTime;
  TimeOfDay _timeOfDay;

  TodoDateTimeProvider(this._dateTime, this._timeOfDay);

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
      firstDate: DateTime(2010),
      lastDate: DateTime.now().add(
        new Duration(days: 1000),
      ),
      currentDate: DateTime.now(),
    );
    if (picked != null) {
      _dateTime = picked;
      notifyListeners();
      openTimePicker(context);
    } else {
      _dateTime = _dateTime;
    }
  }

  void openTimePicker(BuildContext context) async {
    var picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null) {
      _timeOfDay = picked;
    } else {
      _timeOfDay = _timeOfDay;
    }
    notifyListeners();
  }
}
