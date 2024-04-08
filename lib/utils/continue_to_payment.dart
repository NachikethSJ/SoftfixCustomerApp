import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/screens/inner_screens/dashboard.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/validator.dart';

import '../screens/common_screens/bottom_navigation.dart';
import '../screens/common_screens/cash_free_payment.dart';
import '../view_models/dashboard_provider.dart';

class PaymentContinueScreen extends StatefulWidget {
  final String? date;
  const PaymentContinueScreen({super.key, this.date});

  @override
  State<PaymentContinueScreen> createState() => _PaymentContinueScreenState();
}

class _PaymentContinueScreenState extends State<PaymentContinueScreen> {
  int count = 1;
  bool isSuccess = true;
  var orderbookingId;

  @override
  void initState() {
    super.initState();
    print("======Init State===");
    var data = Provider
        .of<DashboardProvider>(context, listen: false)
        .createOrderSlot;
    print("===Payment Session===${data.paymentSessionId}");
    CashFreepayment(paymentSessionId: data.paymentSessionId ?? '',
        orderId: data.orderId ?? '')
        .cfPaymentGatewayService
        .setCallback((p0) {}, (p0, p1) {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: const Text("Continue to payment"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 600,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: appColors.appColor)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      appText(
                          title: "Billing(gif or graphics)",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      Consumer<DashboardProvider>(
                        builder: (context, provider, child) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: Container(
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .personal_injury_sharp,
                                                      color: Colors.grey,
                                                    ),
                                                    appText(
                                                        title: "HairCut",
                                                        fontSize: 14)
                                                  ],
                                                ),
                                                appText(
                                                    title: "2500",
                                                    color: Colors.brown,
                                                    fontSize: 14),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                BottomNavigation()));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .video_library_outlined,
                                                        color: Colors.blueGrey,
                                                      ),
                                                      appText(
                                                          title: "Add more",
                                                          fontSize: 14)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              height: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                        color: appColors
                                                            .appColor,
                                                        border: Border.all(
                                                          color: appColors
                                                              .appBlue,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .fromLTRB(
                                                            10, 10, 10, 14),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (count > 1) {
                                                                  setState(() {
                                                                    count--;
                                                                  });
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: appColors
                                                                    .appBlack,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Center(
                                                              child: appText(
                                                                title: '$count',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: appColors
                                                                    .appBlack,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  count++;
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: appColors
                                                                    .appBlack,
                                                                size: 20,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              });
                        },
                      ),
                      Card(
                        elevation: 2,
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      appText(
                                          title: "Bill Details",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.event_note_outlined),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            appText(title: "Services "),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Row(
                                          children: [
                                            Icon(Icons.shopping_bag_outlined),
                                            appText(title: "Grand Total"),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: appText(
                                            title: "Total",
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: appText(title: '$count'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: appText(
                                            title: provider.createOrderSlot
                                                .orderAmount.toString()),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: appColors.appColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                child:
                                Icon(Icons.currency_rupee, color: Colors.white),
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 45,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: appColors.appColor,
                                )),
                            child: Center(
                                child: appText(
                                    title: provider.createOrderSlot.orderAmount
                                        .toString(),
                                    color: Colors.grey,
                                    fontSize: 14)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Consumer<DashboardProvider>(
                            builder: (context, provider, child) {
                              return GestureDetector(
                                onTap: () async {
                                  // bookingSlot();
                                  orderbookingId =
                                      provider.createOrderSlot.orderId;
                                  await CashFreepayment(
                                      orderId:
                                      provider.createOrderSlot.orderId ??
                                          '',
                                      paymentSessionId: provider.createOrderSlot
                                          .paymentSessionId ??
                                          '')
                                      .pay();
                                },
                                child: Container(
                                  height: 45,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: appText(
                                          title: "Pay",
                                          color: Colors.white,
                                          fontSize: 16)),
                                ),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bookingSlot() {
    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);

        var body = {
          "employeeId": "12",
          "serviceTypeId": "1",
          "bookingDate": widget.date,
          "bookingStartTime": "09:00:00",
          "bookingEndTime": "10:00:00",
          "promocode": "121",
          "tax": 10.50,
          "latitude": 37.7749,
          "longitude": -122.4194,
          "bookingnumber": "BG456",
          "transactionID": "TS456789",
          "paymentStatus": "1",
          "bookingStatus": "1"
        };
        provider.SlotBooking(
          context: context,
          body: body,
        );
      },
    );
  }

  Future<bool> successOrder() async {
    var res = await Provider.of<DashboardProvider>(context, listen: false)
        .orderSuccess(
      context: context,
      orderId: orderbookingId,
    );
    return res;
  }
}
