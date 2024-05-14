import 'package:flutter/material.dart';

Text appText(
    {required String title,
    double fontSize = 12,
      FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    TextAlign? textAlign,
    TextDecoration? textDecoration,
    TextOverflow? textOverflow}) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: " ",
      fontWeight: fontWeight,
      overflow: textOverflow,
      decoration: textDecoration,
    ),
  );
}
