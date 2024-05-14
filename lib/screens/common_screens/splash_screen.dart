import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salon_customer_app/cache_manager/cache_manager.dart';
import 'package:salon_customer_app/screens/auth_screens/login.dart';
import 'package:salon_customer_app/screens/common_screens/bottom_navigation.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with CacheManager {
  late Timer timer;
  int i = 0;
  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.reduced,
      forceAndroidLocationManager: true,
      timeLimit: const Duration(seconds: 5),
    ).then((Position position) async {
      await setLatLng(position.latitude, position.longitude);
      _navigation();
    }).catchError((e) {
      if (i <= 2) {
        _getCurrentPosition();
        setState(() {
          i++;
        });
      }
      if (i > 2) {
        _navigation();
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text(
        //         'Location permissions are permanently denied, we cannot request permissions.')));
      }
      // debugPrint(e.toString());
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _navigation() async {
    var state = AuthProvider(await SharedPreferences.getInstance());

    timer = Timer(const Duration(seconds: 1), () {
      navigateRemoveUntil(
        context: context,
        to: state.isUserLoggedIn ? const BottomNavigation() : const Login(),
      );
    });
  }

  @override
  void dispose() {

    super.dispose();
    if(mounted)
      {
        timer.cancel();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: appColors.appColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.jpeg',height: 100,width: 180,),
        ),
        // appText(
        //   title: 'Salon Customer App',
        //   fontSize: 16,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    );
  }
}
