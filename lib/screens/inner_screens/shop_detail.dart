import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/cache_manager/cache_manager.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/screens/inner_screens/package_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/search_screen.dart';
import 'package:salon_customer_app/screens/inner_screens/sub_service_detail.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/dashboard_models/near_by_elements_model.dart';
import '../../models/dashboard_models/near_by_shop_model.dart';
import '../../models/dashboard_models/near_by_shop_packages_model.dart';
import '../../utils/app_button.dart';
import '../../utils/loading_shimmer.dart';
import '../../utils/navigation.dart';
import '../../utils/slot.dart';
import '../../view_models/dashboard_provider.dart';
import 'map/map_screen.dart';
import 'membership_detail.dart';

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

class _ShopDetailState extends State<ShopDetail> with CacheManager {
  TextEditingController searchController = TextEditingController();
  bool searchTextBoxVisible = false;
  double latitude = 28.7041;
  double longitude = 77.1025;
  Future getLatLongitude() async {
    var data = await getLatLng();
    setState(() {
      latitude = double.tryParse(data.first) ?? 0;
      longitude = double.tryParse(data.last) ?? 0;
    });
  }

  int selectedTabIndex = 0;
  TextEditingController addressController =
      TextEditingController(text: 'Select Location');

  @override
  void initState() {
    print('Shop Id======>>>>${widget.shopData.id}');
    // TODO: implement initState
    super.initState();
    getLatLongitude();
    _getNearByShopServices();
    _getNearByShopPackages();
    _getNearByShopMembership();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
            )),
            title: searchTextBoxVisible == false
            ? Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: appColors.appColor,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${widget.shopData.name} (${(Geolocator.distanceBetween(widget.lat, widget.lng, widget.shopData.lat!, widget.shopData.lng!) / 1000).toStringAsFixed(2)} Km Away)",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * .070,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: appColors.appColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                    height: 46,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: texts.searchShop,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchController.text = value;
                        });
                        ///APICalling
                      },
                    ),
                  ),
                ),
              ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                searchTextBoxVisible = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.search,
                color: appColors.appColor,
              ),
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
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
                        onTap: () async {
                          // await _openMap();
                        },
                        child: Container(
                          height: 40,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.teal.shade800,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions,
                                color: appColors.appColor,
                              ),
                              InkWell(
                                  onTap: () {
                                    openMap(latitude, longitude);
                                  },
                                  child: Text(
                                    texts.getDirection,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
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
      } else if (provider.nearByShopServicesList.isEmpty) {
        return SizedBox(
          height: 200,
          child: Center(
            child: appText(
                title: 'Services are not available on this Shop',
                fontSize: 15,
                fontWeight: FontWeight.w200),
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
        itemCount: provider.nearByShopServicesList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(color: appColors.appColor, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: appText(
                      title: provider
                              .nearByShopServicesList[index].service?.name ??
                          "",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, childIndex) {
                        return const SizedBox(
                          width: 1,
                        );
                      },
                      itemCount: provider.nearByShopServicesList[index]
                              .subServices?.length ??
                          0,
                      itemBuilder: (context, childIndex) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                slideTransition(
                                    context: context,
                                    to: SubServiceDetail(
                                      lat: latitude,
                                      lng: longitude,
                                      subServiceid: provider
                                          .nearByShopServicesList[index]
                                          .subServices![childIndex]
                                          .id
                                          .toString(),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 125,
                                      width: 125,
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/placeholder.png', // Path to placeholder image
                                        image:
                                            '${provider.nearByShopServicesList[index].subServices?[childIndex].imageurl?[0] ?? ""}',
                                        fit: BoxFit.cover,
                                        width: 90,
                                        height: 90,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          // Custom image error builder
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
                                    provider
                                                .nearByShopServicesList[index]
                                                .subServices?[childIndex]
                                                .offer !=
                                            null
                                        ? Positioned(
                                            left: 0,
                                            bottom: 0,
                                            child: Container(
                                              height: 25,
                                              width: 70,
                                              decoration: const BoxDecoration(
                                                  color: Colors.blue),
                                              child: Center(
                                                  child: Text(
                                                "${provider.nearByShopServicesList[index].subServices?[childIndex].offer}% Off",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 120,
                                    child: appText(
                                      title: provider
                                              .nearByShopServicesList[index]
                                              .subServices?[childIndex]
                                              .type ??
                                          "",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                        title:
                                            '${provider.nearByShopServicesList[index].subServices?[childIndex].timeTaken ?? "30"} Min Services',
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
                                            '₹${calculatePrice(double.parse(provider.nearByShopServicesList[index].subServices?[childIndex].price?.toString() ?? '0'), double.parse(provider.nearByShopServicesList[index].subServices?[childIndex].offer?.toString() ?? '0'))}',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      appText(
                                          title:
                                              '₹${provider.nearByShopServicesList[index].subServices?[childIndex].price ?? ""}',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          textDecoration:
                                              TextDecoration.lineThrough),
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
                                      RatingBar.builder(
                                        wrapAlignment: WrapAlignment.start,
                                        itemSize: 14,
                                        initialRating: provider
                                                .nearByShopServicesList[index]
                                                .subServices?[childIndex]
                                                .rating ??
                                            0,
                                        minRating: 2,
                                        direction: Axis.horizontal,
                                        ignoreGestures: true,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {},
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showSlotBookingDialog(
                                              context,
                                              provider
                                                      .nearByShopServicesList[
                                                          index]
                                                      .subServices?[
                                                          childIndex]
                                                      .id ??
                                                  0);
                                        },
                                        child: SizedBox(
                                            width: 60,
                                            height: 30,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4),
                                                  border: Border.all(
                                                      color: appColors
                                                          .appColor)),
                                              child: Center(
                                                  child: Text("Book",
                                                      style: TextStyle(
                                                          color: appColors
                                                              .appColor))),
                                            )
                                            ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${widget.shopData.lat},${widget.shopData.lng}';
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
      } else if (provider.nearByShopMembershipList.isEmpty) {
        return SizedBox(
          height: 200,
          child: Center(
            child: appText(
                title: 'Membership not available on this Shop',
                fontSize: 14,
                fontWeight: FontWeight.w200),
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
        itemCount: provider.nearByShopMembershipList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                context: context,
                to: MembershipDetail(
                  data: provider.membershipList[index],
                  lat: latitude.toInt(),
                  lang: longitude.toInt(),
                  memberid: provider.nearByShopMembershipList[index].id,
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.yellow.shade400),
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
                                title: provider.nearByShopMembershipList[index]
                                        .membershipName ??
                                    '',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title: provider.nearByShopMembershipList[index]
                                        .service?.name ??
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
                                        '${provider.nearByShopMembershipList[index].price ?? ""}',
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
                                    borderRadius: BorderRadius.circular(4)),
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
                                  placeholder:
                                      'assets/images/placeholder.png', // Path to placeholder image
                                  image: provider
                                          .nearByShopMembershipList[index]
                                          .image
                                          ?.first ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.asset(
                                      provider
                                          .nearByShopMembershipList[index]
                                          .image
                                          ?.first ??
                                          '', // Path to placeholder image
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
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                      child: appText(
                    title:
                        '${provider.nearByShopMembershipList[index].offer ?? 0}% OFF',
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
                        ignoreGestures: true,
                        allowHalfRating: true,
                        itemCount: 5,
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
      } else if (provider.nearByShopPackagesList.isEmpty) {
        return SizedBox(
          height: 200,
          child: Center(
            child: appText(
                title: 'Packages are not available on this Shop',
                fontSize: 15,
                fontWeight: FontWeight.w200),
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
        itemCount: provider.nearByShopPackagesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                context: context,
                to: PackageDetail(
                  data: provider.packageList[index],
                  lang: longitude.toInt(),
                  lat: latitude.toInt(),
                  packageid: provider.nearByShopPackagesList[index].id,
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.yellow.shade400),
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
                                title: provider.nearByShopPackagesList[index]
                                        .packageName ??
                                    '',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title:
                                    '${provider.nearByShopPackagesList[index].service?[0].name}',
                                /*_getServiceName(
                                    [provider.nearByShopPackagesList[index].service?[0].name]
                                ),*/
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
                                        '₹${calculatePrice(double.parse(provider.nearByShopPackagesList[index].price.toString() ?? "0"), double.parse(provider.nearByShopPackagesList[index].discount.toString() ?? ""))}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(width: 5),
                                  appText(
                                      title:
                                          '${provider.nearByShopPackagesList[index].price ?? ""}',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      textDecoration:
                                          TextDecoration.lineThrough),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 60,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 82, 102, 83),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: appText(
                                      title: texts.bookNow,
                                      fontWeight: FontWeight.w500,
                                      color: appColors.appWhite,
                                      fontSize: 8,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: CircleAvatar(
                              child: ClipOval(
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/images/placeholder.png', // Path to placeholder image
                                  image:
                                      '${provider.nearByShopPackagesList[index].image?.first}',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.asset(
                                      '${provider.nearByShopPackagesList[index].image?.first}',// Path to placeholder image
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
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                      child: appText(
                    title:
                        '${provider.nearByShopPackagesList[index].discount}% OFF',
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
                        ignoreGestures: true,
                        itemCount: 5,
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

  //New NearByShopServicesApi
  _getNearByShopServices() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {"id": widget.shopData.id};
        provider.getNearByShopServicesList(
          context: context,
          body: body,
        );
      },
    );
  }

  //NewNearByShopPackagesApi
  _getNearByShopPackages() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {"id": widget.shopData.id};
        provider.getNearByShopPackagesList(
          context: context,
          body: body,
        );
      },
    );
  }

  //NewNearByShopMembershipApi
  _getNearByShopMembership() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {"id": widget.shopData.id};
        provider.getNearByShopMembershipList(
          context: context,
          body: body,
        );
      },
    );
  }

  ///SearchByShopServicesApi
 /* _getSearchByShopServices() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<DashboardProvider>(context, listen: false);
      var body = {};
      provider.getSearchByShopServices(
        context:context,
        body:body,
      );
    }
    );
  }
*/
  _getServiceName(List<Service> data) {
    String text = '';
    for (int i = 0; i < data.length; i++) {
      text += i == 0 ? '${data[i].name}' : ' + ${data[i].name}';
    }
    return text;
  }

  void showSlotBookingDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlotBookingDialog(
          subServiceId: id,
        );
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
    }
  }
}
