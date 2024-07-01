import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/view_models/accounts_provider.dart';
import '../../../../styles/app_colors.dart';
import '../../../../utils/app_bar.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/slot.dart';
import '../../../../utils/validate_connectivity.dart';
import '../help/help.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<TextEditingController> reviewControllers = [];
  List<double> ratings = [];
  List<bool> isRateShowList = [];

  @override
  void initState() {
    super.initState();
    bookingDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: appBar(
            context,
            bgColor: Colors.white,
            actions: [
              appText(
                title: "My History",
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
          body: provider.showLoader
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: provider.bookingDetailHistory.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return buildListItem(context, index);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget buildListItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: appColors.appColor,
            ),
          ),
          child: Consumer<AccountsProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, bottom: 30, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  appText(
                                    title: provider
                                            .bookingDetailHistory[index].shop ??
                                        '',
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(width: 2),
                                  appText(
                                    title:
                                        "(${provider.bookingDetailHistory[index].bookingStatus})",
                                    fontSize: 12,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              appText(
                                  title: provider.bookingDetailHistory[index]
                                          .service ??
                                      '',
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              appText(
                                  title: provider.bookingDetailHistory[index]
                                          .subServiceType ??
                                      '',
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
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
                                        '(${provider.bookingDetailHistory[index].bookingDate}) ${provider.bookingDetailHistory[index].startTime ?? ''}-${provider.bookingDetailHistory[index].endTime ?? ''}',
                                    color: appColors.appGray,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              appText(
                                title:
                                    '₹${provider.bookingDetailHistory[index].price ?? ''}',
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
                                        'Offer:${provider.bookingDetailHistory[index].offer ?? ''}%',
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              appText(
                                title:
                                    'Stylish:${provider.bookingDetailHistory[index].employName ?? ''}',
                                color: Colors.black.withOpacity(0.7),
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
                            padding: const EdgeInsets.only(top: 10, right: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/placeholder.png', // Path to placeholder image
                                    image: 'assets/images/salonimg.png',
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      // Custom image error builder
                                      return Image.asset(
                                        'assets/images/salonimg.png',
                                        fit: BoxFit.cover,
                                        width: 70,
                                        height: 70,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    showSlotBookingDialog(context,
                                        '${provider.bookingDetailHistory[index].subServiceId}');
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: appColors.appColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Center(
                                        child: Text(
                                      "Book Again",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.7)),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HelpPage(
                                                vendorId: provider
                                                        .bookingDetailHistory[
                                                            index]
                                                        .vendorId ??
                                                    "")));
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: appColors.appColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                            )),
                      ),
                    ],
                  ),
                  provider.bookingDetailHistory[index].isReviewed == false
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, bottom: 2),
                              child: Row(
                                children: [
                                  appText(
                                      title: "Rating:",
                                      fontWeight: FontWeight.bold),
                                  RatingBar.builder(
                                    wrapAlignment: WrapAlignment.start,
                                    itemSize: 25,
                                    initialRating: 0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (value) {
                                      setState(() {
                                        ratings[index] = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: appText(title: "Review Vendor"),
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 190,
                                    child: TextField(
                                      controller: reviewControllers[index],
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: 10, left: 8),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      reviewUser(
                                        context,
                                        index,
                                        provider.bookingDetailHistory[index]
                                            .vendorId
                                            .toString(),
                                        provider
                                            .bookingDetailHistory[index].shopId
                                            .toString(),
                                        provider.bookingDetailHistory[index]
                                            .serviceId
                                            .toString(),
                                      );
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: appColors.appColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              appText(title: "Submit Review"),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.teal.shade800,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              appText(
                                title: "Follow map to visit shop",
                                fontWeight: FontWeight.w900,
                                color: appColors.appWhite,
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  reviewUser(BuildContext context, int index, String vendorId, String shopId,
      String serviceId) {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<AccountsProvider>(context, listen: false);

          var body = {
            "rate": ratings[index] ?? 0,
            "comment": reviewControllers[index].text,
            "serviceId": serviceId,
            "vendorId": vendorId,
            "shopId": shopId,
          };
          provider
              .review(
            context: context,
            body: body,
          )
              .then((value) {
            if (value) {
              bookingDetails();
              /*setState(() {
                //isRateShowList[index] = false;
              });*/
            }
          });
        });
  }

  bookingDetails() {
    /*setState(() {
      isRateShowList = [];
    });*/
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<AccountsProvider>(context, listen: false);
        provider
            .bookingHistoryDetails(
          context: context,
        )
            .then((value) {
          if (value) {
            for (int i = 0; i < provider.bookingDetailHistory.length; i++) {
              reviewControllers.add(TextEditingController());
              ratings.add(0);
              //isRateShowList.add(true);
            }
          }
        });
      },
    );
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
}
