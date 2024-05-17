import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/view_models/accounts_provider.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:salon_customer_app/view_models/cart_provider.dart';
import 'package:salon_customer_app/view_models/connectivity_provider.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';

import '../../view_models/services_details_provider.dart';

class CustomProvider extends StatelessWidget {
  final Widget child;
  final AuthProvider state;
  const CustomProvider({super.key, required this.child, required this.state});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CheckInternet(),
        ),
        ChangeNotifierProvider(
          create: (context) => state,
        ),
        ChangeNotifierProvider(create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider(create: (context)=> AccountsProvider()),
        ChangeNotifierProvider(create: (context)=> CartProvider()),
        ChangeNotifierProvider(create: (context)=> ServicesDetailsProvider()),
      ],
      child: child,
    );
  }
}
