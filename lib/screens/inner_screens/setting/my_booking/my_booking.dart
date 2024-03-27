import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/texts.dart';
import '../../../../styles/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../view_models/dashboard_provider.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  int count = 1;
  double latitude = 28.7041;
  double longitude = 77.1025;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingDetails();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(
        context,
        bgColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        actions: [
          appText(
            title: "My Booking",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.account_circle_sharp,
            color: appColors.appColor,
            size: 50,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: appColors.appColor, width: 1),
                    borderRadius: BorderRadius.circular(15)),
              ),
              const SizedBox(
                height: 5,
              ),
              Consumer<DashboardProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                      itemCount: provider.getbookingDeatils.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 5),
                          child: SizedBox(
                            height: 270,
                            width: double.infinity,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: appColors.appColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, bottom: 30, top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  appText(
                                                    title: "Green Trends",
                                                    fontSize: 16,
                                                    color: Colors.teal.shade500,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  appText(
                                                    title:
                                                        " (Waiting for appoval)",
                                                    fontSize: 12,
                                                    color: Colors.orangeAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                              appText(
                                                  title: "Eye brow",
                                                  color: Colors.blueGrey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              appText(
                                                  title: "Eye brow shaping",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              appText(
                                                title:
                                                    '12:00:00-12:00:00(Sat,Apr,2024)',
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                              appText(
                                                title: '₹500',
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                              appText(
                                                title: 'Offer:10%',
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              appText(
                                                title: 'Stylish:Prabhat',
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              appText(
                                                title: '4 hrs.5 min.left',
                                                color: Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: appColors.appColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: const Center(
                                                      child: Text(
                                                    "Reshedule",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 70,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(12),
                                                            color: appColors
                                                                .appColor,
                                                            border: Border.all(
                                                              color: appColors
                                                                  .appBlue,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(10,
                                                                    14, 10, 14),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (count >
                                                                        1) {
                                                                      setState(
                                                                          () {
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
                                                                    title:
                                                                        '$count',
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
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
                                                )
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      openMap(latitude,longitude);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.teal.shade800,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                ),
                                                appText(
                                                  title: "Follow map to visit shop",
                                                  fontWeight: FontWeight.w900,
                                                  color: appColors.appWhite,
                                                  fontSize: 8,
                                                ),
                                                Icon(
                                                  Icons.directions,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  bookingDetails() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        provider.BookingDetails(
          context: context,
        );
      },
    );
  }
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
