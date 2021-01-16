import 'package:flutter/material.dart';

class TodosetreminderProvider with ChangeNotifier {
  bool _setreminder = true;

  TodosetreminderProvider(this._setreminder);

  bool get setreminder => _setreminder;

  setreminderSet(bool value) {
    _setreminder = value;
    notifyListeners();
  }
}
