import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future initialize() async {
    var tokenFCM = await _firebaseMessaging.getToken();
    print('Token FCM : $tokenFCM');
    FirebaseMessaging.onBackgroundMessage(
        (message) => _firebaseMessageBackground(message));
    NotificationSettings notificationSettings =
        await _firebaseMessaging.requestPermission();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await _localNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((message) {
      showNotification(
          message.notification!.title ?? '', message.notification!.body ?? '');
    });
  }

  Future<void> _firebaseMessageBackground(RemoteMessage message) async {
    showNotification(
        message.notification!.title ?? '', message.notification!.body ?? '');
  }

  void showNotification(String title, String body) {
    var androidPlatformChannel = AndroidNotificationDetails(
        'channel_id_1', 'channel_name',
        importance: Importance.high);
    var platformChannel = NotificationDetails(android: androidPlatformChannel);
    _localNotificationsPlugin.show(0, title, body, platformChannel);
  }
}
