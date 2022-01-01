import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationLocal{
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  static Future _notificationDetail()async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

  static Future init({bool initScheduled = false})async{
    final ANDROID = AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOS = IOSInitializationSettings();
    final settings = InitializationSettings(android:ANDROID, iOS: IOS);
    await _notification.initialize(
      settings,
      onSelectNotification: (payLoad)async{
      }
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
})async => _notification.show(
      id,
      title,
      body,
      await _notificationDetail(),
      payload: payLoad,
    );
}
