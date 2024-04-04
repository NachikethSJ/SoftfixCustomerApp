import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';

class CashFreepayment {
  // Cashfree Payment Instance
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();
// Cashfree Payment Instance
  bool? isSuccess;

  void verifyPayment(String orderId) {
    // Here we will only print the statement
    // to check payment is done or not
    isSuccess = true;
    print("Verify Payment $orderId");
  }

  // If some error occur during payment this will trigger
  void onError(CFErrorResponse errorResponse, String orderId) {
    // printing the error message so that we can show
    // it to user or check ourselves for testing
    isSuccess = false;
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  String orderId = "my_order_id1";

  Future<CFSession?> createSession() async {
    try {
      final mySessionIDData =
      await createSessionID(orderId); // This will create session id from flutter itself

      // Now we will set some parameters like orderID, environment, payment sessionID
      // after that we will create the checkout session
      // which will launch through which user can pay.
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

  Future<void> pay() async {
    try {
      var session = await createSession();
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
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      // Launching the payment page
      var result = await cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);

      // Verify payment based on result
      if (result.success) {
        verifyPayment(orderId);
      } else {
        onError(result.errorResponse!, orderId);
      }
    } on CFException catch (e) {
      print(e.message);
    }
  }

  Future<Map<String, dynamic>> createSessionID(String orderID) async {
    // Sample response data (replace with your desired test/demo data)
    Map<String, dynamic> sampleResponse = {
      "order_id": "2",
      "payment_session_id":
      "session_xAHlmElTPqji92xD3oXc5RuD2Nvsn2XnsCb_7CWK6DXB0ttuBhWvhmZA9MY-qe4TStYnxttn9w9k-iRlzB0ikvH7NYp6nCP6MfaRByM3LPkY",
      // Add any other fields you need to simulate
    };
    // Simulate an asynchronous delay to mimic API call
    await Future.delayed(Duration(seconds: 1));

    // Return the sample response
    return sampleResponse;
  }
}
