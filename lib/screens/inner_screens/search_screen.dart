// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/cache_manager/cache_manager.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/screens/inner_screens/map/map_screen.dart';
import 'package:salon_customer_app/screens/inner_screens/package_detail.dart';
import 'package:salon_customer_app/screens/inner_screens/sub_service_detail.dart';
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
  final String personType;
  final double? lang;
  final double? lat;
  const SearchScreen(
      {required this.personType,
      required this.lang,
      required this.lat,
      super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with CacheManager, SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: 'Select Location');
  late TabController _tabController;
  int selectedTabIndex = 0;
  int index = 0;
  bool isOffer = false;
  bool isNearest = false;
  bool isPackage = false;
  bool isMemberShip = false;
  // double latitude = 28.7041;
  // double longitude = 77.1025;
  DateTime _selectedDate = DateTime.now();
  String? selectedTimeFrom;
  String? selectedTimeTo;
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

  Future<void> _selectbookingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  List<String> getSecondContainerItems() {
    if (selectedTimeFrom == null) {
      return timeItems;
    } else {
      List<String> secondContainerItems = List.from(timeItems);
      secondContainerItems.remove(selectedTimeFrom);
      return secondContainerItems;
    }
  }

  _getNearByData() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider = Provider.of<DashboardProvider>(context, listen: false);
        var body = {
          'lat': widget.lat,
          'lng': widget.lang,
          'personType': widget.personType,
          'serviceTypeId': "1",
          'minOffer': int.tryParse(offerLabels.start),
          'maxOffer': int.tryParse(offerLabels.end),
          'minPrice': minPriceController.text.toString(),
          'maxPrice': maxPriceController.text.toString(),
          'minDistance': int.tryParse(rangeLabels.start),
          'maxDistance': int.tryParse(rangeLabels.end),
          'minRating': int.tryParse(ratingLabels.start),
          'maxRating': int.tryParse(ratingLabels.end),
          //'searchShop': searchController.text ?? '',
          //'searchService': searchController.text ?? '',
          'search': searchController.text ?? '',
        };
        print("====$body");
        provider.getSearchShopList(
          context: context,
          body: body,
        );
        provider.getSearchServiceList(
          context: context,
          body: body,
        );
        provider.getSearchMembershipList(
          context: context,
          body: body,
        );
        provider.getSearchPackagesList(
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
    _getNearByData();
    print("PersonType${widget.personType}");
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
          /* appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
            title: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*.070,
                  width: MediaQuery.of(context).size.width*0.5,
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
                          suffixIcon: Icon(
                            Icons.search,
                            color: appColors.appBlack,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchController.text = value;
                          });
                          _getNearByData();
                        },
                      ),
                    ),
                  ),
                ),
               const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    _showFilter();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height*.060,
                    width: MediaQuery.of(context).size.width*0.2,
                    padding: EdgeInsets.fromLTRB(8,0,8,0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.yellow),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.badge,
                          color: appColors.appGray,
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        appText(
                          color: appColors.appGray,
                          title: texts.filter,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),*/
          body: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
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
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: appColors.appBlack,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchController.text = value;
                                });
                                _getNearByData();
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          _showFilter();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .060,
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.yellow),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.badge,
                                color: appColors.appGray,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              appText(
                                color: appColors.appGray,
                                title: texts.filter,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ///SearchBoxAndShowFilterCommentedHere
                /*Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 4,
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
                              _getNearByData();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                /*const SizedBox(
                  height: 4,
                ),*/
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        _showFilter();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.yellow),
                          // color: appColors.appGray,
                          borderRadius: BorderRadius.circular(4),
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
                ),*/
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
          provider.searchserviceList.where((element) {
        if (searchController.text.isNotEmpty) {
          return element.serviceName
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
        itemCount: serviceData.length > 10 ? 10 : serviceData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(
                      title: '${serviceData[index].shopName}',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          appText(
                            title:
                                '${serviceData[index].rating}',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/time_icon1.png',
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          appText(
                              title:
                                  '${serviceData[index].subService?[0].timeTaken ?? "30"} Min',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade400),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          appText(
                              title:
                                  '${(Geolocator.distanceBetween(widget.lat ?? 0, widget.lang ?? 0, serviceData[index].lat!, serviceData[index].lng!) / 1000).toStringAsFixed(2)}Km',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade400),
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
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 1,
                        );
                      },
                      itemCount: serviceData[index].subService?.length ?? 0,
                      itemBuilder: (context, i) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                slideTransition(
                                    context: context,
                                    to: SubServiceDetail(
                                      lat: widget.lat,
                                      lng: widget.lang,
                                      subServiceid: serviceData[index]
                                          .subService![i]
                                          .id
                                          .toString(),
                                    ));
                              },
                              child: Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 120,
                                            width: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.network(
                                                serviceData[index]
                                                        .subService?[i]
                                                        .image
                                                        ?.first ??
                                                    "",
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    color: appColors.appGray100,
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.photo,
                                                        color:
                                                            appColors.appGray,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          serviceData[index]
                                                      .subService?[i]
                                                      .offer !=
                                                  null
                                              ? Positioned(
                                                  left: 5,
                                                  bottom: 5,
                                                  child: Container(
                                                    height: 25,
                                                    width: 70,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.blue),
                                                    child: Center(
                                                        child: Text(
                                                      "${serviceData[index].subService?[i].offer}% Off",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                appText(
                                                  title:
                                                      '${serviceData[index].subService?[i].type ?? ""}',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 8,
                                                      backgroundColor:
                                                          Colors.teal,
                                                      child: Icon(
                                                        Icons.star,
                                                        color: Colors.white,
                                                        size: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    appText(
                                                      title:
                                                          '${serviceData[index].rating}',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    appText(
                                                      title:
                                                          '₹${calculatePrice(double.parse(serviceData[index].subService?[i].price?.toString() ?? '0'), double.parse(provider.searchserviceList[index].subService?[i].offer?.toString() ?? '0'))}',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    appText(
                                                        title:
                                                            '₹${serviceData[index].subService?[i].price ?? ""}',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                        textDecoration:
                                                            TextDecoration
                                                                .lineThrough),
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
                                                    Icon(
                                                      Icons.lightbulb,
                                                      color: appColors.appBlue,
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    appText(
                                                      title:
                                                          '${serviceData[index].subService?[i].timeTaken ?? "0"} Min Services',
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
                                                    borderColor:
                                                        appColors.appColor,
                                                    color: Colors.white,
                                                    radius: 4,
                                                    onPressed: () {
                                                      showSlotBookingDialog(
                                                          context,
                                                          serviceData[index]
                                                                  .subService?[
                                                                      0]
                                                                  .id ??
                                                              0);
                                                    },
                                                    title: 'Book',
                                                    fontSize: 12,
                                                    textColor:
                                                        appColors.appColor,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  RangeValues values = const RangeValues(1, 1);
  RangeLabels labels = const RangeLabels('0', "50000");

  RangeValues rangeValue = const RangeValues(1, 1);
  RangeLabels rangeLabels = const RangeLabels('0', "40");

  RangeValues offerValue = const RangeValues(1, 1);
  RangeLabels offerLabels = const RangeLabels("0", "100");

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
                    /* Row(
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
                                )),
                            child: RangeSlider(
                                divisions: 7,
                                min: 1,
                                max: 50000,
                                values: values,
                                labels: labels,
                                onChanged: (value) {
                                  setState(() {
                                    values = value;
                                    labels = RangeLabels(
                                        value.start.toInt().toString(),
                                        value.end.toInt().toString());
                                  });
                                }),
                          ),
                        ),
                        appText(
                          title: '50000',
                          fontSize: 12,
                        ),
                      ],
                    ),*/
                    appText(
                      title: texts.price,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        /* appText(title: texts.minPrice,
                            fontSize: 12),*/
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 30,
                          width: 150,
                          //padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                          child: TextField(
                            controller: minPriceController,
                            decoration: InputDecoration(
                              labelText: 'Min Price',
                              labelStyle: TextStyle(
                                fontSize: 10,
                              ),
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            cursorHeight: 17,
                          ),
                        ),
                        Spacer(),
                        /*appText(title: texts.maxPrice,
                        fontSize: 12
                        ),*/
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 30,
                          width: 150,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: maxPriceController,
                            decoration: InputDecoration(
                              labelText: 'Max Price',
                              labelStyle: TextStyle(
                                fontSize: 10,
                              ),
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(),
                            ),
                            cursorHeight: 17,
                          ),
                        ),
                      ],
                    ),
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
                            )),
                            child: RangeSlider(
                                divisions: 5,
                                min: 1,
                                max: 40,
                                values: rangeValue,
                                labels: rangeLabels,
                                onChanged: (value) {
                                  setState(() {
                                    rangeValue = value;
                                    rangeLabels = RangeLabels(
                                        value.start.toInt().toString(),
                                        value.end.toInt().toString());
                                  });
                                }),
                          ),
                        ),
                        appText(
                          title: '40 KM',
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Row(
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
                            )),
                            child: RangeSlider(
                                divisions: 5,
                                min: 1,
                                max: 100,
                                values: offerValue,
                                labels: offerLabels,
                                onChanged: (value) {
                                  setState(() {
                                    offerValue = value;
                                    offerLabels = RangeLabels(
                                        value.start.toInt().toString(),
                                        value.end.toInt().toString());
                                  });
                                }),
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
                    ),
                    /*Divider(
                      color: Colors.grey,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: appText(
                            title: texts.nearest,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          value: isNearest,
                          activeColor: appColors.appColor,
                          onChanged: (value) {
                            setState(() {
                              isNearest = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 15,
                      endIndent: 15,
                    ),
                    // Row(
                    //   children: [
                    //     appText(
                    //         title: "Rating",
                    //         fontWeight: FontWeight.bold
                    //     ),
                    //     RatingBar.builder(
                    //       wrapAlignment: WrapAlignment.start,
                    //       itemSize: 30,
                    //       initialRating: 3,
                    //       minRating: 1,
                    //       direction: Axis.horizontal,
                    //       allowHalfRating: true,
                    //       itemCount: 4,
                    //       itemBuilder: (context, _) => const Icon(
                    //         Icons.star,
                    //         color: Colors.amber,
                    //       ),
                    //       onRatingUpdate: (value) {},
                    //     ),
                    //
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       height: 40,
                    //       width: 40,
                    //       child: FittedBox(
                    //         fit: BoxFit.fitWidth,
                    //         child: Checkbox(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius
                    //                   .circular(4),
                    //               side: const BorderSide(
                    //                   color: Colors
                    //                       .indigoAccent)),
                    //           side:  BorderSide(
                    //               color: appColors.appColor),
                    //           checkColor: Colors.white,
                    //           activeColor:
                    //           Colors.indigoAccent,
                    //           value: _isMenChecked,
                    //           onChanged: (bool? value) {
                    //             setState(() {
                    //               _isMenChecked = value ??
                    //                   false; // Update the value in _isChecked list
                    //             });
                    //           },
                    //
                    //         ),
                    //       ),
                    //     ),
                    //     appText(title: "Mens"),
                    //     SizedBox(
                    //       height: 40,
                    //       width: 40,
                    //       child: FittedBox(
                    //         fit: BoxFit.fitWidth,
                    //         child: Checkbox(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius
                    //                   .circular(4),
                    //               side: const BorderSide(
                    //                   color: Colors
                    //                       .indigoAccent)),
                    //           side:  BorderSide(
                    //               color: appColors.appColor),
                    //           checkColor: Colors.white,
                    //           activeColor:
                    //           Colors.indigoAccent,
                    //           value: _isWomenChecked,
                    //           onChanged: (bool? value) {
                    //             setState(() {
                    //               _isWomenChecked = value ??
                    //                   false; // Update the value in _isChecked list
                    //             });
                    //           },
                    //
                    //         ),
                    //       ),
                    //     ),
                    //     appText(title: "Womens"),
                    //     SizedBox(
                    //       height: 40,
                    //       width: 40,
                    //       child: FittedBox(
                    //         fit: BoxFit.fitWidth,
                    //         child: Checkbox(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius
                    //                   .circular(4),
                    //               side:  BorderSide(
                    //                   color: appColors.appColor)),
                    //           side:  BorderSide(
                    //               color: appColors.appColor),
                    //           checkColor: Colors.white,
                    //           activeColor:
                    //           Colors.indigoAccent,
                    //           value: _isKidsChecked,
                    //           onChanged: (bool? value) {
                    //             setState(() {
                    //               _isKidsChecked = value ??
                    //                   false; // Update the value in _isChecked list
                    //             });
                    //           },
                    //
                    //         ),
                    //       ),
                    //     ),
                    //     appText(title: "kids"),
                    //   ],
                    // ),

                      Row(
                      children: [
                        appText(title: "Booking Date"),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            _selectbookingDate(context);
                          },
                          child: Container(
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.yellow),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat('MMM d, yyyy')
                                        .format(_selectedDate),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_today,
                                  color: appColors.appColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 15,
                      endIndent: 15,
                    ),
                    Row(
                      children: [
                        appText(title: "Booking Time from"),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 80,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: appColors.appColor),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedTimeFrom,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTimeFrom = newValue;
                                      });
                                    },
                                    items: timeItems.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(value,style: TextStyle(fontSize: 10),),
                                        ),
                                      );
                                    }).toList(),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        appText(title: "To"),
                        SizedBox(width: 5),
                        SizedBox(
                          width: 80, // Specified width for the container
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: appColors.appColor),
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedTimeTo,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTimeTo = newValue;
                                      });
                                    },
                                    items: getSecondContainerItems().map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(value,style: const TextStyle(fontSize: 10),),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),*/
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
                              min: 1,
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
                                  ///PriceRangeValue
                                  /* values = RangeValues(1, 1);
                                  labels = RangeLabels('0', '0');*/
                                  minPriceController.text = "";
                                  maxPriceController.text = "";
                                  offerValue = RangeValues(1, 1);
                                  // offerLabels= RangeValues('1','1');
                                  rangeValue = RangeValues(1, 1);
                                  rangeLabels = RangeLabels('1', '1');
                                  ratingValue = RangeValues(1, 1);
                                  ratingLabels = RangeLabels('1', '1');
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
      } else if (provider.searchmembershipList.isEmpty) {
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
        itemCount: provider.searchmembershipList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                context: context,
                to: MembershipDetail(
                  data: provider.searchmembershipList[index],
                  lang: widget.lang,
                  lat: widget.lat,
                  memberid: provider.membershipList[index].id,
                ),
              );
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.yellow),
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
                                title: provider.searchmembershipList[index]
                                        .membershipName ??
                                    '',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title: provider.searchmembershipList[index]
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
                                        '${calculatePrice(provider.searchmembershipList[index].price, provider.searchmembershipList[index].offer)}',
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
                                  placeholder:
                                      'assets/images/placeholder.png', // Path to placeholder image
                                  image: provider.searchmembershipList[index]
                                          .image?.first ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
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
                    title: '${provider.searchmembershipList[index].offer}% OFF',
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
                        initialRating: provider.searchmembershipList[index]
                                .service?.subService?.rating ??
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
                          Icon(
                            Icons.location_on,
                            color: appColors.appGreen,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          appText(
                            title:
                                '20 Min • ${(Geolocator.distanceBetween(widget.lat ?? 0, widget.lang ?? 0, provider.searchmembershipList[index].shop!.lat!, provider.searchmembershipList[index].shop!.lng!) / 1000).toStringAsFixed(2)} KM',
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
      } else if (provider.searchpackageList.isEmpty) {
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
        itemCount: provider.searchpackageList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              slideTransition(
                  context: context,
                  to: PackageDetail(
                    data: provider.searchpackageList[index],
                    lat: widget.lat,
                    lang: widget.lang,
                    packageid: provider.searchpackageList[index].id,
                  ));
            },
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.yellow),
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
                                title: provider
                                        .searchpackageList[index].packageName ??
                                    '',
                                fontSize: 20,
                                // color: appColors.appGray,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              appText(
                                title: _getServiceName(
                                    provider.searchpackageList[index].service ??
                                        []),
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
                                        '${calculatePrice(provider.searchpackageList[index].price, provider.searchpackageList[index].discount)}',
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
                                  placeholder:
                                      'assets/images/placeholder.png', // Path to placeholder image
                                  image: provider.searchpackageList[index].image
                                          ?.first ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.network(
                                        "${provider.searchpackageList[index].image}");
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
                    title: '${provider.searchpackageList[index].discount}% OFF',
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
                        initialRating: provider.searchpackageList[index]
                                .service?[0].subServices?[0].rating ??
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
                          Icon(
                            Icons.location_on,
                            color: appColors.appGreen,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          appText(
                            title:
                                '20 Min • ${(Geolocator.distanceBetween(widget.lat ?? 0, widget.lang ?? 0, provider.searchpackageList[index].shop!.lat!, provider.searchpackageList[index].shop!.lng!) / 1000).toStringAsFixed(2)} KM',
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
}
