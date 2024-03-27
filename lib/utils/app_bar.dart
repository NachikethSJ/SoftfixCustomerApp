import 'package:flutter/material.dart';
import 'package:salon_customer_app/styles/app_colors.dart';
import 'package:salon_customer_app/utils/app_text.dart';

AppBar appBar(BuildContext context,
    {String? title,
    List<Widget>? actions,
    Widget? leading,
    Color? bgColor,
    double? elevation}) {
  return AppBar(
    backgroundColor: bgColor ?? appColors.appWhite,
    elevation: elevation ?? 0,
    surfaceTintColor: bgColor ?? appColors.appWhite,
    title: appText(title: title ?? '', color: appColors.appBlack, fontSize: 16),
    centerTitle: true,
    actions: actions,
    leading: leading ??
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: appColors.appBlack,
            )),
  );
}
