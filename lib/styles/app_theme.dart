import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: appColors.appWhite,
    fontFamily: 'SF Pro',
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appColors.appWhite,
      surfaceTintColor: appColors.appWhite,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: appColors.appWhite,
      surfaceTintColor: appColors.appWhite,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: appColors.appBlack,
      ),
      bodyMedium: TextStyle(
        color: appColors.appBlack,
      ),
      bodySmall: TextStyle(
        color: appColors.appBlack,
      ),
      titleMedium: TextStyle(
        color: appColors.appBlack,
      ),
      titleSmall: TextStyle(
        color: appColors.appBlack,
      ),
      titleLarge: TextStyle(
        color: appColors.appBlack,
      ),
    ),
    cardTheme: CardTheme(
      color: appColors.appWhite,
      surfaceTintColor: appColors.appWhite,
    ),
    indicatorColor: appColors.appBlack,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: appColors.appBlack,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.appBlack,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: appColors.appGray,
      ),
      labelStyle: TextStyle(
        color: appColors.appGray,
      ),
      floatingLabelStyle: TextStyle(
        color: appColors.appBlack,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: appColors.appBlack,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.appBlack),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.appRed),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: appColors.appRed),
      ),
    ),
  );
}
