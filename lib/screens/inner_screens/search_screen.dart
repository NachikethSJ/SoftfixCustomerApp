// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/cache_manager/cache_manager.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/screens/inner_screens/map/map_screen.dart';
import 'package:salon_customer_app/screens/inner_screens/package_detail.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/loading_shimmer.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';

import '../../models/dashboard_models/near_by_service_model.dart';
import '../../utils/slot.dart';
import 'membership_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with CacheManager, SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: 'Select Location');
  late TabController _tabController;
  int selectedTabIndex = 0;
  int index = 0;
  double latitude = 28.7041;
  double longitude = 77.1025;
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
      if (res != null) {
        setState(() {
          addressController.text = res['address'];
          latitude = res['latitude'];
          longitude = res['longitude'];
        });
        await setLatLng(latitude, longitude);
        _getNearByData();
      }
    }
  }

  _getNearByData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {
          'lat': latitude,
          'lng': longitude,
          'personType': '',
        };
        provider.getShopList(
          context: context,
          body: body,
        );
        provider.getServiceList(
          context: context,
          body: body,
        );
      },
    );
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> icon = [Icons.motorcycle_outlined, Icons.shop];
    List<String> label = [texts.serviceAtHome, texts.serviceAtShop];
    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: appBar(context),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.6,
                      child: InkWell(
                        onTap: () async {
                          await _openMap();
                        },
                        child: IgnorePointer(
                          child: TextField(
                            style: const TextStyle(fontSize: 12),
                            controller: addressController,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: appColors.appColor,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: appColors.appColor,
                                  ),
                                ),
                                suffixIcon: Icon(
                                  Icons.location_on,
                                  color: appColors.appColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                    FlutterToggleTab(
                      height: 50,
                      selectedBackgroundColors: [appColors.appWhite],
                      unSelectedBackgroundColors: [appColors.appGreen],
                      width: MediaQuery.of(context).size.width / 5.5,
                      borderRadius: 30,
                      selectedTextStyle: TextStyle(
                          color: appColors.appBlack,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      unSelectedTextStyle: TextStyle(
                          color: appColors.appWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      labels: label,
                      icons: icon,
                      selectedIndex: index,
                      selectedLabelIndex: (i) {
                        setState(() {
                          index = i;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: appColors.appColor),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: SizedBox(
                          height: 46,
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: texts.searchShop,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: appColors.appBlack,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 14, bottom: 14)),
                            onChanged: (value) {
                              setState(() {
                                searchController.text = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Card(
                      color: appColors.appColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        width: 50,
                        height: 46,
                        child: Center(
                          child: Icon(
                            Icons.notifications,
                            color: appColors.appBlack,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // _showFilter();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.yellow),
                          // color: appColors.appGray,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.badge,
                                color: appColors.appGray,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              appText(
                                color: appColors.appGray,
                                title: texts.filter,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                TabBar(
                  onTap: (value) {
                    setState(() {
                      selectedTabIndex = value;
                    });
                  },
                  controller: _tabController,
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
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    selectedTabIndex == 0
                        ? _serviceList()
                        : selectedTabIndex == 1
                            ? _nearByPackagesList()
                            : _nearByMembershipList(),
                  ]),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _serviceList() {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      List<NearServiceModel> serviceData =
          provider.serviceList.where((element) {
        if (searchController.text.isNotEmpty) {
          return element.name
                  ?.toLowerCase()
                  .contains(searchController.text.toLowerCase()) ??
              false;
        }
        return true;
      }).toList();
      if (provider.showLoader) {
        return const SizedBox(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (serviceData.isEmpty) {
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
        itemCount: provider.nearShopList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(
                    title: '${provider.nearShopList[index].name}',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: appColors.appColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          appText(
                            title: '${provider.serviceList[index].subService?[0].rating ?? "0"}',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timelapse_outlined,
                            color: appColors.appGreen,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          appText(
                            title: '${provider.serviceList[index].subService?[0].price ?? ""}',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          appText(
                            title: '${(Geolocator.distanceBetween(latitude, longitude, provider.nearShopList[index].lat!, provider.nearShopList[index].lng!) / 1000).toStringAsFixed(2)}Km',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.location_on,
                            color: appColors.appColor,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child:
                            Row(
                              children: [
                                SizedBox(
                                  height: 140,
                                  width: 100,
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      appText(
                                        title: '${provider.serviceList[index].name ?? "0"}',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: appColors.appColor,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          appText(
                                            title: '${provider.serviceList[index].subService?[0].rating ?? "0"}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          appText(
                                            title: '₹${provider.serviceList[index].subService?[0].price ?? "0"}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // appText(
                                          //   title: '₹200',
                                          //   color: appColors.appGray,
                                          //   textDecoration:
                                          //       TextDecoration.lineThrough,
                                          //   fontSize: 12,
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
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
                                            title: '${provider.serviceList[index].subService?[0].timeTaken ?? "0"} Hour Service',
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SizedBox(
                                        width: 90,
                                        height: 34,
                                        child: AppButton(
                                          radius: 8,
                                          onPressed: () {
                                            showSlotBookingDialog(context);
                                          },
                                          title: '+ Book',
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
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
                      color:  Colors.yellow),
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
                                    title: 'Book Now',
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
                      color:  Colors.yellow),
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
                                // color: appColors.appGray,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title: _getServiceName(
                                    provider.packageList[index].service ?? []),
                                // color: appColors.appWhite,
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
                                        '${calculatePrice(provider.packageList[index].price, provider.packageList[index].discount)}',
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
                                    title: 'Book Now',
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

  calculatePrice(dynamic price, dynamic discount) {
    double p = double.tryParse(price.toString()) ?? 0;
    double d = double.tryParse(discount.toString()) ?? 0;
    return (p * (100 - d) / 100).toStringAsFixed(0);
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
}
