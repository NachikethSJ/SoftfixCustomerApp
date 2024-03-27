import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_customer_app/screens/common_screens/app.dart';
import 'package:salon_customer_app/screens/common_screens/custom_providers.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var state = AuthProvider(await SharedPreferences.getInstance());
   // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(
    CustomProvider(
      state: state,
      child: const App(),
    ),
  );
  // Future backgroundHandler(RemoteMessage msg) async {}

}
