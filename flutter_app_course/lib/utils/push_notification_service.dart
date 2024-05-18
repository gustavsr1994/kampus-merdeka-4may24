import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // Request permission for handling foreground notifications
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else {
        print('User declined permission');
      }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Handle incoming notifications when the app is in the foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Message 1 :: ${jsonEncode(message)}");
        showNotification(message.notification!.title ?? '',
            message.notification!.body ?? '', message.data);
      });

      // Handle notification taps when the app is in the background or terminated
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Notification clicked: ${message.notification!.title}');
      });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // print("Message 2 :: ${jsonEncode(message)}");
    showNotification(message.notification!.title ?? '',
        message.notification!.body ?? '', message.data);
  }

  void showNotification(
      String title, String body, Map<String, dynamic> data) async {
    var androidPlatformChannel = AndroidNotificationDetails(
        'channel_id1', 'channel_name',
        channelDescription: 'channel_desc', importance: Importance.max);
    var iOSPlatformChannel = DarwinNotificationDetails();
    var platformChannel = NotificationDetails(
        android: androidPlatformChannel, iOS: iOSPlatformChannel);

    await _flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannel);
  }
}
