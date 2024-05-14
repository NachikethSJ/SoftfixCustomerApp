import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/my_booking/my_booking.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/navigation.dart';

import '../../view_models/dashboard_provider.dart';
import '../common_screens/bottom_navigation.dart';

class SuccessScreen extends StatefulWidget {
  final String orderbookingId;
  const SuccessScreen({super.key, required this.orderbookingId});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  Future<bool> successOrder() async {
    var res = await Provider.of<DashboardProvider>(context, listen: false)
        .orderSuccess(
      context: context,
      orderId: widget.orderbookingId,
    );
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    successOrder().then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        navigateRemoveUntil(context: context, to: const MyBooking(isGoBackDashboard: true,));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/done.png',
                height: 40,
                width: 40,
              ),
            ),
            const Center(child: Text("Slot Book Successfully.")),
            GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                },
                child: Center(
                    child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                            color: appColors.appColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: Text(
                          "Go to Booking",
                          style: TextStyle(color: Colors.white),
                        )
                        )
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
