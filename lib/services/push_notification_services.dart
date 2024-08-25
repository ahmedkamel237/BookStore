import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stor_app/services/local_notifications_services.dart';

class PushNotificationServices {
  PushNotificationServices._();

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      sendTokenToServer(value!);
    });
    messaging.onTokenRefresh.listen((event) {
      sendTokenToServer(event);
    });

    messaging.subscribeToTopic("all").then((value) {
      log("subscribed");
    });

    FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);

    FirebaseMessaging.onMessage.listen(handelForegroundMessage);
  }

  static Future<void> handelBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log(message.notification?.title ?? '');
  }

  static void sendTokenToServer(String token) {}

  static void handelForegroundMessage(RemoteMessage message) {
    /// Show Local Notification.
    LocalNotificationService.showBasicNotifications(message);
  }
}
