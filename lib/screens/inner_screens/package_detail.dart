import 'package:flutter/material.dart';
import 'package:salon_customer_app/constants/texts.dart';
import 'package:salon_customer_app/models/dashboard_models/packages_model.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_bar.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';
import 'package:salon_customer_app/utils/validator.dart';

import '../../utils/slot.dart';

class PackageDetail extends StatefulWidget {
  final PackagesModel data;
  const PackageDetail({super.key, required this.data});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: widget.data.service!.length,
                itemBuilder: (context, index) {
                  return Card(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: index == 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                '${widget.data.packageName} ₹${widget.data.price}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
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
                                        ],
                                      ),
                                    ),
                                    appText(
                                      title: widget.data.service?[index].name ??
                                          '',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: widget.data.service?[index]
                                          .subService?.length,
                                      itemBuilder: (context, i) {
                                        return appText(
                                          title: widget.data.service?[index]
                                                  .subService?[i].type ??
                                              '',
                                          fontSize: 14,
                                          color: appColors.appGray,
                                          fontWeight: FontWeight.bold,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: AppButton(
                                  onPressed: () {
                                   showSlotBookingDialog(context);
                                  },
                                  title: texts.bookSlot,
                                  radius: 8,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
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
                                    title: '₹${widget.data.price}',
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
                                      widget.data.price,
                                      widget.data.discount,
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
                                        '₹${(double.parse(widget.data.price?.toString() ?? '0') - double.parse(
                                              calculatePrice(
                                                widget.data.price,
                                                widget.data.discount,
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
                                'Time Taken ${widget.data.service?[index].subService?.first.timeTaken} Min',
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
                              widget.data.details ?? '',
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
                              widget.data.termAndcondition ?? '',
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
                  );
                },
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
