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
  const SlotBookingDialog({super.key, this.subServiceId});

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
      });
    }
  }


  @override
  void initState() {
    super.initState();
    print("Subservice Type id===${widget.subServiceId}");
    // Initialize time slots and checkbox states
    timeSlots = ['10:30-11 AM', '10:30-11 AM', '10:30-11 AM', '10:30-11 AM'];
    _getNearByData();
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
          return const Dialog(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Center(
                      child: Text(
                        "Select Slot",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
                            const Text("Please Select Date"),
                            Row(
                              children: [
                                appText(title: "Booking Date"),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    _showBookingDate(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Colors.yellow),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            _selectedDate != null
                                                ? DateFormat('MMM d, yyyy').format(_selectedDate!)
                                                : 'Select Date',
                                            style: const TextStyle(fontSize: 14),
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
                        const Text("Please Select Time"),
                        Wrap(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: provider.slotList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${provider.slotList[index].employName ?? ""} Slot",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 10),
                                        CircleAvatar(
                                          radius: 20,
                                          child: Image.network(
                                            '${provider.slotList[index].image}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color: appColors.appColor,
                                        ),
                                      ),
                                      elevation: 3,
                                      child: GridView.builder(
                                        gridDelegate: const FixedGridViewHeight(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 1.0,
                                            height: 30
                                        ),
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: provider.slotList[index].slots?.length ?? 0,
                                        itemBuilder: (BuildContext context, int i) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Checkbox(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(4),
                                                      side: const BorderSide(
                                                        color: Colors.indigoAccent,
                                                      ),
                                                    ),
                                                    side: const BorderSide(
                                                      color: Colors.indigoAccent,
                                                    ),
                                                    checkColor: Colors.white,
                                                    activeColor: Colors.indigoAccent,
                                                    value: provider.slotList[index].slots?[i].isChecked,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        provider.slotList[index].slots?[i].isChecked=!provider.slotList[index].slots![i].isChecked!;
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
                                                      title: '${provider.slotList[index].slots?[i].start}-${provider.slotList[index].slots?[i].end} PM',
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
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            createSlotOrder();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow),
                          ),
                          child: const Text('Continue To Payment'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            addCartService();
                            //     .then((value) {
                            //   cartDeatils();
                            // });
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: Text('Book For More Services'),
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


  _getNearByData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {
          "subServiceId": widget.subServiceId,
          "date": formatDateTime(_selectedDate.toString(),'yyyy-MM-dd'),
          "currentTime": formatDateTime(_selectedDate.toString(),'hh:mm'),
        };
        provider.getSlotList(
          context: context,
          body: body,
        );
      },
    );
  }

createSlotOrder(){
  WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
      validateConnectivity(context: context, provider: (){
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        List<Map<String,dynamic>> bookingDetailsArray=[];
        int flag=0;
        provider.slotList.forEach((element) {
          element.slots?.forEach((e) {
            if(e.isChecked==true){
              flag=1;
              bookingDetailsArray.add({
                "startTime":e.start,
                "endTime":e.end,
                "employeeId":element.employId,
              });
            }
          });
        });

        if(flag==1){
          var body = {
            "id": widget.subServiceId,
            "date":formatDateTime(_selectedDate.toString(),'yyyy-MM-dd'),

            "bookingDetailsArray":bookingDetailsArray

          };

          print("=====Request Body===$body");
          provider.createOrder(
            context: context,
            body: body,
          ).then((value) {
            if(value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentContinueScreen(date: formatDateTime(_selectedDate.toString(),'yyyy-MM-dd'),ordrId: provider.createOrderSlot.orderId,)));// Close the dialog

            }
          });
        }else{
          showToast('Please select slot.');
        }
      });
    },
  );
}
  addCartService() {
    validateConnectivity(context: context, provider: () {
      var provider = Provider.of<CartProvider>(context, listen: false);

      var body =
      {
        "subServiceId":widget.subServiceId,
        "quantity":1,
      };
      provider.addCart(
        context: context,
        body: body,
      ).then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
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
