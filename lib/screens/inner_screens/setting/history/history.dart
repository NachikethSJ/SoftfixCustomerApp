import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/view_models/accounts_provider.dart';

import '../../../../styles/app_colors.dart';
import '../../../../utils/app_bar.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/validate_connectivity.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});


  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<TextEditingController> reviewControllers = [];
  List<double> ratings = [];
  List<bool> israteShowList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 2; i++) {
      reviewControllers.add(TextEditingController());
      ratings.add(0);
      israteShowList.add(true);
    }
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
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 3, right: 3, top: 5),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
        height: 360,
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
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 30, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                title: " (Completed)",
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
                            title: '12:00:00-12:00:00(Sat,Apr,2024)',
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
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: appColors.appColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text(
                                    "Book Again",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ],
              ),

              Visibility(
                visible: israteShowList[index],
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18,bottom: 2),
                        child: Row(
                          children: [
                            appText(
                                title: "Rating:",
                                fontWeight: FontWeight.bold),
                            RatingBar.builder(
                              wrapAlignment:
                              WrapAlignment.start,
                              itemSize: 25,
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemBuilder: (context, _) =>
                              const Icon(
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
                            padding: const EdgeInsets.only(left: 20,),
                            child: appText(title: "Review Vendor"),
                          )),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 190,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: appColors.appColor)),
                              child: TextField(
                                controller: reviewControllers[index],
                                decoration: const InputDecoration(
                                  border: InputBorder
                                      .none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                reviewUser(context, index);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: appColors.appColor,),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
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
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.teal.shade800,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
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
          ),
        ),
      ),
    );
  }

  reviewUser(BuildContext context, int index) {
    validateConnectivity(context: context, provider: () {
      var provider = Provider.of<AccountsProvider>(context, listen: false);

      var body = {
        "rate": ratings[index] ?? 0,
        "comment": reviewControllers[index].text,
        "serviceId": "3"
      };
      provider.review(
        context: context,
        body: body,
      ).then((value) {
        if (value) {
          setState(() {
            israteShowList[index] = false;
          });
          Navigator.pop(context);
        }
      });
    });
  }
}
