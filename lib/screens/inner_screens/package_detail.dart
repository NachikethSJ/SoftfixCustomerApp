import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/validator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/slot.dart';
import '../../view_models/services_details_provider.dart';

class PackageDetail extends StatefulWidget {
  final PackagesModel data;
  final dynamic lat;
  final dynamic lang;
  final dynamic packageid;
  const PackageDetail(
      {super.key,
      required this.data,
      required this.lat,
      required this.lang,
      required this.packageid});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesDetailsProvider>(
      builder: (context, provider, child) {
      if(provider.showLoader){
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
          appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  )),
              title: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: appColors.appColor,
                  ),
                  Text(
                    "${provider.showPackageDetails.shopName} ",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
             ),
          body: Consumer<ServicesDetailsProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                               provider.showPackageDetails.imageUrl?[0]??'',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                await openMap(
                                    widget.lat.toDouble(), widget.lang.toDouble());
                              },
                              child: Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: Colors.teal.shade800,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.directions,
                                      color: appColors.appColor,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          await openMap(widget.lat.toDouble(),
                                              widget.lang.toDouble());
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
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: provider.showPackageDetails.serviceIdData?.length??0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 4,
                              // shadowColor: appColors.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side:
                                    BorderSide(color: appColors.appColor, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  height: 120,
                                                  width: 130,
                                                  child: Image.network(
                                                    provider.showPackageDetails.imageUrl?[0],
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
                                                Positioned(
                                                  left: 0,
                                                  bottom: 0,
                                                  child: Container(
                                                    height: 25,
                                                    width: 70,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.blue),
                                                    child: Center(
                                                        child: Text(
                                                      "${provider.showPackageDetails.package?.discount}%Off",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
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
                                              appText(
                                                title:
                                                '${provider.showPackageDetails.serviceIdData?[index].serviceName?.name}',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              appText(
                                                title: provider.showPackageDetails.serviceIdData?[index].subserviceName?[0].type??"",
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
                                                    title:
                                                        '${provider.showPackageDetails.serviceIdData?[index].subserviceName?[0].timeTaken} .Min',
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
                                                    title: '₹${calculatePrice(
                                                      provider.showPackageDetails.serviceIdData?[index].subserviceName?[0].price,
                                                      provider.showPackageDetails.serviceIdData?[index].subserviceName?[0].offer,
                                                      /*widget.data.price,
                                                      widget.data.discount,*/
                                                    )}',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  appText(
                                                      title:
                                                          '₹${provider.showPackageDetails.serviceIdData?[index].subserviceName?[0].price}',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      textDecoration: TextDecoration
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
                                                  Consumer<ServicesDetailsProvider>(
                                                  builder: (context, provider, child) {
                                                  return RatingBar.builder(
                                                    wrapAlignment:
                                                        WrapAlignment.start,
                                                    itemSize: 14,
                                                    initialRating: provider.showPackageDetails.serviceIdData?[index].subserviceName?[0].rating??0,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (value) {},
                                                  );
  },
),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),

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
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: AppButton(
                          onPressed: () {

                          },
                          title: texts.bookSlotLater,
                          radius: 8,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  calculatePrice(dynamic price, dynamic discount) {
    double p = double.tryParse(price.toString()) ?? 0;
    double d = double.tryParse(discount.toString()) ?? 0;
    return (p * (100 - d) / 100).toStringAsFixed(0);
  }

  void showSlotBookingDialog(BuildContext context,int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlotBookingDialog(subServiceId: id,);
      },
    );
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _getDetail() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider =
            Provider.of<ServicesDetailsProvider>(context, listen: false);
        var body = {"packageId": widget.packageid};
        provider.packageDetail(
          context: context,
          body: body,
        );
      },
    );
  }
}
