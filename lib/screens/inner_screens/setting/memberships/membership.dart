import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../../constants/texts.dart';
import '../../../../styles/app_colors.dart';
import '../../../../utils/app_text.dart';
import '../../../../utils/loading_shimmer.dart';
import '../../../../utils/navigation.dart';
import '../../../../view_models/dashboard_provider.dart';
import '../../membership_detail.dart';
class MemberShipspage extends StatefulWidget {
  const MemberShipspage({super.key});

  @override
  State<MemberShipspage> createState() => _MemberShipspageState();
}

class _MemberShipspageState extends State<MemberShipspage> {
  double latitude = 28.7041;
  double longitude = 77.1025;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Membership"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _nearByMembershipList(),
          ],
        ),
      ),
    );
  }
  _nearByMembershipList() {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      print("lenght===${provider.membershipList.length}");
      if (provider.showLoader) {
        return ListView.separated(
          itemCount: 4,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 12,
            );
          },
          itemBuilder: (context, index) {
            return SizedBox(
              height: 150,
              width: double.infinity,
              child: loadingShimmer(),
            );
          },
        );
      } else if (provider.membershipList.isEmpty) {
        return SizedBox(
          height: 200,
          child: Center(
            child: appText(title: texts.notFound),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
        shrinkWrap: true,
        itemCount: provider.membershipList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                context: context,
                to: MembershipDetail(
                  data: provider.membershipList[index],
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color:  Colors.yellowAccent.shade100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, bottom: 20, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appText(
                                title: provider
                                    .membershipList[index].membershipName ??
                                    '',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title: provider
                                    .membershipList[index].service?.name ??
                                    '',
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  appText(
                                    title: 'Just in ₹',
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  appText(
                                    title:
                                    '${calculatePrice(provider.membershipList[index].price, provider.membershipList[index].offer)}',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Container(
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                    color:
                                    const Color.fromARGB(255, 82, 102, 83),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Center(
                                  child: appText(
                                    title: texts.bookNow,
                                    fontWeight: FontWeight.w500,
                                    color: appColors.appWhite,
                                    fontSize: 8,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: CircleAvatar(
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/placeholder.png', // Path to placeholder image
                                  image: provider.membershipList[index].image?.first ?? '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.asset(
                                      'assets/images/placeholder.png', // Path to placeholder image
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 90,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  height: 20,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                      child: appText(
                        title: '${provider.membershipList[index].offer}% OFF',
                        color: appColors.appWhite,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Positioned(
                  bottom: 10,
                  left: 8,
                  child: Row(
                    children: [
                      RatingBar.builder(
                        wrapAlignment: WrapAlignment.start,
                        itemSize: 16,
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 4,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) {},
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Image.asset('assets/images/time_icon1.png',height: 20,width: 20,),
                          const SizedBox(
                            width: 6,
                          ),
                          appText(
                            title:
                            '20 Min • ${(Geolocator.distanceBetween(latitude, longitude, provider.membershipList[index].shop!.lat!, provider.membershipList[index].shop!.lng!) / 1000).toStringAsFixed(2)} KM',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }
  calculatePrice(dynamic price, dynamic discount) {
    double p = double.tryParse(price.toString()) ?? 0;
    double d = double.tryParse(discount.toString()) ?? 0;
    return (p * (100 - d) / 100).toStringAsFixed(0);
  }
}
