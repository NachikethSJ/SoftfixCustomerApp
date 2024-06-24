import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/cart_provider.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';
import '../../../cache_manager/cache_manager.dart';
import '../../../utils/continue_to_payment.dart';
import '../../../utils/slot.dart';
import '../../../utils/validate_connectivity.dart';
import '../../../utils/validator.dart';
import '../sub_service_detail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with CacheManager {
  DateTime? _selectedDate = DateTime.now();

  double latitude = 28.7041;
  double longitude = 77.1025;
  Future getLatLongitude() async {
    var data = await getLatLng();
    setState(() {
      latitude = double.tryParse(data.first) ?? 0;
      longitude = double.tryParse(data.last) ?? 0;
    });
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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (provider.showCartDetails.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: appText(title: "My Cart", fontSize: 18,fontWeight: FontWeight.w600),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: const Center(child: Text("Cart is Empty")),
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
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.showCartDetails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          slideTransition(
                              context: context,
                              to: SubServiceDetail(
                                lat: latitude,
                                lng: longitude,
                                subServiceid: provider
                                    .showCartDetails[index].subServiceId
                                    .toString(),
                              ));
                        },
                        child: Card(
                          elevation: 4,
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
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                                height: 160,
                                                width: 130,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    provider
                                                            .showCartDetails[
                                                                index]
                                                            .image
                                                            ?.first ??
                                                        '',
                                                    fit: BoxFit.fill,
                                                  ),
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
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              SizedBox(
                                                width:120,
                                                child: appText(
                                                    title:
                                                        "${provider.showCartDetails[index].name}",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    textOverflow: TextOverflow.ellipsis,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    //textOverflow: TextOverflow.ellipsis
                                                ),
                                              ),
                                              const SizedBox(width: 10,),
                                              GestureDetector(
                                                  onTap: () {
                                                    deleteCartItem(index);
                                                  },
                                                  child: Icon(Icons.delete,
                                                      color:
                                                          appColors.appRed))
                                            ],
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: appText(
                                              title:
                                                  '${provider.showCartDetails[index].type}',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              textOverflow: TextOverflow.ellipsis,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/time_icon1.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              appText(
                                                title:
                                                    '${provider.showCartDetails[index].time} Min Service',
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
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                                      .withOpacity(0.7)
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              appText(
                                                  title:
                                                      '₹${provider.showCartDetails[index].price}',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  textDecoration: TextDecoration
                                                      .lineThrough),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              appText(
                                                  title: 'Time- ',
                                                  fontSize: 11),
                                              appText(
                                                title:
                                                    '${provider.showCartDetails[index].bookingDetailsSlotsCart?[0].startTime} - ${provider.showCartDetails[index].bookingDetailsSlotsCart?[0].endTime}',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              appText(
                                                  title: 'Date- ',
                                                  fontSize: 11),
                                              appText(
                                                title: provider
                                                        .showCartDetails[index]
                                                        .bookingDate
                                                        .toString() ??
                                                    "",
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
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
                                                  provider
                                                              .showCartDetails[
                                                                  index]
                                                              .bookingDetailsSlotsCart?[
                                                                  0]
                                                              .isExpired ==
                                                          true
                                                      ? showSlotBookingDialog(context,
                                                      '${provider.showCartDetails[
                                                      index].subServiceId}')
                                                      : Navigator.push(
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
                                                                  ))); // Close the dialog
                                                }
                                              });

                                              // Close the dialog
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: provider
                                                              .showCartDetails[
                                                                  index]
                                                              .bookingDetailsSlotsCart?[
                                                                  0]
                                                              .isExpired ==
                                                          true
                                                      ? Colors.green
                                                      : appColors.appColor),
                                              child: provider
                                                          .showCartDetails[
                                                              index]
                                                          .isLoading ==
                                                      true
                                                  ? const Center(
                                                      child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator()))
                                                  : provider
                                                              .showCartDetails[
                                                                  index]
                                                              .bookingDetailsSlotsCart?[
                                                                  0]
                                                              .isExpired ==
                                                          true
                                                      ? const Text(
                                                          "Book  Again",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white
                                                          ),
                                              )
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
}
