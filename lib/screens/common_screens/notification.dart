import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/styles/app_colors.dart';

import '../../utils/validate_connectivity.dart';
import '../../view_models/cart_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              ListView.builder(
                itemCount: provider.showNotificationDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: appColors.appColor
                      ),
                      child: Text("hi${provider.showNotificationDetails[index].title}"),
                    ),
                  );
                  })
            ],
          );
        },
      ),
    );
  }

  notificationList() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<CartProvider>(context, listen: false);
          provider.notificationDetails(
            context: context,
          );
        });
  }
}
