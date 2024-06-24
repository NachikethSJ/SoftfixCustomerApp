// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/cache_manager/cache_manager.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_service_model.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_shop_model.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/screens/inner_screens/map/map_screen.dart';
import 'package:salon_customer_app/screens/inner_screens/membership_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/package_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/search_screen.dart';
import 'package:salon_customer_app/screens/inner_screens/setting/service_at_home.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/loading_shimmer.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:salon_customer_app/view_models/dashboard_provider.dart';
import '../../utils/slot.dart';
import '../../utils/validate_connectivity.dart';
import '../../utils/validator.dart';
import '../../view_models/cart_provider.dart';
import '../common_screens/cutome_image_slider.dart';
import '../common_screens/notification.dart';
import 'shop_detail.dart';
import 'sub_service_detail.dart';

class Dashboard extends StatefulWidget {
  final String personType;
  const Dashboard({super.key, required this.personType});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with CacheManager, SingleTickerProviderStateMixin {
  int index = 0;
  String selectedIndex = "1";
  int selectedTabIndex = 0;
  double latitude = 28.7041;
  double longitude = 77.1025;
  bool isOffer = false;
  bool isNearest = false;
  TextEditingController searchController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: 'Select Location');
  late TabController _tabController;
  String personType = '';
  List<String> timeItems = [
    '12:00 AM',
    '01:00 AM',
    '02:00 AM',
    '03:00 AM',
    '04:00 AM',
    '05:00 AM',
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
  ];

// Define the selected times for "From" and "To" containers
  String? selectedTimeFrom;
  String? selectedTimeTo;

// Function to generate items list for the second container based on the selected time
  List<String> getSecondContainerItems() {
    if (selectedTimeFrom == null) {
      return timeItems;
    } else {
      List<String> secondContainerItems = List.from(timeItems);
      secondContainerItems.remove(selectedTimeFrom);
      return secondContainerItems;
    }
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      await placemarkFromCoordinates(
        lat,
        lng,
      ).then((List<Placemark> placemarks) {
        print('====$placemarks');
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String name = place.name ?? '';
          String subLocality = place.subLocality ?? '';

          String address = '$name, $subLocality';

          setState(() {
            addressController.text = address;
          });
        } else {}
      }).catchError((e) {
        debugPrint(e.toString());
      });
    } catch (e) {}
  }

  Future getLatLongitude() async {
    var data = await getLatLng();
    setState(() {
      latitude = double.tryParse(data.first) ?? 0;
      longitude = double.tryParse(data.last) ?? 0;
    });
  }

  _getNearByData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {
            'lat': latitude,
            'lng': longitude,
            'personType': widget.personType,
            'serviceTypeId': "1",
            'minOffer': int.tryParse(offerLabels.start),
            'maxOffer': int.tryParse(offerLabels.end),
            'minPrice': "0",
            'maxPrice': "",
            'minDistance': int.tryParse(rangeLabels.start),
            'maxDistance': int.tryParse(rangeLabels.end),
            'minRating': int.tryParse(ratingLabels.start),
            'maxRating': int.tryParse(ratingLabels.end),
            'search': '',
        };
        provider.getShopList(
          context: context,
          body: body,
        );
        provider.getServiceList(
          context: context,
          body: body,
        );
        provider.getMembershipList(
          context: context,
          body: body,
        );
        provider.getPackagesList(
          context: context,
          body: body,
        );
      },
    );
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    getLatLongitude().then((value) {
      _getAddressFromLatLng(latitude, longitude);
      _getNearByData();
      _getUpdateList();
    });
    // Initialise  localnotification
    // LocalNotificationService.initialize();
    // To initialise the sg
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //
    // });
    //
    // // To initialise when app is not terminated
    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.notification != null) {
    //     LocalNotificationService.display(message);
    //   }
    // });
    //
    // // To handle when app is open in
    // // user divide and heshe is using it
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print("on message opened app");
    // });
    super.initState();
    cartDetails();
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

  @override
  Widget build(BuildContext context) {
    List<IconData> icon = [Icons.motorcycle_outlined, Icons.shop];
    List<String> label = [
      texts.serviceAtShop,
      texts.serviceAtHome,
    ];
    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
                  child: FlutterToggleTab(
                    height: 42,
                    selectedBackgroundColors: [appColors.appWhite],
                    unSelectedBackgroundColors: const [Colors.yellow],
                    width: MediaQuery.of(context).size.width / 5.5,
                    borderRadius: 4,
                    selectedTextStyle: TextStyle(
                        color: appColors.appBlack,
                        fontSize: 8,
                        fontWeight: FontWeight.w500),
                    unSelectedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    labels: label,
                    icons: icon,
                    selectedIndex: index,
                    selectedLabelIndex: (i) {
                      setState(() {
                        selectedIndex = '${i + 1}';

                        index = i;
                        _getNearByData();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            selectedIndex == '1'
                ? Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 12, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Consumer<DashboardProvider>(
                                  builder: (context, provider, child) {
                                    return InkWell(
                                      onTap: () {
                                        slideTransition(
                                            context: context,
                                            to: SearchScreen(
                                              personType: provider.personType,
                                              lang: longitude,
                                              lat: latitude,
                                            ));
                                      },
                                      child: IgnorePointer(
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: appColors.appColor),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: SizedBox(
                                            height: 46,
                                            child: TextFormField(
                                              controller: searchController,
                                              decoration: InputDecoration(
                                                  hintText: texts.searchShop,
                                                  hintStyle:
                                                      TextStyle(fontSize: 12),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  suffixIcon: Icon(
                                                    Icons.search,
                                                    color: appColors.appGray,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 12,
                                                          right: 12,
                                                          top: 10,
                                                          bottom: 10)),
                                              onChanged: (value) {
                                                setState(() {
                                                  searchController.text = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NotificationScreen()));
                                },
                                child: Card(
                                  color: appColors.appColor,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: SizedBox(
                                    width: 50,
                                    height: 46,
                                    child: Center(
                                      child: Badge(
                                        label: const Text("0"),
                                        backgroundColor: Colors.teal,
                                        child: Icon(
                                          Icons.notifications,
                                          color: appColors.appBlack,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 162,
                                  child: Consumer<DashboardProvider>(
                                      builder: (context, provider, child) {
                                    List<SubService> subService = provider
                                        .subServiceList
                                        .where((element) {
                                      if (searchController.text.isNotEmpty) {
                                        return element.type
                                                ?.toLowerCase()
                                                .contains(searchController.text
                                                    .toLowerCase()) ??
                                            false;
                                      }
                                      return true;
                                    }).toList();
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
                                          return SizedBox(
                                            height: 100,
                                            width: 130,
                                            child: loadingShimmer(),
                                          );
                                        },
                                      );
                                    } else if (subService.isEmpty) {
                                      return Center(
                                        child: appText(title: texts.notFound),
                                      );
                                    }
                                    return ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 14,
                                        );
                                      },
                                      itemCount: subService.length > 10
                                          ? 10
                                          : subService.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            slideTransition(
                                                context: context,
                                                to: SubServiceDetail(
                                                  lat: latitude,
                                                  lng: longitude,
                                                  subServiceid:
                                                      subService[index]
                                                          .id
                                                          .toString(),
                                                ));
                                          },
                                          child: Container(
                                            width: 130,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
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
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    children: [
                                                      SizedBox(
                                                        height: 80,
                                                        width: double.infinity,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                            placeholder:
                                                                'assets/images/placeholder.png', // Path to placeholder image
                                                            image: subService[
                                                                        index]
                                                                    .image
                                                                    ?.first ??
                                                                '',
                                                            fit: BoxFit.cover,
                                                            width: 90,
                                                            height: 90,
                                                            imageErrorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              // Custom image error builder
                                                              return Image.network(
                                                                  subService[index]
                                                                          .image
                                                                          ?.first ??
                                                                      '');
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      subService[index].offer !=
                                                              null
                                                          ? Container(
                                                              height: 25,
                                                              width: 50,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8)),
                                                              ),
                                                              child: Center(
                                                                  child:
                                                                      appText(
                                                                title:
                                                                    '${subService[index].offer}% OFF',
                                                                color: appColors
                                                                    .appWhite,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              )),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  appText(
                                                      title:
                                                          truncateWithEllipsis(
                                                              14,
                                                              subService[index]
                                                                      .type ??
                                                                  ''),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.7)),
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
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            appText(
                                                                title:
                                                                    '₹${subService[index].price}',
                                                                color: appColors
                                                                    .appGray,
                                                                textDecoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            appText(
                                                                title:
                                                                    '₹${calculatePrice(double.parse(subService[index].price?.toString() ?? '0'), double.parse(subService[index].offer?.toString() ?? '0'))}',
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7)),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          //Select Slot Dialog
                                                          showSlotBookingDialog(
                                                              context,
                                                              '${subService[index].id}');
                                                        },
                                                        child: Container(
                                                          height: 25,
                                                          width: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: appColors
                                                                        .appColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                          child: Center(
                                                            child: appText(
                                                              title: texts.book,
                                                              fontSize: 12,
                                                              color: appColors
                                                                  .appColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                //Slider.........
                                Consumer<DashboardProvider>(
                                  builder: (context, provider, child) {
                                    if (provider.showLoader) {
                                      return const CircularProgressIndicator();
                                    }
                                    return DynamicPageView(
                                      imagePaths: provider.imageList,
                                      indicatorColor: Colors.teal,
                                      activeIndicatorColor: appColors.appColor,
                                      lat: latitude,
                                      lang: longitude,
                                    );
                                  },
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     appText(
                                //       title: texts.bookAgain,
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //     appText(
                                //       title: texts.seeAll,
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.bold,
                                //       color: appColors.appGreen,
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 12,
                                // ),
                                //
                                // SizedBox(
                                //   height: 174,
                                //   child: Consumer<DashboardProvider>(
                                //       builder: (context, provider, child) {
                                //     if (provider.showLoader) {
                                //       return ListView.separated(
                                //         itemCount: 4,
                                //         shrinkWrap: true,
                                //         scrollDirection: Axis.horizontal,
                                //         separatorBuilder: (context, index) {
                                //           return const SizedBox(
                                //             width: 14,
                                //           );
                                //         },
                                //         itemBuilder: (context, index) {
                                //           return SizedBox(
                                //             height: 100,
                                //             width: 130,
                                //             child: loadingShimmer(),
                                //           );
                                //         },
                                //       );
                                //     } else if (provider.serviceList.isEmpty) {
                                //       return Center(
                                //         child: appText(title: texts.notFound),
                                //       );
                                //     }
                                //     return ListView.separated(
                                //       separatorBuilder: (context, index) {
                                //         return const SizedBox(
                                //           width: 6,
                                //         );
                                //       },
                                //       padding: const EdgeInsets.all(0),
                                //       itemCount: provider.serviceList.length,
                                //       shrinkWrap: true,
                                //       scrollDirection: Axis.horizontal,
                                //       itemBuilder: (context, index) {
                                //         return SizedBox(
                                //           width: 150,
                                //           child: Padding(
                                //             padding: const EdgeInsets.all(8),
                                //             child: Column(
                                //               crossAxisAlignment: CrossAxisAlignment.start,
                                //               children: [
                                //                 SizedBox(
                                //                   width: 150,
                                //                   height: 120,
                                //                   child: ClipRRect(
                                //                     borderRadius: BorderRadius.circular(16),
                                //                     child: Container(
                                //                       color: Colors.yellowAccent.shade100,
                                //                       child: Padding(
                                //                         padding: const EdgeInsets.all(6),
                                //                         child: Column(
                                //                           mainAxisAlignment:
                                //                               MainAxisAlignment.start,
                                //                           children: [
                                //                             // GridView.builder(
                                //                             //   padding:
                                //                             //       const EdgeInsets.all(0),
                                //                             //   shrinkWrap: true,
                                //                             //   physics:
                                //                             //       const NeverScrollableScrollPhysics(),
                                //                             //   itemCount: provider
                                //                             //               .serviceList[
                                //                             //                   index]
                                //                             //               .subService!
                                //                             //               .length >
                                //                             //           4
                                //                             //       ? 4
                                //                             //       : provider
                                //                             //           .serviceList[index]
                                //                             //           .subService
                                //                             //           ?.length,
                                //                             //   gridDelegate:
                                //                             //       const FixedGridViewHeight(
                                //                             //           crossAxisCount: 2,
                                //                             //           height: 50,
                                //                             //           mainAxisSpacing: 5,
                                //                             //           crossAxisSpacing: 5),
                                //                             //   itemBuilder: (context, i) {
                                //                             //     return Column(
                                //                             //       crossAxisAlignment: CrossAxisAlignment.center,
                                //                             //       children: [
                                //                             //         Container(
                                //                             //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                //                             //           height:35,
                                //                             //           width: 35,
                                //                             //           child: ClipRRect(
                                //                             //             borderRadius:BorderRadius.circular(12),
                                //                             //             child: Image.network(
                                //                             //               provider
                                //                             //                       .serviceList[
                                //                             //                           index]
                                //                             //                       .subService?[i]
                                //                             //                       .image
                                //                             //                       ?.first ??
                                //                             //                   '',
                                //                             //               fit: BoxFit.fill,
                                //                             //             ),
                                //                             //           ),
                                //                             //         ),
                                //                             //         const SizedBox(height: 2,),
                                //                             //         Text("${provider.serviceList[index].subService?[i].type}",style: TextStyle(fontSize: 8),),
                                //                             //       ],
                                //                             //     );
                                //                             //   },
                                //                             // ),
                                //                             GridView.builder(
                                //                               padding: const EdgeInsets.all(0),
                                //                               shrinkWrap: true,
                                //                               physics: const NeverScrollableScrollPhysics(),
                                //                               itemCount: provider.serviceList[index].subService!.length > 4
                                //                                   ? 4
                                //                                   : provider.serviceList[index].subService!.length,
                                //                               gridDelegate: const FixedGridViewHeight(
                                //                                 crossAxisCount: 2,
                                //                                 height: 50,
                                //                                 mainAxisSpacing: 5,
                                //                                 crossAxisSpacing: 5,
                                //                               ),
                                //                               itemBuilder: (context, i) {
                                //                                 if (i == 3 && provider.serviceList[index].subService!.length > 4) {
                                //                                   return Column(
                                //                                     crossAxisAlignment: CrossAxisAlignment.center,
                                //                                     children: [
                                //                                       Container(
                                //                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                //                                         height: 35,
                                //                                         width: 35,
                                //                                         child: ClipRRect(
                                //                                           borderRadius: BorderRadius.circular(12),
                                //                                           child: Center(
                                //                                             child: Text(
                                //                                               '+${provider.serviceList[index].subService!.length - 3}',
                                //                                               style: TextStyle(fontSize: 12),
                                //                                             ),
                                //                                           ),
                                //                                         ),
                                //                                       ),
                                //                                       const SizedBox(height: 2,),
                                //                                       Text(
                                //                                         "More",
                                //                                         style: TextStyle(fontSize: 8),
                                //                                       ),
                                //                                     ],
                                //                                   );
                                //                                 } else {
                                //                                   return Column(
                                //                                     crossAxisAlignment: CrossAxisAlignment.center,
                                //                                     children: [
                                //                                       Container(
                                //                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                //                                         height: 35,
                                //                                         width: 35,
                                //                                         child: ClipRRect(
                                //                                           borderRadius: BorderRadius.circular(12),
                                //                                           child: Image.network(
                                //                                             provider.serviceList[index].subService![i].image?.first ?? '',
                                //                                             fit: BoxFit.fill,
                                //                                           ),
                                //                                         ),
                                //                                       ),
                                //                                       const SizedBox(height: 2,),
                                //                                       Text(
                                //                                         "${provider.serviceList[index].subService![i].type}",
                                //                                         style: TextStyle(fontSize: 8),
                                //                                       ),
                                //                                     ],
                                //                                   );
                                //                                 }
                                //                               },
                                //                             ),
                                //
                                //                           ],
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 6,
                                //                 ),
                                //                 appText(
                                //                   title: provider.serviceList[index].name ??
                                //                       '',
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w500,
                                //                 ),
                                //                 const SizedBox(
                                //                   height: 4,
                                //                 ),
                                //                 // appText(
                                //                 //   title:
                                //                 //       '${provider.serviceList[index].subService?.length ?? 0} Products',
                                //                 //   color: appColors.appGray,
                                //                 //   fontSize: 12,
                                //                 //   fontWeight: FontWeight.w500,
                                //                 // ),
                                //               ],
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   }),
                                // ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    appText(
                                      title: texts.nearBy,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: appColors.appColor,
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _showFilter();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: appColors.appColor),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 4, 16, 4),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.badge,
                                                color: appColors.appColor,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              appText(
                                                color: appColors.appColor,
                                                title: texts.filter,
                                                fontWeight: FontWeight.w600,
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
                                  labelStyle: const TextStyle(fontSize: 14),
                                  indicatorColor: appColors.appColor,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: [
                                    Tab(
                                      text: texts.shops,
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
                        ))
                      ],
                    ),
                  )
                : const Align(
              alignment: Alignment.center,
                child: Text('Coming Soon'))
          ],
        )),
      ),
    );
  }

  _nearByShopList() {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      List<NearByShopModel> shopsData = provider.nearShopList.where((element) {
        if (searchController.text.isNotEmpty) {
          return element.name
                  ?.toLowerCase()
                  .contains(searchController.text.toLowerCase()) ??
              false;
        }
        return true;
      }).toList();
      // int selectedServiceType = provider.serviceList;
      // if (selectedServiceType != null) {
      //   shopsData = shopsData.where((shop) => shop.id == selectedServiceType).toList();
      // }
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
      } else if (shopsData.isEmpty) {
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
        itemCount: shopsData.length,
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
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    width: double.infinity,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: FadeInImage.assetNetwork(
                        placeholder:
                            'assets/images/placeholder.png', // Path to placeholder image
                        image: shopsData[index].imageUrl?[0] ?? '',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                        imageErrorBuilder: (context, error, stackTrace) {
                          // Custom image error builder
                          return Image.network(
                              shopsData[index].imageUrl?[0] ?? '');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                              title: shopsData[index].name ?? '',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.7)),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              appText(
                                  title: truncateWithEllipsis(
                                      40, shopsData[index].description ?? ""),
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  textOverflow: TextOverflow.ellipsis),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              appText(title: '${shopsData[index].rating}')
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                          'UpTo ${shopsData[index].discountAvg.toStringAsFixed(0)}%',
                                      color: Colors.indigo.shade400)
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/time_icon1.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  appText(
                                      color: Colors.grey.shade600,
                                      title: '20 Min • ',
                                      fontWeight: FontWeight.w500),
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.green.shade300,
                                    size: 15,
                                  ),
                                  appText(
                                    color: Colors.grey.shade600,
                                    title:
                                        '${(Geolocator.distanceBetween(latitude, longitude, shopsData[index].lat!, shopsData[index].lng!) / 1000).toStringAsFixed(2)} KM',
                                  )
                                ],
                              ),
                            ],
                          )
                        ]),
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
                  lat: latitude.toInt(),
                  lang: longitude.toInt(),
                  memberid: provider.membershipList[index].id,
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.yellowAccent.shade100),
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
                                  placeholder:
                                      'assets/images/placeholder.png', // Path to placeholder image
                                  image: provider
                                          .membershipList[index].image?.first ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.network(
                                        "${provider.membershipList[index].image}");
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
                provider.membershipList[index].offer != null
                    ? Container(
                        height: 20,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                            child: appText(
                          title:
                              '${provider.membershipList[index].offer ?? "0"}% OFF',
                          color: appColors.appWhite,
                          fontWeight: FontWeight.bold,
                        )),
                      )
                    : const SizedBox(),
                Positioned(
                  bottom: 10,
                  left: 8,
                  child: Row(
                    children: [
                      RatingBar.builder(
                        wrapAlignment: WrapAlignment.start,
                        itemSize: 16,
                        initialRating: provider.membershipList[index].service
                                ?.subService?.rating ??
                            0,
                        minRating: 1,
                        direction: Axis.horizontal,
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
                          Image.asset(
                            'assets/images/time_icon1.png',
                            height: 20,
                            width: 20,
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
                  lang: longitude.toInt(),
                  lat: latitude.toInt(),
                  packageid: provider.packageList[index].id,
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.yellowAccent.shade100),
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
                                          .packageList[index].image?.first ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.network(
                                        "${provider.packageList[index].image}");
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
                        initialRating: provider.packageList[index].service?[0]
                                .subServices?[0].rating ??
                            0,
                        minRating: 1,
                        direction: Axis.horizontal,
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
                          Image.asset(
                            'assets/images/time_icon1.png',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          appText(
                            title:
                                '20 Min• ${(Geolocator.distanceBetween(latitude, longitude, provider.packageList[index].shop!.lat!, provider.packageList[index].shop!.lng!) / 1000).toStringAsFixed(2)} KM',
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

  RangeValues values = const RangeValues(1, 1);
  RangeLabels labels = const RangeLabels('0', "50000");

  RangeValues offerValue = const RangeValues(1, 1);
  RangeLabels offerLabels = const RangeLabels("0", "100");

  ///DashboardonlyDistanceAndRatingShowing
  RangeValues rangeValue = const RangeValues(1, 1);
  RangeLabels rangeLabels = const RangeLabels('0', "40");

  RangeValues ratingValue = const RangeValues(1, 1);
  RangeLabels ratingLabels = const RangeLabels("0", "5");

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Wrap(children: [
          StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appText(
                          title: texts.filter,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ///pricefilterhide
                    /*Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: appText(
                            title: texts.price,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: 30,
                          child: appText(
                            title: '0',
                            fontSize: 12,
                          ),
                        ),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              sliderTheme: SliderThemeData(
                                valueIndicatorTextStyle: TextStyle(
                                  color: appColors.appBlack,
                                ),
                                thumbColor: appColors.appColor,
                                activeTrackColor: appColors.appColor,
                                inactiveTrackColor: appColors.appGray,
                                valueIndicatorColor: appColors.appColor,
                                activeTickMarkColor: appColors.appColor,
                              ),
                            ),
                            child: RangeSlider(
                              divisions: 50000,
                              min: 1,
                              max: 50000,
                              values: values,
                              labels: labels,
                              // onChanged: (value) {
                              //   setState(() {
                              //     values = value;
                              //     // Update labels dynamically
                              //     labels = RangeLabels(
                              //       value.start.toInt().toString(),
                              //       value.end.toInt().toString(),
                              //     );
                              //   });
                              // },
                              onChanged: (value) {
                                setState(() {
                                  values = value;
                                  // Update labels with specific intervals
                                  int interval =
                                      (values.end - values.start) ~/
                                          1; // Calculate interval
                                  labels = RangeLabels(
                                    values.start.toInt().toString(),
                                    (values.start.toInt() + interval)
                                        .toString(),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        appText(
                          title: '50000',
                          fontSize: 12,
                        ),
                      ],
                    ),*/
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: appText(
                            title: texts.distance,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: 30,
                          child: appText(
                            title: '0 KM',
                            fontSize: 12,
                          ),
                        ),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              sliderTheme: SliderThemeData(
                                valueIndicatorTextStyle: TextStyle(
                                  color: appColors.appBlack,
                                ),
                                thumbColor: appColors.appColor,
                                activeTrackColor: appColors.appColor,
                                inactiveTrackColor: appColors.appGray,
                                valueIndicatorColor: appColors.appColor,
                                activeTickMarkColor: appColors.appColor,
                              ),
                            ),
                            child: RangeSlider(
                              divisions: 40,
                              min: 0,
                              max: 40,
                              values: rangeValue,
                              labels: rangeLabels,
                              onChanged: (value) {
                                setState(() {
                                  rangeValue = value;
                                  // Update labels with specific intervals
                                  int interval =
                                      (rangeValue.end - rangeValue.start) ~/
                                          1; // Calculate interval
                                  rangeLabels = RangeLabels(
                                    rangeValue.start.toInt().toString(),
                                    (rangeValue.start.toInt() + interval)
                                        .toString(),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        appText(
                          title: '40 KM',
                          fontSize: 12,
                        ),
                      ],
                    ),
                    /*const Divider(
                      color: Colors.grey,
                      indent: 15,
                      endIndent: 15,
                    ),*/
                    ///offerfilterhide
                    /* Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: appText(
                            title: texts.offer,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: 30,
                          child: appText(
                            title: '0%',
                            fontSize: 12,
                          ),
                        ),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              sliderTheme: SliderThemeData(
                                valueIndicatorTextStyle: TextStyle(
                                  color: appColors.appBlack,
                                ),
                                thumbColor: appColors.appColor,
                                activeTrackColor: appColors.appColor,
                                inactiveTrackColor: appColors.appGray,
                                valueIndicatorColor: appColors.appColor,
                                activeTickMarkColor: appColors.appColor,
                              ),
                            ),
                            child: RangeSlider(
                              divisions: 100,
                              min: 1,
                              max: 100,
                              values: offerValue,
                              labels: offerLabels,
                              onChanged: (value) {
                                setState(() {
                                  offerValue = value;
                                  // Calculate interval between each division
                                  double interval =
                                      (offerValue.end - offerValue.start) / 1;
                                  // Update labels with specific intervals
                                  offerLabels = RangeLabels(
                                    offerValue.start.toInt().toString(),
                                    (offerValue.start + interval)
                                        .toInt()
                                        .toString(),
                                  );
                                });
                              },
                            ),
                          ),
                        ),

                        appText(
                          title: '100 %',
                          fontSize: 12,
                        ),

                        // Checkbox(
                        //   value: isOffer,
                        //   activeColor: appColors.appColor,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       isOffer = value!;
                        //     });
                        //   },
                        // ),
                      ],
                    ),*/
                    // Divider(
                    //   color: Colors.grey,
                    //   indent: 15,
                    //   endIndent: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 60,
                    //       child: appText(
                    //         title: texts.nearest,
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     Checkbox(
                    //       value: isNearest,
                    //       activeColor: appColors.appColor,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isNearest = value!;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // const Divider(
                    //   color: Colors.grey,
                    //   indent: 15,
                    //   endIndent: 15,
                    // ),
                    // // Row(
                    // //   children: [
                    // //     appText(
                    // //         title: "Rating",
                    // //         fontWeight: FontWeight.bold
                    // //     ),
                    // //     RatingBar.builder(
                    // //       wrapAlignment: WrapAlignment.start,
                    // //       itemSize: 30,
                    // //       initialRating: 3,
                    // //       minRating: 1,
                    // //       direction: Axis.horizontal,
                    // //       allowHalfRating: true,
                    // //       itemCount: 4,
                    // //       itemBuilder: (context, _) => const Icon(
                    // //         Icons.star,
                    // //         color: Colors.amber,
                    // //       ),
                    // //       onRatingUpdate: (value) {},
                    // //     ),
                    // //
                    // //   ],
                    // // ),
                    // // Row(
                    // //   children: [
                    // //     SizedBox(
                    // //       height: 40,
                    // //       width: 40,
                    // //       child: FittedBox(
                    // //         fit: BoxFit.fitWidth,
                    // //         child: Checkbox(
                    // //           shape: RoundedRectangleBorder(
                    // //               borderRadius:
                    // //               BorderRadius
                    // //                   .circular(4),
                    // //               side: const BorderSide(
                    // //                   color: Colors
                    // //                       .indigoAccent)),
                    // //           side:  BorderSide(
                    // //               color: appColors.appColor),
                    // //           checkColor: Colors.white,
                    // //           activeColor:
                    // //           Colors.indigoAccent,
                    // //           value: _isMenChecked,
                    // //           onChanged: (bool? value) {
                    // //             setState(() {
                    // //               _isMenChecked = value ??
                    // //                   false; // Update the value in _isChecked list
                    // //             });
                    // //           },
                    // //
                    // //         ),
                    // //       ),
                    // //     ),
                    // //     appText(title: "Mens"),
                    // //     SizedBox(
                    // //       height: 40,
                    // //       width: 40,
                    // //       child: FittedBox(
                    // //         fit: BoxFit.fitWidth,
                    // //         child: Checkbox(
                    // //           shape: RoundedRectangleBorder(
                    // //               borderRadius:
                    // //               BorderRadius
                    // //                   .circular(4),
                    // //               side: const BorderSide(
                    // //                   color: Colors
                    // //                       .indigoAccent)),
                    // //           side:  BorderSide(
                    // //               color: appColors.appColor),
                    // //           checkColor: Colors.white,
                    // //           activeColor:
                    // //           Colors.indigoAccent,
                    // //           value: _isWomenChecked,
                    // //           onChanged: (bool? value) {
                    // //             setState(() {
                    // //               _isWomenChecked = value ??
                    // //                   false; // Update the value in _isChecked list
                    // //             });
                    // //           },
                    // //
                    // //         ),
                    // //       ),
                    // //     ),
                    // //     appText(title: "Womens"),
                    // //     SizedBox(
                    // //       height: 40,
                    // //       width: 40,
                    // //       child: FittedBox(
                    // //         fit: BoxFit.fitWidth,
                    // //         child: Checkbox(
                    // //           shape: RoundedRectangleBorder(
                    // //               borderRadius:
                    // //               BorderRadius
                    // //                   .circular(4),
                    // //               side:  BorderSide(
                    // //                   color: appColors.appColor)),
                    // //           side:  BorderSide(
                    // //               color: appColors.appColor),
                    // //           checkColor: Colors.white,
                    // //           activeColor:
                    // //           Colors.indigoAccent,
                    // //           value: _isKidsChecked,
                    // //           onChanged: (bool? value) {
                    // //             setState(() {
                    // //               _isKidsChecked = value ??
                    // //                   false; // Update the value in _isChecked list
                    // //             });
                    // //           },
                    // //
                    // //         ),
                    // //       ),
                    // //     ),
                    // //     appText(title: "kids"),
                    // //   ],
                    // // ),
                    //
                    // Row(
                    //   children: [
                    //     appText(title: "Booking Date"),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         _selectbookingDate(context);
                    //       },
                    //       child: Container(
                    //         height: 45,
                    //         width: 130,
                    //         decoration: BoxDecoration(
                    //           border:
                    //               Border.all(width: 1, color: Colors.yellow),
                    //           borderRadius: BorderRadius.circular(8.0),
                    //         ),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Text(
                    //                 DateFormat('MMM d, yyyy')
                    //                     .format(_selectedDate),
                    //                 style: const TextStyle(fontSize: 14),
                    //               ),
                    //             ),
                    //             Icon(
                    //               Icons.calendar_today,
                    //               color: appColors.appColor,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // const Divider(
                    //   color: Colors.grey,
                    //   indent: 15,
                    //   endIndent: 15,
                    // ),
                    // Row(
                    //   children: [
                    //     appText(title: "Booking Time from"),
                    //     SizedBox(width: 10),
                    //     SizedBox(
                    //       width: 80,
                    //       child: Container(
                    //         height: 40,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: appColors.appColor),
                    //             borderRadius: BorderRadius.circular(12)),
                    //         child: Row(
                    //           children: [
                    //             DropdownButtonHideUnderline(
                    //               child: DropdownButton<String>(
                    //                 value: selectedTimeFrom,
                    //                 onChanged: (String? newValue) {
                    //                   setState(() {
                    //                     selectedTimeFrom = newValue;
                    //                   });
                    //                 },
                    //                 items: timeItems
                    //                     .map<DropdownMenuItem<String>>(
                    //                         (String value) {
                    //                   return DropdownMenuItem<String>(
                    //                     value: value,
                    //                     child: Padding(
                    //                       padding:
                    //                           const EdgeInsets.only(left: 5),
                    //                       child: Text(
                    //                         value,
                    //                         style: TextStyle(fontSize: 10),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 }).toList(),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 5),
                    //     appText(title: "To"),
                    //     const SizedBox(width: 5),
                    //     SizedBox(
                    //       width: 80, // Specified width for the container
                    //       child: Container(
                    //         height: 40,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: appColors.appColor),
                    //             borderRadius: BorderRadius.circular(12)),
                    //         child: Row(
                    //           children: [
                    //             DropdownButtonHideUnderline(
                    //               child: DropdownButton<String>(
                    //                 value: selectedTimeTo,
                    //                 onChanged: (String? newValue) {
                    //                   setState(() {
                    //                     selectedTimeTo = newValue;
                    //                   });
                    //                 },
                    //                 items: getSecondContainerItems()
                    //                     .map<DropdownMenuItem<String>>(
                    //                         (String value) {
                    //                   return DropdownMenuItem<String>(
                    //                     value: value,
                    //                     child: Padding(
                    //                       padding:
                    //                           const EdgeInsets.only(left: 5),
                    //                       child: Text(
                    //                         value,
                    //                         style:
                    //                             const TextStyle(fontSize: 10),
                    //                       ),
                    //                     ),
                    //                   );
                    //                 }).toList(),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Divider(
                      color: Colors.grey,
                      endIndent: 15,
                      indent: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: appText(
                            title: texts.rating,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        SizedBox(
                          width: 30,
                          child: appText(
                            title: '0',
                            fontSize: 12,
                          ),
                        ),
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              sliderTheme: SliderThemeData(
                                valueIndicatorTextStyle: TextStyle(
                                  color: appColors.appBlack,
                                ),
                                thumbColor: appColors.appColor,
                                activeTrackColor: appColors.appColor,
                                inactiveTrackColor: appColors.appGray,
                                valueIndicatorColor: appColors.appColor,
                                activeTickMarkColor: appColors.appColor,
                              ),
                            ),
                            child: RangeSlider(
                              divisions: 5,
                              min: 0.0,
                              max: 5,
                              values: ratingValue,
                              labels: ratingLabels,
                              onChanged: (value) {
                                setState(() {
                                  ratingValue = value;
                                  // Calculate interval between each division
                                  double interval =
                                      (ratingValue.end - ratingValue.start) / 1;
                                  // Update labels with specific intervals
                                  ratingLabels = RangeLabels(
                                    ratingValue.start.toInt().toString(),
                                    (ratingValue.start + interval)
                                        .toInt()
                                        .toString(),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                        appText(
                          title: '5',
                          fontSize: 12,
                        ),
                        // Checkbox(
                        //   value: isOffer,
                        //   activeColor: appColors.appColor,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       isOffer = value!;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      endIndent: 15,
                      indent: 15,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppButton(
                              radius: 12,
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                _getNearByData();
                              },
                              title: texts.apply,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: AppButton(
                              radius: 12,
                              onPressed: () {
                                setState(() {
                                  // Reset values here.......
                                  ///PriceFilterRange
                                  /* values = RangeValues(1, 1);
                                  labels = RangeLabels('0', '0');*/
                                  ///OfferFilterRange
                                  /* offerValue = RangeValues(1, 1);
                                  offerLabels= RangeValues('0','1');*/
                                  rangeValue = const RangeValues(1, 1);
                                  rangeLabels = const RangeLabels('0', '40');
                                  ratingValue = const RangeValues(1, 1);
                                  ratingLabels = const RangeLabels('0', '5');
                                  isOffer = false;
                                  isNearest = false;
                                });
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                _getNearByData();
                              },
                              title: texts.reset,
                              color: appColors.appGreen,
                              textColor: appColors.appWhite,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            );
          }),
        ]);
      },
    ).whenComplete(() {});
  }

  _getServiceName(List<Service> data) {
    String text = '';
    for (int i = 0; i < data.length; i++) {
      text += i == 0 ? '${data[i].name}' : ' + ${data[i].name}';
    }
    return text;
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

  cartDetails() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<CartProvider>(context, listen: false);
          provider.cartDetails(
            context: context,
          );
        });
  }

  _getUpdateList() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).latestDetails(
        context: context,
      );
    });
  }
}
