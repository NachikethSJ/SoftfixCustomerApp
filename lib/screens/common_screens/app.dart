import 'package:flutter/material.dart';
import 'package:salon_customer_app/firebase_notifications.dart';
import 'package:salon_customer_app/screens/common_screens/splash_screen.dart';
import 'package:salon_customer_app/styles/app_theme.dart';

import '../../main.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
 NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {});
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      themeMode: ThemeMode.light,
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
