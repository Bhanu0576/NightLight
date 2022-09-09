import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:demo1212/model/multi_model_colors.dart';

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

  static void gotoColorPick(Color color,String audio, int minutes) {
    Get.offNamed(
      Routes.colorPickPage,
      arguments: [{
        "color":color,
        "audio":audio,
        "min": minutes,
        //"second":
        //"minutes":
      }]
    );
  }
  static void gotoColorPick1(List<MultipleColors> multipleColors, String audio, int minutes, int seconds) {
    Get.offNamed(
        Routes.colorPickPage,
        arguments: [{
          "multipleColors":multipleColors,
          "audio": audio,
          "min": minutes,
          "sec": seconds,
          //"second":
          //"minutes":
        },]
    );
  }

  // static void gotoColorPick2(List<MultipleColors> multipleColors, String audio, int minutes)
  // {
  //   Get.offNamed(
  //     Routes.colorPickPage,
  //     arguments: [{
  //       "multipleColors":multipleColors,
  //       "audio": audio,
  //       "min": minutes,
  //     }]
  //   );
  // }

  static void goToLavaPage(Color color, String screenName  ,String screenType , String screenValue, String audio, int minutes) {
    Get.offNamed(
        Routes.lava,
        arguments: [{
          "color":color,
          "ScreenName": screenName,
          "ScreenType": screenType,
          "ScreenValue": screenValue,
          "audio":audio,
          "min": minutes,
          //"second":
          //"minutes":
        }]
    );
  }


}