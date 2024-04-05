import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_customer_app/screens/common_screens/app.dart';
import 'package:salon_customer_app/screens/common_screens/custom_providers.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var messaging = FirebaseMessaging.instance;
  messaging.getToken().then((token) async {
    print("Device Token==>$token");
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var state = AuthProvider(await SharedPreferences.getInstance());


  runApp(
    CustomProvider(
      state: state,
      child: const App(),
    ),
  );


}
