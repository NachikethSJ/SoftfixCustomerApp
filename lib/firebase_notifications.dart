import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Lisitnening to the background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print("Title: ${message.notification?.title}");
  print("body: ${message.notification?.body}");
  print("payload: ${message.data}");
}
// Listneing to the foreground messages

Future<void> _firebaseMessagingforegroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
}
class FirebaseApi{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initNotifications()async {
    await messaging.requestPermission();
    final fcmtoken = messaging.getToken();
    print("FCM TOKEN====>$fcmtoken");
     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
         alert: true,
         badge: true,
         sound: true,
     );
  }
}