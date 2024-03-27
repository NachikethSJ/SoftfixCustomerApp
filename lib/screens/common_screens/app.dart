import 'package:flutter/material.dart';
import 'package:salon_customer_app/screens/common_screens/splash_screen.dart';
import 'package:salon_customer_app/styles/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
