import 'package:flutter/material.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_button.dart';
import 'package:salon_customer_app/utils/app_text.dart';

alert({
  required BuildContext context,
  required String heading,
  String? subTitle,
  required String denyTitle,
  required String acceptTitle,
  void Function()? onPressed,
  required double height,
}) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: appColors.appWhite,
          backgroundColor: appColors.appWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    crossAxisAlignment: subTitle!.isNotEmpty
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.center,
                    children: [
                      Text(
                        heading,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Visibility(
                        visible: subTitle.isNotEmpty,
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AppButton(
                              title: '',
                              widget: appText(
                                title: acceptTitle,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appColors.appBlack,
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                                onPressed!();
                              },
                              color: appColors.appWhite,
                              borderColor: appColors.appBlack,
                              textColor: appColors.appBlack,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppButton(
                              title: '',
                              widget: appText(
                                title: denyTitle,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appColors.appWhite,
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear,
                      size: 16,
                      color: appColors.appBlack,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
