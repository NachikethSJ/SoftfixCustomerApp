import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/show_toast.dart';
import 'package:salon_customer_app/utils/validate_connectivity.dart';
import 'package:salon_customer_app/utils/validator.dart';

import '../view_models/cart_provider.dart';
import '../view_models/dashboard_provider.dart';
import 'app_text.dart';
import 'continue_to_payment.dart';
import 'fixed_gridview_height.dart';

class SlotBookingDialog extends StatefulWidget {
  final int? subServiceId;
  const SlotBookingDialog({
    super.key,
    this.subServiceId,
  });

  @override
  _SlotBookingDialogState createState() => _SlotBookingDialogState();
}

class _SlotBookingDialogState extends State<SlotBookingDialog> {
  List<List<bool>> _isChecked = [];
  late List<String> timeSlots;
  String subServiceId = '';

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
        _getSlot();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("Subservice Type id===${widget.subServiceId}");
    //Initialize time slots and checkbox states
    timeSlots = ['10:30-11 AM', '10:30-11 AM', '10:30-11 AM', '10:30-11 AM'];
    _getSlot();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? startDate =
        _selectedDate?.subtract(Duration(days: _selectedDate!.weekday - 1));
    DateTime? endDate =
        _selectedDate?.add(Duration(days: 7 - _selectedDate!.weekday));
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        if (provider.showLoader) {
          return Dialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Dialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Select Slot",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<DashboardProvider>(
                      builder: (context, provider, child) {
                        _isChecked = List.generate(
                          provider.slotList.length,
                          (index) => List.generate(
                            provider.slotList[index].slots?.length ?? 0,
                            (innerIndex) => false,
                          ),
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                appText(
                                    title: "Select Booking Date",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.7)),
                                GestureDetector(
                                  onTap: () {
                                    _showBookingDate(context);
                                    //API Calling for Future Dates Slots
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 126,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.yellow),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            _selectedDate != null
                                                ? DateFormat('MMM d, yyyy')
                                                    .format(_selectedDate!)
                                                : 'Select Date',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: appColors.appColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    provider.slotList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No slots available.',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(),
                              Wrap(
                                children: [
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: provider.slotList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/images/placeholder.png', // Path to placeholder image
                                                  image:
                                                      '${provider.slotList[index].image?.first}',
                                                  fit: BoxFit.cover,
                                                  width: 50,
                                                  height: 50,
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
                                                    // Custom image error builder
                                                    return Image.asset(
                                                      'assets/images/placeholder.png',
                                                      fit: BoxFit.cover,
                                                      width: 50,
                                                      height: 50,
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                "${provider.slotList[index].employName ?? ""} Available Slots",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(0.7)),
                                              ),
                                            ],
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: BorderSide(
                                                color: appColors.appColor,
                                              ),
                                            ),
                                            elevation: 3,
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const FixedGridViewHeight(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 1.0,
                                                      height: 30),
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: provider
                                                      .slotList[index]
                                                      .slots
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                return Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      width: 30,
                                                      child: FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Checkbox(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            side:
                                                                const BorderSide(
                                                              color: Colors
                                                                  .indigoAccent,
                                                            ),
                                                          ),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors
                                                                .indigoAccent,
                                                          ),
                                                          checkColor:
                                                              Colors.white,
                                                          activeColor: Colors
                                                              .indigoAccent,
                                                          value: provider
                                                              .slotList[index]
                                                              .slots?[i]
                                                              .isChecked,
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              provider
                                                                      .slotList[
                                                                          index]
                                                                      .slots?[i]
                                                                      .isChecked =
                                                                  !provider
                                                                      .slotList[
                                                                          index]
                                                                      .slots![i]
                                                                      .isChecked!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Card(
                                                      elevation: 2,
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 70,
                                                        child: Center(
                                                          child: appText(
                                                            title:
                                                                '${provider.slotList[index].slots?[i].start}-${provider.slotList[index].slots?[i].end}',
                                                            fontSize: 8,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: appColors.appColor),
                        child: InkWell(
                          onTap: () {
                            validateConnectivity(
                                context: context,
                                provider: () {
                                  if (provider.slotList.isNotEmpty) {
                                    createSlotOrder(
                                        provider.slotList[0].shopId.toString());
                                  } else {
                                    showToast('No slot available.');
                                  }
                                });
                          },
                          child: Center(
                              child: Text(
                            'Continue To Payment',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.green),
                        child: InkWell(
                          onTap: () {
                            validateConnectivity(
                                context: context,
                                provider: () {
                                  if (provider.slotList.isNotEmpty) {
                                    addCartService(
                                        provider.slotList[0].shopId.toString());
                                  } else {
                                    showToast('No Slots Available');
                                  }
                                });
                          },
                          child: Center(
                              child: Text(
                            'Book For More Services',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  _getSlot() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {
          "subServiceId": widget.subServiceId,
          "date": formatDateTime(_selectedDate.toString(), 'yyyy-MM-dd'),
          "currentTime": formatDateTime(_selectedDate.toString(), 'HH:mm'),
        };
        provider.getSlotList(
          context: context,
          body: body,
        );
      },
    );
  }

  createSlotOrder(String shopId) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        validateConnectivity(
            context: context,
            provider: () {
              var provider =
                  Provider.of<DashboardProvider>(context, listen: false);
              List<Map<String, dynamic>> bookingDetailsArray = [];
              int flag = 0;
              provider.slotList.forEach((element) {
                element.slots?.forEach((e) {
                  if (e.isChecked == true) {
                    flag = 1;
                    bookingDetailsArray.add({
                      "startTime": e.start,
                      "endTime": e.end,
                      "employeeId": element.employId,
                      "shopId": shopId
                    });
                  }
                });
              });
              if (flag == 1) {
                var body = {
                  "id": widget.subServiceId,
                  "date":
                      formatDateTime(_selectedDate.toString(), 'yyyy-MM-dd'),
                  "bookingDetailsArray": bookingDetailsArray
                };
                print("=====Request Body===$body");
                provider
                    .createOrder(
                  context: context,
                  body: body,
                )
                    .then((value) {
                  if (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentContinueScreen(
                                  date: formatDateTime(
                                      _selectedDate.toString(), 'yyyy-MM-dd'),
                                  ordrId: provider.createOrderSlot.orderId,
                                ))); // Close the dialog
                  }
                });
              } else {
                showToast('Please select slot.');
              }
            });
      },
    );
  }

  addCartService(String shopId) {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<CartProvider>(context, listen: false);
          var dashboardProvider =
              Provider.of<DashboardProvider>(context, listen: false);
          List<Map<String, dynamic>> bookingDetailsSlotsCart = [];
          int flag1 = 0;
          dashboardProvider.slotList.forEach((element) {
            element.slots?.forEach((e) {
              if (e.isChecked == true) {
                flag1 = 1;
                bookingDetailsSlotsCart.add({
                  "startTime": e.start,
                  "endTime": e.end,
                  "employeeId": element.employId,
                  "shopId": shopId,
                });
              }
            });
          });
          if (flag1 == 1) {
            var body = {
              "subServiceId": widget.subServiceId,
              "quantity": 1,
              "bookingDate":
                  formatDateTime(_selectedDate.toString(), 'yyyy-MM-dd'),
              "bookingDetailsSlotsCart": bookingDetailsSlotsCart
            };
            print("=====Request Body===$body");
            provider
                .addCart(
              context: context,
              body: body,
            )
                .then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          } else {
            showToast('Please select slot.');
          }
        });
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
}
