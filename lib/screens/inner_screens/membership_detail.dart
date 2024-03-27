import 'package:flutter/material.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/membership_model.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/validator.dart';

import '../../utils/slot.dart';

class MembershipDetail extends StatefulWidget {
  final MembershipModel data;
  const MembershipDetail({super.key, required this.data});

  @override
  State<MembershipDetail> createState() => _MembershipDetailState();
}

class _MembershipDetailState extends State<MembershipDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        SizedBox(
                          width: 120,
                          height: 40,
                          child: AppButton(
                            onPressed: () {
                              showSlotBookingDialog(context);
                            },
                            title: texts.bookSlot,
                            radius: 8,
                            fontSize: 14,
                          ),
                        )
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
      ),
    );
  }

  calculatePrice(dynamic price, dynamic discount) {
    double p = double.tryParse(price.toString()) ?? 0;
    double d = double.tryParse(discount.toString()) ?? 0;
    return (p * (100 - d) / 100).toStringAsFixed(0);
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
