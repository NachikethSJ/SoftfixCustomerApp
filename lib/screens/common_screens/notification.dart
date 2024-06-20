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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListView.builder(
                  // itemCount: provider.showNotificationDetails.length,
                  itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                    return Card(
                      elevation: 1,
                      shadowColor: appColors.appGray,
                      child: Container(
                        decoration: BoxDecoration(
                          color: appColors.appColor.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text("hi${provider.showNotificationDetails[index].title}"),
                                  Text("Hey user! Your slot booked successfully")
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                    })
              ],
            ),
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
