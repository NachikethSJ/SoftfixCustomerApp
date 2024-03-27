// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon_customer_app/styles/app_colors.dart';

var fToast;
showToast(String input,
    {ToastGravity? alignment = ToastGravity.BOTTOM,
    bool isSuccess = false,
    int? time,
    Color? color}) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: isSuccess ? appColors.appGreen : color ?? appColors.appRed,
    ),
    child: Text(
      input,
      maxLines: 10,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'OpenSans',
        color: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 14,
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: alignment,
    toastDuration: Duration(seconds: time ?? 3),
  );
}
