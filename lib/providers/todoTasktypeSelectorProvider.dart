import 'package:flutter/material.dart';

class TodoTasktypeSelectorProvider extends ChangeNotifier {
  String _selectedTaskType;

  String get selectedTaskType => _selectedTaskType;

  TodoTasktypeSelectorProvider(this._selectedTaskType);

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
