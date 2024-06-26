import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

import '../../utils/continue_to_payment.dart';
import '../../view_models/dashboard_provider.dart';

class CashFreepayment {
  final String orderId;
  final String paymentSessionId;
  final String orderStatus;

  CashFreepayment({required this.orderId, required this.paymentSessionId,required this.orderStatus});

  // Cashfree Payment Instance
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();

  bool? isSuccess;

  void verifyPayment(String orderId) {

    // Here we will only print the statement
    // to check payment is done or not
    isSuccess = true;
    print("Verify Payment $orderId");

    // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    // PaymentContinueScreen().
  }

  // If some error occur during payment this will trigger
  void onError(CFErrorResponse errorResponse, String orderId) {
    // printing the error message so that we can show
    // it to user or check ourselves for testing
    isSuccess = false;
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  Future<CFSession?> createSession() async {
    try {

      var session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.SANDBOX)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      print("EXCEPTION====${e.message}");
    }
    return null;
  }

  Future<void> pay() async {
    try {
      var session = await createSession();
      if (session == null) {
        print("==========Null Session===============");
        return;
      }

      List<CFPaymentModes> components = <CFPaymentModes>[];

      // If you want to set payment mode to be shown to the customer
      var paymentComponent =
      CFPaymentComponentBuilder().setComponents(components).build();

      // We will set the theme of the checkout session page like fonts, color
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF0000")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();

      // Create checkout with all the settings we have set earlier
      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      // Launching the payment page
      var result =
      await cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);

      // Verify payment based on result
      print("Callback Response===$result=====");
      // if (result.success == true) {
      //   print("Payment successful");
      //   verifyPayment(orderId);
      // } else {
      //   print("Payment failed");
      //   onError(result.errorResponse, orderId);
      // }
    } on CFException catch (e) {
      print("===============Payment Exception=============${e.message}");
    }
  }

  Future<Map<String, dynamic>> createSessionID(String orderID) async {
    // Sample response data (replace with your desired test/demo data)
    Map<String, dynamic> sampleResponse = {
      "order_id": orderId,
      "payment_session_id": paymentSessionId,
      // Add any other fields you need to simulate
    };
    // Simulate an asynchronous delay to mimic API call
    await Future.delayed(const Duration(seconds: 1));

    // Return the sample response
    return sampleResponse;
  }

}
