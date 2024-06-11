import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/membership_model.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/slot.dart';
import '../../view_models/services_details_provider.dart';

class MembershipDetail extends StatefulWidget {
  final MembershipModel data;
  final dynamic lat;
  final dynamic lang;
  final int memberid;
  const MembershipDetail(
      {super.key,
      required this.data,
      required this.lat,
      required this.lang,
      required this.memberid});

  @override
  State<MembershipDetail> createState() => _MembershipDetailState();
}

class _MembershipDetailState extends State<MembershipDetail> {
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
                    '${provider.showMemberShipDetails.shopName}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.search,
                    color: appColors.appColor,
                  ),
                )
              ]),
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
                              borderRadius: BorderRadius.circular(4),
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                'assets/images/placeholder.png', // Path to placeholder image
                                image:  provider.showMemberShipDetails.shopImageUrl?[0]??'',
                                fit: BoxFit.cover,
                                width: 90,
                                height: 90,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  // Custom image error builder
                                  return Image.network(
                                      provider.showMemberShipDetails.shopImageUrl?[0]??''
                                  );
                                },
                              )
                              /*Image.network(
                                provider.showMemberShipDetails.shopImageUrl?[0]??'',
                                fit: BoxFit.fill,
                              ),*/
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
                                              widget.lang.toDouble());
                                        },
                                        child:  Text(
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
                      ListView.separated(
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 4,
                              // shadowColor: appColors.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
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
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                    'assets/images/placeholder.png', // Path to placeholder image
                                                    image:   provider.showMemberShipDetails.imageUrl?[0],
                                                    fit: BoxFit.cover,
                                                    width: 90,
                                                    height: 90,
                                                    imageErrorBuilder:
                                                        (context, error, stackTrace) {
                                                      // Custom image error builder
                                                      return Image.network(
                                                          provider.showMemberShipDetails.imageUrl?[0]
                                                      );
                                                    },
                                                  ),
                                                ),
                                                provider.showMemberShipDetails.membership?.offer !=null?
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
                                                          "${provider.showMemberShipDetails.membership?.offer??""}%Off",
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        )),
                                                  ),
                                                )
                                                :const SizedBox(),
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
                                                provider.showMemberShipDetails.serviceDetail?.name??"",
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              appText(
                                                title: provider.showMemberShipDetails.subServiceDetail?.type??"",
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
                                                        '${provider.showMemberShipDetails.subServiceDetail?.timeTaken??""}. Min',
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
                                                      provider.showMemberShipDetails.subServiceDetail?.price,
                                                      provider.showMemberShipDetails.subServiceDetail?.offer,
                                                    )}',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  appText(
                                                      title:
                                                      '₹${provider.showMemberShipDetails.subServiceDetail?.price}',
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
                                                  RatingBar.builder(
                                                    wrapAlignment:
                                                    WrapAlignment.start,
                                                    itemSize: 14,
                                                    initialRating: provider.subServiceDetail.subService?.rating??0,
                                                    minRating: 1,
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
                                                  // GestureDetector(
                                                  //   onTap: (){
                                                  //     showSlotBookingDialog(context);
                                                  //   },
                                                  //   child: SizedBox(
                                                  //       width: 60,
                                                  //       height: 30,
                                                  //       child: Container(
                                                  //         decoration: BoxDecoration(
                                                  //             borderRadius: BorderRadius.circular(5),
                                                  //             border:Border.all( color: appColors.appColor)
                                                  //         ),
                                                  //         child:  Center(child: Text("Book",style:TextStyle(color:appColors.appColor))),
                                                  //       )
                                                  //
                                                  //     // AppButton(
                                                  //     //   radius: 8,
                                                  //     //   onPressed: () {
                                                  //     //     showSlotBookingDialog(context);
                                                  //     //   },
                                                  //     //   title: '+ Book',
                                                  //     //   fontSize: 12,
                                                  //     // ),
                                                  //   ),
                                                  // )
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
                      // ListView.separated(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   separatorBuilder: (context, index) {
                      //     return const SizedBox(
                      //       height: 10,
                      //     );
                      //   },
                      //   itemCount: widget.data.service!.length,
                      //   itemBuilder: (context, index) {
                      //     return Card(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //         side: BorderSide(
                      //           color: appColors.appColor,
                      //         ),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(12),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Expanded(
                      //                   child: Column(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Visibility(
                      //                         visible: index == 0,
                      //                         child: Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           children: [
                      //                             appText(
                      //                               title: widget.data.shop?.name ?? '',
                      //                               color: appColors.appGray,
                      //                               fontSize: 16,
                      //                               fontWeight: FontWeight.bold,
                      //                             ),
                      //                             const SizedBox(
                      //                               height: 4,
                      //                             ),
                      //                             appText(
                      //                               title:
                      //                                   '${widget.data.packageName} ₹${widget.data.price}',
                      //                               fontSize: 14,
                      //                               fontWeight: FontWeight.bold,
                      //                             ),
                      //                             const SizedBox(
                      //                               width: 10,
                      //                             ),
                      //                             appText(
                      //                               title:
                      //                                   'From ${formatDateTime(widget.data.startDate ?? '', 'dd-MM-yyyy')} To ${formatDateTime(widget.data.endDate ?? '', 'dd-MM-yyyy')}',
                      //                               color: appColors.appGray,
                      //                               fontWeight: FontWeight.bold,
                      //                             ),
                      //                             const SizedBox(
                      //                               height: 6,
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                       appText(
                      //                         title: widget.data.service?[index].name ??
                      //                             '',
                      //                         fontSize: 14,
                      //                         fontWeight: FontWeight.bold,
                      //                       ),
                      //                       const SizedBox(
                      //                         height: 2,
                      //                       ),
                      //                       ListView.builder(
                      //                         physics:
                      //                             const NeverScrollableScrollPhysics(),
                      //                         shrinkWrap: true,
                      //                         itemCount: widget.data.service?[index]
                      //                             .subService?.length,
                      //                         itemBuilder: (context, i) {
                      //                           return appText(
                      //                             title: widget.data.service?[index]
                      //                                     .subService?[i].type ??
                      //                                 '',
                      //                             fontSize: 14,
                      //                             color: appColors.appGray,
                      //                             fontWeight: FontWeight.bold,
                      //                           );
                      //                         },
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 100,
                      //                   height: 40,
                      //                   child: AppButton(
                      //                     onPressed: () {
                      //                      showSlotBookingDialog(context);
                      //                     },
                      //                     title: texts.bookSlot,
                      //                     radius: 8,
                      //                     fontWeight: FontWeight.normal,
                      //                     fontSize: 12,
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 6,
                      //             ),
                      //             const SizedBox(
                      //               height: 6,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     appText(
                      //                       title: texts.actualPrice,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                     appText(
                      //                       title: '₹${widget.data.price}',
                      //                       fontWeight: FontWeight.bold,
                      //                       color: appColors.appGray,
                      //                     )
                      //                   ],
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 20,
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     appText(
                      //                       title: texts.offeredPrice,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                     appText(
                      //                       title: '₹${calculatePrice(
                      //                         widget.data.price,
                      //                         widget.data.discount,
                      //                       )}',
                      //                       fontWeight: FontWeight.bold,
                      //                       color: appColors.appGray,
                      //                     )
                      //                   ],
                      //                 ),
                      //                 const SizedBox(
                      //                   width: 20,
                      //                 ),
                      //                 Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     appText(
                      //                       title: texts.savedPrice,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                     appText(
                      //                       title:
                      //                           '₹${(double.parse(widget.data.price?.toString() ?? '0') - double.parse(
                      //                                 calculatePrice(
                      //                                   widget.data.price,
                      //                                   widget.data.discount,
                      //                                 ),
                      //                               )).toStringAsFixed(0)}',
                      //                       fontWeight: FontWeight.bold,
                      //                       color: appColors.appGray,
                      //                     )
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //             const SizedBox(
                      //               height: 12,
                      //             ),
                      //             appText(
                      //               title:
                      //                   'Time Taken ${widget.data.service?[index].subService?.first.timeTaken} Min',
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w500,
                      //               color: appColors.appGray,
                      //             ),
                      //             const SizedBox(
                      //               height: 6,
                      //             ),
                      //             appText(
                      //               title: truncateWithEllipsis(
                      //                 30,
                      //                 widget.data.details ?? '',
                      //               ),
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w500,
                      //               color: appColors.appGray,
                      //             ),
                      //             const SizedBox(
                      //               height: 6,
                      //             ),
                      //             appText(
                      //               title: '${texts.terms}: ${truncateWithEllipsis(
                      //                 30,
                      //                 widget.data.termAndcondition ?? '',
                      //               )}',
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w500,
                      //               color: appColors.appGray,
                      //             ),
                      //             const SizedBox(
                      //               height: 10,
                      //             ),
                      //             appText(
                      //               title: texts.imageConfiguration,
                      //               color: appColors.appBlue,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //             const SizedBox(
                      //               height: 6,
                      //             ),
                      //             SizedBox(
                      //               height: 100,
                      //               width: 100,
                      //               child: Image.network(
                      //                 widget.data.image?.first ?? '',
                      //                 fit: BoxFit.fill,
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: AppButton(
                          onPressed: () {},
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
          /* appBar: AppBar(
              leading: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back,)),
              title: Row(
                children: [
                  Icon(Icons.location_on,color: appColors.appColor,),
                  Text("${widget.data.shop?.name} ",style: TextStyle(fontSize: 14),),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(Icons.search,color: appColors.appColor,),
                )
              ]
          ),

          body: Padding(
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
                          widget.data.image?.first ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: ()async {
                           await openMap(widget.lat.toDouble(), widget.lang.toDouble());
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
                                     openMap(widget.lat.toDouble(),widget.lang.toDouble());
                                  },
                                  child: const Text("Get Direction",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: appColors.appColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  appText(
                                    title: widget.data.shop?.name ?? '',
                                    color: appColors.appGray,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  appText(
                                    title:
                                        '${widget.data.membershipName} ₹${widget.data.price}',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // SizedBox(
                            //   width: 120,
                            //   height: 40,
                            //   child: AppButton(
                            //     onPressed: () {
                            //       showSlotBookingDialog(context);
                            //     },
                            //     title: texts.bookSlot,
                            //     radius: 8,
                            //     fontSize: 14,
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        appText(
                          title:
                              'From ${formatDateTime(widget.data.startDate ?? '', 'dd-MM-yyyy')} To ${formatDateTime(widget.data.endDate ?? '', 'dd-MM-yyyy')}',
                          color: appColors.appGray,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        appText(
                          title: widget.data.service?.name ?? '',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        appText(
                          title: widget.data.service?.subService?.type ?? '',
                          fontSize: 14,
                          color: appColors.appGray,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appText(
                                  title: texts.actualPrice,
                                  fontWeight: FontWeight.bold,
                                ),
                                appText(
                                  title:
                                      '₹${widget.data.service?.subService?.price}',
                                  fontWeight: FontWeight.bold,
                                  color: appColors.appGray,
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appText(
                                  title: texts.offeredPrice,
                                  fontWeight: FontWeight.bold,
                                ),
                                appText(
                                  title: '₹${calculatePrice(
                                    widget.data.service?.subService?.price,
                                    widget.data.service?.subService?.offer,
                                  )}',
                                  fontWeight: FontWeight.bold,
                                  color: appColors.appGray,
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appText(
                                  title: texts.savedPrice,
                                  fontWeight: FontWeight.bold,
                                ),
                                appText(
                                  title:
                                      '₹${(double.parse(widget.data.service?.subService?.price?.toString() ?? '0') - double.parse(
                                            calculatePrice(
                                              widget
                                                  .data.service?.subService?.price,
                                              widget
                                                  .data.service?.subService?.offer,
                                            ),
                                          )).toStringAsFixed(0)}',
                                  fontWeight: FontWeight.bold,
                                  color: appColors.appGray,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        appText(
                          title:
                              'Time Taken ${widget.data.service?.subService?.timeTaken} Min',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appColors.appGray,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        appText(
                          title: truncateWithEllipsis(
                            30,
                            widget.data.service?.subService?.details ?? '',
                          ),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: appColors.appGray,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        appText(
                          title: '${texts.terms}: ${truncateWithEllipsis(
                            30,
                            widget.data.service?.subService?.termAndcondition ?? '',
                          )}',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: appColors.appGray,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        appText(
                          title: texts.imageConfiguration,
                          color: appColors.appBlue,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            widget.data.image?.first ?? '',
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: AppButton(
                    onPressed: () {},
                    title: texts.bookSlotLater,
                    radius: 8,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),*/
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
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
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
        var body = {"membershipId": widget.memberid};
        provider.memberShipDetail(
          context: context,
          body: body,
        );
      },
    );
  }
}
