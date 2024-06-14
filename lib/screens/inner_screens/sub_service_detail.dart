import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_service_model.dart';
import 'package:salon_customer_app/screens/inner_screens/cart/cart_screen.dart';
import 'package:salon_customer_app/screens/inner_screens/dashboard.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/view_models/cart_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../cache_manager/cache_manager.dart';
import '../../utils/slot.dart';
import '../../utils/validate_connectivity.dart';
import '../../view_models/services_details_provider.dart';
import '../common_screens/bottom_navigation.dart';

class SubServiceDetail extends StatefulWidget {
  final dynamic lat;
  final dynamic lng;
  final String subServiceid;
  const SubServiceDetail({
    super.key,
    required this.lat,
    required this.lng,
    required this.subServiceid,
  });

  @override
  State<StatefulWidget> createState() => SubServiceDetailState();
}

class SubServiceDetailState extends State<SubServiceDetail> with CacheManager{
  int count = 1;
  bool isbottom = false;
  double latitude = 28.7041;
  double longitude = 77.1025;
  Future getLatLongitude() async {
    var data = await getLatLng();
    setState(() {
      latitude = double.tryParse(data.first) ?? 0;
      longitude = double.tryParse(data.last) ?? 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatLongitude();
    _getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesDetailsProvider>(
      builder: (context, provider, child) {
        if (provider.showLoader) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(provider.subServiceDetail.shopDetail?.name??'',
                      style: const TextStyle(fontSize: 14)
                  ),
                  const Spacer(),
                  Icon(Icons.location_on,
                    color: appColors.appColor,
                  ),
                  Text('30 Min • ${(Geolocator.distanceBetween(latitude, longitude, provider.subServiceDetail.shopDetail?.lat!, provider.subServiceDetail.shopDetail?.lng!) / 1000).toStringAsFixed(2)} Km',
                      style: const TextStyle(fontSize: 14)
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 5),
                child: Consumer<ServicesDetailsProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                  'assets/images/placeholder.png', // Path to placeholder image
                                  image:  provider.subServiceDetail.imageUrl?.first ??
                                      '',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    // Custom image error builder
                                    return Image.network(
                                        provider.subServiceDetail.imageUrl?.first ??
                                            ''
                                    );
                                  },
                                )
                              ),
                            ),
                            provider.subServiceDetail.subService?.offer !=null?
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                height: 25,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                    child: appText(
                                  title:
                                      '${provider.subServiceDetail.subService?.offer}% OFF',
                                  color: appColors.appWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                )),
                              ),
                            )
                            :const SizedBox(),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  await openMap(
                                      widget.lat.toDouble(), widget.lng.toDouble());
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
                                          onTap: () async {
                                            await openMap(widget.lat.toDouble(),
                                                widget.lng.toDouble());
                                          },
                                          child: Text(
                                            texts.getDirection,
                                            style: const TextStyle(
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
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                                title: provider
                                        .subServiceDetail.subService?.type ??
                                    '',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7)
                            ),
                            Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: appColors.appColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      '${provider.subServiceDetail.subService?.rating??"2"}.0',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            appText(
                              title:
                                  '₹${calculatePrice(double.parse(provider.subServiceDetail.subService?.price?.toString() ?? '0'), double.parse(provider.subServiceDetail.subService?.offer?.toString() ?? '0'))}',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.7)
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            appText(
                              title:
                                  '₹${provider.subServiceDetail.subService?.price}',
                              color: appColors.appGray,
                              textDecoration: TextDecoration.lineThrough,
                              fontSize: 16,
                            ),
                          ],
                        ),
                        appText(
                          title:
                              '${provider.subServiceDetail.subService?.timeTaken?.toString()} Min Service',
                          fontSize: 15,
                        ),
                        dataCard(
                          texts.detail,
                          provider.subServiceDetail.subService?.details ?? '',
                        ),
                        dataCard(
                          texts.terms,
                          provider.subServiceDetail.subService
                                  ?.termAndcondition ??
                              '',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            texts.reviews,
                            style: TextStyle(
                                color: appColors.appColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: RichText(
                            text: const TextSpan(
                              text: 'John :: ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Good Service!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () {
                    showSlotBookingDialog(
                        context,
                        provider.subServiceDetail.subService?.id.toString() ??
                            '');
                    //item Add to cart
                    //  addCartService();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: appColors.appColor)),
                    child: Center(
                      child: appText(
                        title: texts.book,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: appColors.appColor,
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  dataCard(String title, String detail) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText(
                  title: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: appColors.appColor),
              const SizedBox(
                height: 2,
              ),
              appText(
                title: detail,
                fontSize: 16,
                color: appColors.appGray,
              )
            ],
          ),
        ),
      ),
    );
  }

  calculatePrice(double price, double discount) {
    return (price * (100 - discount) / 100).toStringAsFixed(0);
  }

  addCartService() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<CartProvider>(context, listen: false);
          var body = {
            "subServiceId": widget.subServiceid,
            "quantity": 1,
          };
          provider
              .addCart(
            context: context,
            body: body,
          )
              .then((value) {
            if (value) {
              Navigator.pop(context);
            }
          });
        });
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

  _getDetail() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var provider =
            Provider.of<ServicesDetailsProvider>(context, listen: false);
        var body = {"id": widget.subServiceid};
        provider.subServiceDetails(
          context: context,
          body: body,
        );
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


}
