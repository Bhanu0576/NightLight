import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPageController extends GetxController {
  bool isStart = false;
  double brightness = 0.10;
  bool toggle = false;
  bool mounted = true;
   String? val;

  addBoolToSF(String isTap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('buttonSound', isTap).then((value) {});
  }

  getSharedPrefenceValue() {
    SharedPreferences.getInstance().then((value) {
      val = value.getString("buttonSound");

      if (val == null) {
        isStart = false;
      } else {
        if (val == "true") {
          isStart = true;
        } else {
          isStart = false;
        }
      }
      update();
    });
    
  }

  Future<void> initPlatformBrightness() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // toggle = pref.getString('buttonSound') == null
    //     ? false
    //     : pref.getString('buttonSound') == "true"
    //         ? true
    //         : false;
    double bright;
    // try {
     
    //   bright = await FlutterScreenWake.brightness;

    
    // } on PlatformException {
    //   bright = 1.0;
    // }

    // if (mounted) return;

    // brightness = bright;

    update();
  }

  @override
  onInit()  {

    getSharedPrefenceValue();
    initPlatformBrightness();
    super.onInit();

    getScreenBrightness();

  }

  Future<void> getScreenBrightness()
  async 
  {
        double bright = await ScreenBrightness().current;
        brightness=bright;
        update();
  }
}
