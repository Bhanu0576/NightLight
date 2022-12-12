

import 'package:demo1212/model/multi_model_colors.dart';
import 'package:demo1212/pages/HomePage/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'app_pages.dart';

abstract class AppRouteMaps {
  static void gotoSplash() {
    Get.offNamed(
      Routes.splash,
    );
  }
  static void gotoHomePage() {
    Get.offNamed(
      Routes.homePage,
    );
  }

  static Future<dynamic> gotoSettingPage() async {
   return await Get.toNamed(
      Routes.settingScreen,
    );
  }
  static Future<dynamic> gotoShowCaseMain() async {
    return await Get.toNamed(
       Routes.showCaseMain
    );
  }


  static void gotoColorPick(Color color, String audio, int minutes) async {
    double bright = await ScreenBrightness().current;
    Get.toNamed(
      Routes.colorPickPage,
      arguments: [{
        "color":color,
        "audio":audio,
        "min": minutes,
      }]
    )?.then((value) {
      ScreenBrightness().setScreenBrightness(bright);
    });
  }
  static Future<void> gotoColorPick1(List<MultipleColors> multipleColors, String audio, int minutes, int seconds) async {
    double bright = await ScreenBrightness().current;
    Get.toNamed(
        Routes.colorPickPage,
        arguments: [{
          "multipleColors": multipleColors,
          "audio": audio,
          "min": minutes,
          "sec": seconds,
        },]
    )!.then((value) {
      ScreenBrightness().setScreenBrightness(bright);
    });
  }

  static Future<void> goToLavaPage(Color color, String screenName  ,String screenType , String screenValue, String audio, int minutes,) async {
    double bright = await ScreenBrightness().current;
    Get.toNamed(
        Routes.lava,
        arguments: [{
          "color": color,
          "ScreenName": screenName,
          "ScreenType": screenType,
          "ScreenValue": screenValue,
          "audio":audio,
          "min": minutes,
        }]
    )!.then((value){
      ScreenBrightness().setScreenBrightness(bright);
    });
  }

  static void goToHtmlPageView()
  {
    Get.toNamed(
      Routes.htmlScreenMain,
    );
  }


  static void goToContactUsPage()
  {
    Get.toNamed(
      Routes.contactUsPage,
    );
  }

  static void goToRemoveAdsPage()
  {
    Get.toNamed(
      Routes.removeAdsPage,
    );
  }


}