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
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/validator.dart';

import '../screens/common_screens/cash_free_payment.dart';
import '../view_models/dashboard_provider.dart';

class PaymentContinueScreen extends StatefulWidget {
  final String? date;
  const PaymentContinueScreen({super.key, this.date});

  @override
  State<PaymentContinueScreen> createState() => _PaymentContinueScreenState();
}

class _PaymentContinueScreenState extends State<PaymentContinueScreen> {
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();
  int count = 1;
bool isSuccess = true;
  @override
  void initState() {
    super.initState();
    CashFreePayment();
// Attach events when payment is success and when error occured
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
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
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Container(
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.personal_injury_sharp,
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
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.video_library_outlined,
                                                  color: Colors.blueGrey,
                                                ),
                                                appText(
                                                    title: "Reshedule",
                                                    fontSize: 14)
                                              ],
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
                                                    color: appColors.appColor,
                                                    border: Border.all(
                                                      color: appColors.appBlue,
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
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: appColors.appColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            child: Icon(Icons.monetization_on_outlined,
                                color: Colors.white),
                          )),
                      SizedBox(
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
                                title: "Pay using", color: Colors.grey,fontSize: 14)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // bookingSlot();
                          CashFreePayment();
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
  }
  void verifyPayment(String orderId) {
    // Here we will only print the statement
    // to check payment is done or not
    isSuccess = true;
    setState(() {

    });
    print("Verify Payment $orderId");
  }
  void onError(CFErrorResponse errorResponse, String orderId) {
// printing the error message so that we can
    // show it to user or checkourselves for testing
    isSuccess = false;
    setState(() {});
    print(errorResponse.getMessage());
    print("Error while making payment");
  }
  pay() async {
    try {
      var session = await createSession();
      List<CFPaymentModes> components = <CFPaymentModes>[];
      // If you want to set paument mode to be shown to customer
      var paymentComponent =
      CFPaymentComponentBuilder().setComponents(components).build();
      // We will set theme of checkout session page like fonts, color
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF0000")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();
      // Create checkout with all the settings we have set earlier
      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();
      // Launching the payment page

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }

  Future<CFSession?> createSession() async {
    try {
      final mySessionIDData = await bookingSlot(); //This will create session id from flutter itself

      // Now we will se some parameter like orderID ,environment,payment sessionID
      // after that we wil create the checkout session which
      // will launch through which user can pay.
      var session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.SANDBOX)
          .setOrderId(mySessionIDData["order_id"])
          .setPaymentSessionId(mySessionIDData["payment_session_id"])
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
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
}
