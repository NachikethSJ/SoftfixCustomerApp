import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../view_models/dashboard_provider.dart';

class CashFreePayment extends StatefulWidget {
  const CashFreePayment({super.key});

  @override
  State<CashFreePayment> createState() => _CashFreePaymentState();
}

class _CashFreePaymentState extends State<CashFreePayment> {
  CFPaymentGatewayService cfPaymentGatewayService =
      CFPaymentGatewayService(); // Cashfree Payment Instance
  bool? isSuccess;

  @override
  void initState() {
    super.initState();
    // Attach events when payment is success and when error occured
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue to pay'),
      ),
      body: Center(
        child: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: pay, child: const Text("Pay")),
                Text(
                  "Payment Status $isSuccess",
                  style: const TextStyle(fontSize: 20),
                )
              ],
            );
          },
        ),
      ),
    );
  } // When payment is done successfully

  void verifyPayment(String orderId) {
    // Here we will only print the statement
    // to check payment is done or not
    isSuccess = true;
    setState(() {});
    print("Verify Payment $orderId");
  }

// If some error occur during payment this will trigger
  void onError(CFErrorResponse errorResponse, String orderId) {
    // printing the error message so that we can show
    // it to user or checkourselves for testing
    isSuccess = false;
    setState(() {});
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  String orderId = "my_order_id1";

  Future<CFSession?> createSession() async {
    try {
      final mySessionIDData = await createSessionID(
          orderId); // This will create session id from flutter itself

      // Now we will se some parameter like orderID ,environment,payment sessionID
      // after that we wil create the checkout session
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

}
Future<Map<String, dynamic>> createSessionID(String orderID) async {
  // Sample response data (replace with your desired test/demo data)
  Map<String, dynamic> sampleResponse = {
    "order_id": "sample_order_id",
    "payment_session_id": "sample_payment_session_id"
    // Add any other fields you need to simulate
  };

  // Simulate an asynchronous delay to mimic API call
  await Future.delayed(Duration(seconds: 1));

  // Return the sample response
  return sampleResponse;
}

// createSessionID(String orderID) async {
//   var headers = {
//     'Content-Type': 'application/json',
//     'x-client-id': "TEST10161308ce7a3c7517ae3003742a80316101", // Replace with your actual client ID
//     'x-client-secret': "cfsk_ma_test_dc9401919add89aa1c5174078ece3f14_be999582", // Replace with your actual client secret
//     'x-api-version': '2024-04-01',
//     'x-request-id': 'fluterwings'
//   };
//
//   var request = http.Request(
//       'POST', Uri.parse('https://sandbox.cashfree.com/pg/orders'));
//   request.body = json.encode({
//     "order_amount": 1,
//     "order_id": orderID,
//     "order_currency": "INR",
//     "customer_details": {
//       "customer_id": "customer_id",
//       "customer_name": "customer_name",
//       "customer_email": "flutterwings304@gmail.com",
//       "customer_phone": "+917737366393"
//     },
//     "order_meta": {"notify_url": "https://test.cashfree.com"},
//     "order_note": "some order note here"
//   });
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     // Decode the response body
//     var responseBody = await response.stream.bytesToString();
//     print('Response body: $responseBody');
//
//     // Parse the JSON response
//     var jsonResponse = jsonDecode(responseBody);
//
//     // Check if the response contains the expected data
//     if (jsonResponse.containsKey('order_id') && jsonResponse.containsKey('payment_session_id')) {
//       return jsonResponse;
//     } else {
//       throw Exception('Unexpected response format');
//     }
//   } else {
//     print(await response.stream.bytesToString());
//     print(response.reasonPhrase);
//     throw Exception('Failed to create session ID: ${response.reasonPhrase}');
//   }
// }

