import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/cart_provider.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';

import '../../../utils/continue_to_payment.dart';
import '../../../utils/slot.dart';
import '../../../utils/validate_connectivity.dart';
import '../../../utils/validator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DateTime? _selectedDate = DateTime.now();

  Future<void> _showBookingDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime oneWeekLater = currentDate.add(Duration(days: 7));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? currentDate,
      firstDate: currentDate,
      lastDate: oneWeekLater,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartDeatils();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, provider, child) {
        print('Cart item${provider.showCartDetails.length}');
        if (provider.showLoader) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (provider.showCartDetails.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: appText(title: "My Cart", fontSize: 18),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: Center(child: Text("Cart is Empty")),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: appText(title: "My Cart", fontSize: 18),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      appText(
                          title: "Services added in Cart here!",
                          fontSize: 16,
                          color: Colors.grey),
                      const SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: appColors.appColor,
                      )
                    ],
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.showCartDetails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // slideTransition(
                          //   context: context,
                          //   to: ShopDetail(
                          //     lat: latitude,
                          //     lng: longitude,
                          //     shopData: provider.nearShopList[index],
                          //   ),
                          // );
                        },
                        child: Card(
                          elevation: 4,
                          // shadowColor: appColors.appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side:
                                BorderSide(color: appColors.appColor, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                                height: 120,
                                                width: 130,
                                                child: Image.network(
                                                  provider
                                                          .showCartDetails[
                                                              index]
                                                          .image
                                                          ?.first ??
                                                      '',
                                                  fit: BoxFit.fill,
                                                )),
                                            Positioned(
                                              left: 0,
                                              bottom: 0,
                                              child: Container(
                                                height: 25,
                                                width: 70,
                                                decoration: const BoxDecoration(
                                                    color: Colors.blue),
                                                child: Center(
                                                    child: Text(
                                                  "${provider.showCartDetails[index].offer}%Off",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              appText(
                                                title:
                                                    "${provider.showCartDetails[index].name}",
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    deleteCartItem(index);

                                                    //     .then((value){
                                                    //   cartDeatils();
                                                    // });
                                                  },
                                                  child: Icon(Icons.delete))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          appText(
                                            title:
                                                '${provider.showCartDetails[index].type}',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.lightbulb,
                                                color: appColors.appBlue,
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              appText(
                                                title:
                                                    '${provider.showCartDetails[index].time} Min Services',
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              appText(
                                                title:
                                                    '₹${calculatePrice(double.parse(provider.showCartDetails[index].price?.toString() ?? '0'), double.parse(provider.showCartDetails[index].offer?.toString() ?? '0'))}',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              appText(
                                                  title:
                                                      '₹${provider.showCartDetails[index].price}',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  textDecoration: TextDecoration
                                                      .lineThrough),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              List<Map<String, dynamic>>
                                                  bookingDetailsSlotsCarts = [];
                                              bookingDetailsSlotsCarts.add({
                                                "startTime": provider
                                                    .showCartDetails[index]
                                                    .bookingDetailsSlotsCart?[0]
                                                    .startTime,
                                                "endTime": provider
                                                    .showCartDetails[index]
                                                    .bookingDetailsSlotsCart?[0]
                                                    .endTime,
                                                "employeeId": provider
                                                    .showCartDetails[index]
                                                    .bookingDetailsSlotsCart?[0]
                                                    .employeeId,
                                                "shopId": provider
                                                    .showCartDetails[index]
                                                    .bookingDetailsSlotsCart?[0]
                                                    .shopId,
                                              });
                                              //showSlotBookingDialog(context,'${provider.showCartDetails[index].subServiceId}');
                                              ///directPaymentScreenOpen
                                              var body = {
                                                "id": provider
                                                    .showCartDetails[index]
                                                    .subServiceId,
                                                "date": formatDateTime(
                                                    _selectedDate.toString(),
                                                    'yyyy-MM-dd'),
                                                "bookingDetailsArray":
                                                    bookingDetailsSlotsCarts
                                              };
                                              print(
                                                  "=====RequestCreateOrderBody===$body");
                                              setState(() {
                                                provider.showCartDetails[index]
                                                    .isLoading = true;
                                              });
                                              var dashboardProvider = Provider
                                                  .of<DashboardProvider>(
                                                      context,
                                                      listen: false);
                                              dashboardProvider
                                                  .createOrder(
                                                context: context,
                                                body: body,
                                              )
                                                  .then((value) {
                                                setState(() {
                                                  provider
                                                      .showCartDetails[index]
                                                      .isLoading = false;
                                                });
                                                if (value) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentContinueScreen(
                                                                date: formatDateTime(
                                                                    _selectedDate
                                                                        .toString(),
                                                                    'yyyy-MM-dd'),
                                                                ordrId: dashboardProvider
                                                                    .createOrderSlot
                                                                    .orderId,
                                                              )));// Close the dialog
                                                }
                                              });
                                              // Close the dialog
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              //width: 100,
                                              //height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: appColors.appColor),
                                              child: provider
                                                          .showCartDetails[
                                                              index]
                                                          .isLoading ==
                                                      true
                                                  ? Center(
                                                      child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              const CircularProgressIndicator()))
                                                  : const Text(
                                                      "Continue To Pay"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  cartDeatils() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<CartProvider>(context, listen: false);
          provider.cartDetails(
            context: context,
          );
          //     .then((value) {
          //   if (value) {
          //     Navigator.pop(context);
          //   }
          // });
        });
  }

  deleteCartItem(int index) {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<CartProvider>(context, listen: false);
          provider.deleteToCart(
            context: context,
            body: {"cartId": provider.showCartDetails[index].cartId},
          ).then((value) {
            if (value) {
              cartDeatils();
            }
          });
        });
  }

  void showSlotBookingDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlotBookingDialog(
          subServiceId: int.tryParse(id),
        );
      },
    );
  }

  calculatePrice(dynamic price, dynamic discount) {
    double p = double.tryParse(price.toString()) ?? 0;
    double d = double.tryParse(discount.toString()) ?? 0;
    return (p * (100 - d) / 100).toStringAsFixed(0);
  }

  // createSlotOrder(String shopName){
  //   WidgetsBinding.instance.addPostFrameCallback(
  //         (timeStamp) {
  //       validateConnectivity(context: context, provider: (){
  //         var provider = Provider.of<DashboardProvider>(context, listen: false);
  //         List<Map<String,dynamic>> bookingDetailsArray=[];
  //         int flag=0;
  //         provider.slotList.forEach((element) {
  //           element.slots?.forEach((e) {
  //             if(e.isChecked==true){
  //               flag=1;
  //               bookingDetailsArray.add({
  //                 "startTime":e.start,
  //                 "endTime":e.end,
  //                 "employeeId":element.employId,
  //                 "shopId":shopName
  //               });
  //             }
  //           });
  //         });
  //         if(flag==1){
  //           var body = {
  //             "id": widget.subServiceId,
  //             "date":formatDateTime(_selectedDate.toString(),'yyyy-MM-dd'),
  //             "bookingDetailsArray":bookingDetailsArray
  //           };
  //           print("=====Request Body===$body");
  //           provider.createOrder(
  //             context: context,
  //             body: body,
  //           ).then((value) {
  //             if(value){
  //               Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentContinueScreen(date: formatDateTime(_selectedDate.toString(),'yyyy-MM-dd'),ordrId: provider.createOrderSlot.orderId,)));// Close the dialog
  //             }
  //           });
  //         }else{
  //           showToast('Please select slot.');
  //         }
  //       });
  //     },
  //   );
  // }
}
