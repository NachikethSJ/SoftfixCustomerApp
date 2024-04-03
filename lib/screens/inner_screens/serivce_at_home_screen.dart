import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/screens/inner_screens/sub_service_detail.dart';

import '../../constants/texts.dart';
import '../../models/dashboard_models/near_by_service_model.dart';
import '../../styles/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/loading_shimmer.dart';
import '../../utils/navigation.dart';
import '../../utils/validator.dart';
import '../../view_models/dashboard_provider.dart';
class ServiceHome extends StatefulWidget {
  const ServiceHome({super.key});

  @override
  State<ServiceHome> createState() => _ServiceHomeState();
}

class _ServiceHomeState extends State<ServiceHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<DashboardProvider>(
                builder: (context, provider, child) {
                  // List<SubService> subService =
                  // provider.subServiceList.where((element) {
                  //   if (searchController.text.isNotEmpty) {
                  //     return element.type?.toLowerCase().contains(
                  //         searchController.text.toLowerCase()) ??
                  //         false;
                  //   }
                  //   return true;
                  // }).toList();
                  if (provider.showLoader) {
                    return ListView.separated(
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 14,
                        );
                      },
                      itemBuilder: (context, index) {
                        return loadingShimmer();
                      },
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 14,
                      );
                    },
                    itemCount:6,
                    shrinkWrap: true,

                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // slideTransition(
                          //     context: context,
                          //     to: SubServiceDetail(
                          //       data: provider.subServiceList[index],
                          //       shopData:
                          //       provider.subServiceList[index].shop!,
                          //       lat: latitude,
                          //       lng: longitude,
                          //     ));
                        },
                        child: Container(
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(16),
                                        child:
                                          Image.asset("assets/images/placeholder.png")
                                        // Image.network(
                                        //   subService[index]
                                        //       .image
                                        //       ?.first ??
                                        //       '',
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                                      ),
                                      child: Center(
                                          child: appText(
                                            title:
                                            '10% OFF',
                                            color: appColors.appWhite,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                appText(
                                  title: truncateWithEllipsis(
                                      14, "HAIR CUT"),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          appText(
                                              title:
                                              '₹200',
                                              color: appColors.appGray,
                                              textDecoration:
                                              TextDecoration
                                                  .lineThrough,
                                              fontSize: 10,fontWeight: FontWeight.bold),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          appText(
                                            title:
                                            '₹500',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        //Select Slot Dialog
                                        // showSlotBookingDialog(context,'${subService[index].id}');
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: appColors.appColor, // Specify the desired border color here
                                            width: 1, // Specify the desired border width
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                14, 6, 14, 6),
                                            child: appText(
                                              title: texts.book,
                                              fontSize: 10,
                                              color: appColors.appColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
