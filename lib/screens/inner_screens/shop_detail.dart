import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/screens/inner_screens/package_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/sub_service_detail.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/dashboard_models/near_by_elements_model.dart';
import '../../models/dashboard_models/near_by_shop_model.dart';
import '../../utils/app_button.dart';
import '../../utils/loading_shimmer.dart';
import '../../utils/navigation.dart';
import '../../utils/slot.dart';
import '../../utils/validator.dart';
import '../../view_models/dashboard_provider.dart';
import 'map/map_screen.dart';
import 'membership_detail.dart';
import 'near_by_sub_services_detail.dart';

class ShopDetail extends StatefulWidget {
  final NearByShopModel shopData;
  final double lat;
  final double lng;
  const ShopDetail(
      {super.key,
      required this.shopData,
      required this.lat,
      required this.lng});

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  int selectedTabIndex = 0;
  double latitude = 28.7041;
  double longitude = 77.1025;
  TextEditingController addressController = TextEditingController(text: 'Select Location');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,)),
          title: Row(
            children: [
              Icon(Icons.location_on,color: appColors.appColor,),
              Text("${widget.shopData.name} (${(Geolocator.distanceBetween(widget.lat, widget.lng, widget.shopData.lat!, widget.shopData.lng!) / 1000).toStringAsFixed(2)} Km Away)",style: TextStyle(fontSize: 14),),
            ],
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.search,color: appColors.appColor,),
            )
          ]
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.shopData.imageUrl?.first ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: ()async {
                           // await _openMap();
                        },
                        child: Container(
                          height: 40,
                          width: 140,
                          decoration:  BoxDecoration(
                            color: Colors.teal.shade800,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.directions,color: appColors.appColor,),
                              InkWell(
                                onTap: (){
                                   openMap(latitude,longitude);
                                },
                                  child: Text("Get Direction",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TabBar(
                  onTap: (value) {
                    setState(() {
                      selectedTabIndex = value;
                    });
                  },
                  labelColor: appColors.appColor,
                  indicatorColor: appColors.appColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: texts.services,
                    ),
                    Tab(
                      text: texts.package,
                    ),
                    Tab(
                      text: texts.membership,
                    ),
                  ],
                ),
                selectedTabIndex == 0
                    ? _nearByShopList()
                    : selectedTabIndex == 1
                    ? _nearByPackagesList()
                    : _nearByMembershipList(),
            
              ],
            ),
          ),
        ),
      ),

    );

  }
  _nearByShopList() {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
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
      } else if (provider.serviceList.isEmpty) {
        return SizedBox(
          height: 200,
          child: Center(
            child: appText(title: texts.notFound),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: provider.serviceList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                context: context,
                to: ShopDetail(
                  lat: latitude,
                  lng: longitude,
                  shopData: provider.nearShopList[index],
                ),
              );
            },
            child: Card(
              elevation: 4,
              // shadowColor: appColors.appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: appColors.appColor, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            // slideTransition(
                            //   context: context,
                            //   to: NearSubServicesDetail(
                            //     data: provider.nearShopList[index],
                            //   ),
                            // );
                            slideTransition(
                                context: context,
                                to: SubServiceDetail(
                                  data: provider.subServiceList[index],
                                  shopData:
                                  provider.subServiceList[index].shop!,
                                  lat: latitude,
                                  lng: longitude,
                                ));
                            },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 130,
                                  child: Image.network(
                                    provider.serviceList[index].subService?[0].image?[0] ?? "",
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: appColors.appGray100,
                                        child: Center(
                                          child: Icon(
                                            Icons.photo,
                                            color: appColors.appGray,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 25,
                                    width: 70,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue
                                    ),
                                    child:  Center(child: Text("${provider.serviceList[index].subService?[0].offer}% Off",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
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
                                children: [
                                  appText(
                                    title: '${provider.serviceList[index].name ?? ""}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(width: 20,),
                                  Text("View Details",style: TextStyle(color: Colors.blueGrey,decoration: TextDecoration.underline,fontSize: 12),)
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              appText(
                                title: provider.serviceList[index].subService?[0].type ?? "",
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
                                    title: '${provider.serviceList[index].subService?[0].timeTaken ?? ""} Hour Service',
                                  )
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //   MainAxisAlignment.start,
                              //   children: [
                              //     Icon(
                              //       Icons.star,
                              //       color: appColors.appColor,
                              //     ),
                              //     const SizedBox(
                              //       width: 2,
                              //     ),
                              //     appText(
                              //       title: '${provider.serviceList[index].subService?[0].rating ?? "0"}',
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  appText(
                                    title: '₹${calculatePrice(double.parse(provider.serviceList[index].subService?[0].price?.toString() ?? '0'), double.parse(provider.serviceList[index].subService?[0].offer?.toString() ?? '0'))}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  appText(
                                    title: '₹${provider.serviceList[index].subService?[0].price ?? ""}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    textDecoration: TextDecoration.lineThrough
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 4,
                              ),
                                Row(
                                children: [
                                  const Icon(Icons.train,color: Colors.green,),
                                  const Text("5 min-5km",style: TextStyle(fontSize: 10),),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      showSlotBookingDialog(context);
                                    },
                                    child: SizedBox(
                                      width: 70,
                                      height: 34,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: appColors.appColor
                                        ),
                                        child: const Center(child: Text("+Book")),
                                      )

                                      // AppButton(
                                      //   radius: 8,
                                      //   onPressed: () {
                                      //     showSlotBookingDialog(context);
                                      //   },
                                      //   title: '+ Book',
                                      //   fontSize: 12,
                                      // ),
                                    ),
                                  )
                                ],
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
      );
    });
  }
  calculatePrice(dynamic price, dynamic discount) {
    double p = double.tryParse(price.toString()) ?? 0;
    double d = double.tryParse(discount.toString()) ?? 0;
    return (p * (100 - d) / 100).toStringAsFixed(0);
  }

   Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${widget.shopData.lat},${widget.shopData.lng}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
  _nearByMembershipList() {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
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
                      color:  Colors.yellow.shade400),
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
                                    '${provider.membershipList[index].price ?? ""}',
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
                          Icon(
                            Icons.location_on,
                            color: appColors.appGreen,
                          ),
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

  _nearByPackagesList() {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
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
      } else if (provider.packageList.isEmpty) {
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
        itemCount: provider.packageList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                context: context,
                to: PackageDetail(
                  data: provider.packageList[index],
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color:  Colors.yellow.shade400),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              appText(
                                title:
                                provider.packageList[index].packageName ??
                                    '',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title: _getServiceName(
                                    provider.packageList[index].service ?? []),
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
                                    '${provider.packageList[index].price ?? ""}',
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
                                  image: provider.packageList[index].image?.first ?? '',
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
                        title: '${provider.packageList[index].discount}% OFF',
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
                          Icon(
                            Icons.location_on,
                            color: appColors.appGreen,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          appText(
                            title:
                            '20 Min • ${(Geolocator.distanceBetween(latitude, longitude, provider.packageList[index].shop!.lat!, provider.packageList[index].shop!.lng!) / 1000).toStringAsFixed(2)} KM',
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

  _getServiceName(List<Service> data) {
    String text = '';
    for (int i = 0; i < data.length; i++) {
      text += i == 0 ? '${data[i].name}' : ' + ${data[i].name}';
    }
    return text;
  }

  void showSlotBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  SlotBookingDialog();
      },
    );
  }
  _openMap() async {
    var permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      var res = await showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        useSafeArea: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel))
                    ],
                  ),
                ),
                Expanded(
                  child: MapScreen(
                    lat: latitude,
                    lng: longitude,
                  ),
                ),
              ],
            ),
          );
        },
      );
      // var res = await navigateTo(
      //   context: context,
      //   to: MapScreen(
      //     lat: latitude,
      //     lng: longitude,
      //   ),
      // );
      // if (res != null) {
      //   setState(() {
      //     addressController.text = res['address'];
      //     latitude = res['latitude'];
      //     longitude = res['longitude'];
      //   });
      //   await setLatLng(latitude, longitude);
      //   _getNearByData();
      // }
    }
  }
}
