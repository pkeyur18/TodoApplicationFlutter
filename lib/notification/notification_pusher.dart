import 'package:Todo/model/my_tasks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotification {
  Future<void> showNotification() async {
    var android = new AndroidNotificationDetails(
      'id',
      'channel ',
      'description',
      priority: Priority.high,
      importance: Importance.max,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    // var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: null);
    await flutterLocalNotificationsPlugin.show(
        1, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
  }

  Future<void> scheduleNotification(TodoTasksModel tasksModel) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      priority: Priority.max,
      importance: Importance.max,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      tasksModel.todoId,
      tasksModel.todoType,
      tasksModel.todoName,
      tasksModel.todoStartDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: "Welcome to the Local Notification demo",
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
