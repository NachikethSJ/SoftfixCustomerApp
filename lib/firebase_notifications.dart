// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:salon_customer_app/screens/common_screens/notification.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'main.dart';
//
// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: false,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('user granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('user granted provisional permission');
//     } else {
//       print('user denied permission');
//     }
//   }
//
//   void initLocalNotifications(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//     const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iosInitializationSettings = const DarwinInitializationSettings();
//     var initializationSetting = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSetting,
//       onDidReceiveNotificationResponse: (payload) async {
//         if (await logged()) {
//           navigatorKey.currentState?.push(MaterialPageRoute(
//               builder: (context) => const NotificationScreen()));
//         } else {
//           handleMessage(context, message);
//         }
//       },
//     );
//   }
//
//   void firebaseInit(BuildContext context) async {
//     FirebaseMessaging.onMessage.listen((message) {
//       if (kDebugMode) {
//         print(message.notification!.title.toString());
//         print(message.notification!.body.toString());
//         print(message.data.toString());
//         print("object");
//       }
//       if (Platform.isIOS) {
//         initLocalNotifications(context, message);
//         forgroundMessage();
//       }
//
//       if (Platform.isAndroid) {
//         initLocalNotifications(context, message);
//         showNotification(message);
//       }
//     });
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         message.notification!.android!.channelId.toString(),
//         message.notification!.android!.channelId.toString(),
//         importance: Importance.max,
//         showBadge: true,
//         playSound: true,
//         sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'));
//
//     AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails(
//         channel.id.toString(), channel.name.toString(),
//         channelDescription: 'your channel description',
//         importance: Importance.high,
//         priority: Priority.high,
//         ticker: 'ticker');
//
//     const DarwinNotificationDetails darwinNotificationDetails =
//     DarwinNotificationDetails(
//       presentSound: true,
//       presentBadge: true,
//       presentAlert: true,
//     );
//
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );
//
//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//           1,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }
//
//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }
//
//   void isTokenRefresh() {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       print('refresh');
//     });
//   }
//
//   //handle tap on notification when app is in background or terminated
//   Future<void> setupInteractMessage(BuildContext context) async {
//     // when app is terminated
//     RemoteMessage? initialMessage =
//     await FirebaseMessaging.instance.getInitialMessage();
//
//     if (initialMessage != null) {
//       handleMessage(context, initialMessage);
//     }
//
//     //when app ins background
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       handleMessage(context, event);
//     });
//   }
//
//   Future<void> handleMessage(
//       BuildContext context, RemoteMessage message) async {
//     print('handle message function');
//     if (await logged()) {
//       navigatorKey.currentState?.push(
//           MaterialPageRoute(builder: (context) => const NotificationScreen()));
//     }
//   }
//
//   Future forgroundMessage() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   Future<bool> logged() async {
//     var pref = await SharedPreferences.getInstance();
//     var token = pref.getString('userDetails') ?? '';
//     print('logged check ===');
//     print('token======>$token');
//     return Future.value(token.isNotEmpty);
//   }
// }