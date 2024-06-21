import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/screens/common_screens/bottom_navigation.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../styles/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../view_models/accounts_provider.dart';
import '../help/help.dart';

class MyBooking extends StatefulWidget {
  final bool? isGoBackDashboard;
  const MyBooking({super.key, this.isGoBackDashboard});

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
    getLatestOTPBooking();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.isGoBackDashboard == true ? false : true,
      onPopInvoked: (didPop) {
        if (widget.isGoBackDashboard == true) {
          navigateRemoveUntil(context: context, to: const BottomNavigation());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: appBar(
          context,
          bgColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                if (widget.isGoBackDashboard == true) {
                  navigateRemoveUntil(
                      context: context, to: const BottomNavigation());
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.arrow_back)),
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
            child: Consumer<AccountsProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: appColors.appColor, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    provider.getLatestOTP.otp != null &&
                            provider.getLatestOTP.otp!.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              appText(
                                title: 'OTP Verification:- ',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              appText(
                                title:
                                    '${provider.getLatestOTP.otp}', // Note the use of null check operator here because we've checked for null before
                                fontSize: 14,
                                color: Colors.teal.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Consumer<AccountsProvider>(
                      builder: (context, provider, child) {
                        return ListView.builder(
                            itemCount: provider.showbookingDetails.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                child: SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(
                                        color: appColors.appColor,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25,
                                                    bottom: 30,
                                                    top: 10),
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
                                                            title: provider
                                                                    .showbookingDetails[
                                                                        index]
                                                                    .shop ??
                                                                '',
                                                            fontSize: 16,
                                                            color: Colors.black.withOpacity(0.7),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            textOverflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        appText(
                                                          title:
                                                              "(${provider.showbookingDetails[index].bookingStatus})",
                                                          fontSize: 10,
                                                          color: Colors
                                                              .orangeAccent,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ],
                                                    ),
                                                    appText(
                                                        title: provider
                                                                .showbookingDetails[
                                                                    index]
                                                                .service ??
                                                            '',
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    appText(
                                                        title: provider
                                                                .showbookingDetails[
                                                                    index]
                                                                .subServiceType ??
                                                            '',
                                                        color: Colors.black.withOpacity(0.7),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/time_icon1.png',
                                                          height: 12,
                                                          width: 12,
                                                        ),
                                                        const SizedBox(
                                                          width: 2,
                                                        ),
                                                        appText(
                                                          title:
                                                              '(${provider.showbookingDetails[index].bookingDate}) ${provider.showbookingDetails[index].startTime ?? ''}-${provider.showbookingDetails[index].endTime ?? ''}',
                                                          color: appColors.appGray,
                                                          fontSize: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    appText(
                                                      title:
                                                          '₹${provider.showbookingDetails[index].price ?? ''}',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/offer_icon.png',
                                                          height: 15,
                                                          width: 15,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        appText(
                                                          title:
                                                              'Offer:${provider.showbookingDetails[index].offer ?? ''}%',
                                                          color: Colors.blue,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ],
                                                    ),
                                                    appText(
                                                      title:
                                                          'Stylish:${provider.showbookingDetails[index].employName ?? ''}',
                                                      color: Colors.black.withOpacity(0.7),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, right: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Consumer<
                                                          AccountsProvider>(
                                                        builder: (context,
                                                            provider, child) {
                                                          return Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              HelpPage(vendorId: provider.showbookingDetails[index].vendorId ?? "")));
                                                                },
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: appColors.appColor, width: 2),
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 20,
                                                                                right: 20,
                                                                                top: 8,
                                                                                bottom: 8),
                                                                            child: appText(
                                                                                title: "Help?",
                                                                                color: appColors.appGray,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold),
                                                                          )),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            openMap(latitude, longitude);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 1),
                                              decoration: BoxDecoration(
                                                  color: Colors.teal.shade800,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                      appText(
                                                        title:
                                                            "Follow map to visit shop",
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            appColors.appWhite,
                                                        fontSize: 8,
                                                      ),
                                                      const Icon(
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
                    const SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bookingDetails() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<AccountsProvider>(context, listen: false);
        provider.bookingHistoryDetails(
          context: context,
        );
      },
    );
  }

  ///GetLatestOTP
  getLatestOTPBooking() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<AccountsProvider>(context, listen: false);
      provider.getLatestOTPView(context: context, body: {});
    });
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
