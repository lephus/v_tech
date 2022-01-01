import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/notification_local.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'vtech_id',
    'VTECH Notifications',
    importance: Importance.high,
    playSound: true
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessaginBackgroundHander(RemoteMessage message) async{
  await Firebase.initializeApp();
  print('is show message 1');
}



Future<void> main()async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessaginBackgroundHander);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );
  print("--");
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    //print("A new message onMessage MAIN 42");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if(notification != null && android != null){
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/logo'
              )
          )
      );
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
    //print("A new message onMessageOpenedApp MAIN 60");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if(notification != null && android != null){
      Get.toNamed(Routes.LIST_ORDER);
    }
  });
  NotificationLocal.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
