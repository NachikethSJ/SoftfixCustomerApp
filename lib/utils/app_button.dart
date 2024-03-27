import '../styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool? isDisabled;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? widget;
  final GlobalKey? buttonKey;
  final double? radius;
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.textColor,
      this.borderColor,
      this.fontSize = 16,
      this.widget,
      this.fontWeight = FontWeight.bold,
      this.isDisabled = false,
      this.isLoading = false,
      this.buttonKey,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        key: buttonKey,
        width: MediaQuery.of(context).size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          color: appColors.appColor,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          borderRadius: BorderRadius.circular(radius ?? 50),
        ),
        child: ElevatedButton(
          onPressed: isLoading == true || isDisabled == true ? null : onPressed,
          style: ButtonStyle(
              surfaceTintColor: MaterialStatePropertyAll(
                appColors.appColor,
              ),
              backgroundColor: MaterialStatePropertyAll(
                color ?? appColors.appColor,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 50),
                ),
              )),
          child: Center(
              child: isLoading == true
                  ? CircularProgressIndicator(
                      color: appColors.appBlack,
                    )
                  : title.isNotEmpty
                      ? Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: fontSize,
                              color: isDisabled == true
                                  ? appColors.appGray
                                  : textColor ?? appColors.appBlack,
                              fontWeight: fontWeight),
                        )
                      : widget),
        ),
      ),
    );
  }
}
