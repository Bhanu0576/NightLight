import 'package:demo1212/appStyle/app_color.dart';
import 'package:flutter/material.dart';
// import 'package:night_light/appStyle/app_color.dart';
// import 'package:night_light/appStyle/app_dimension.dart';
import 'app_dimension.dart';
import 'app_fonts.dart';


abstract class AppThemeStyles {
  static TextStyle interLightBlueW300 = TextStyle(
    fontFamily: AppFonts.appInterFontFamily,
    fontSize: AppDimensions.thirteen,
    color: AppColors.colorBlueDark,
    fontWeight: FontWeight.w300,
  );
  static TextStyle blackW300 = TextStyle(
    fontFamily: AppFonts.appInterFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w300,
  );
  static TextStyle blueW500 = TextStyle(
    fontFamily: AppFonts.appInterFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.colorBlueDark,
    fontWeight: FontWeight.w500,
  );
  static TextStyle white500 = TextStyle(
    fontFamily: AppFonts.appInterFontFamily,
    fontSize: AppDimensions.sixTeen,
    color: AppColors.colorWhite,
    fontWeight: FontWeight.w500,
  );
  static TextStyle whiteZrnicW400 = TextStyle(
    fontFamily: AppFonts.appInterFontFamily,
    fontSize: AppDimensions.eighteen,
    color: AppColors.colorWhite,
    fontWeight: FontWeight.w400,
  );

  static TextStyle zrnicLightBlueW400 = TextStyle(
    fontSize: AppDimensions.twentySix,
    color: AppColors.colorBlueLight,
    fontWeight: FontWeight.w400,
  );
  static TextStyle skyLight400 = TextStyle(
    color: AppColors.colorSkyLight,
    fontFamily: AppFonts.appInterFontFamily,
    fontSize: AppDimensions.fifTeen,
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteLight = TextStyle(
    color: AppColors.colorWhite,
    fontSize: AppDimensions.twenty,

  );
}
