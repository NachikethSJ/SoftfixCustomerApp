import 'package:flutter/material.dart';

import '../../constants/texts.dart';
import '../../models/dashboard_models/near_by_shop_model.dart';
import '../../styles/app_colors.dart';
import '../../utils/app_bar.dart';
import '../../utils/app_button.dart';
import '../../utils/app_text.dart';
import '../../utils/slot.dart';
import '../../utils/validator.dart';
class NearSubServicesDetail extends StatefulWidget {
  final NearByShopModel data;

  const NearSubServicesDetail({super.key, required this.data});

  @override
  State<NearSubServicesDetail> createState() => _NearSubServicesDetailState();
}

class _NearSubServicesDetailState extends State<NearSubServicesDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("List === >${widget.data.name}");
  }

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
                itemCount: widget.data.services?.length ?? 4,
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
                                            title: '${widget.data.name}',
                                            color: appColors.appGray,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          appText(
                                            title:
                                            'Package Name & price',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          appText(
                                            title:
                                            'From time',
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
                                      title: '${widget.data.services?[index].name}',
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
                                      itemCount: 1,
                                      itemBuilder: (context, i) {
                                        return appText(
                                          title: '${widget.data.services?[index].subService?[i].type}',
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
                                    showSlotBookingDialog(context,widget.data.services?[index].subService?[0].id);
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
                                    title: '₹500',
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
                                    title: '₹800',
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
                                    '₹900',
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
                            'Time Taken  Min',
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
                              'Details',
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
                              "Terms & Condition",
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
                          const SizedBox(
                            height: 100,
                            width: 100,
                            child: CircleAvatar()
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
  void showSlotBookingDialog(BuildContext context,int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  SlotBookingDialog(subServiceId: id,);
      },
    );
  }
}
