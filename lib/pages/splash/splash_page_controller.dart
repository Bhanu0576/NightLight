import 'dart:io';

import 'package:demo1212/navigation/app_route_maps.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashPageController extends GetxController {
  String showCase ="";

getDeviceID() async {
   String? deviceId="";
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }
    print('DeviceID $deviceId');
}

  @override
  void onInit() async{
    super.onInit();
    final pref = await SharedPreferences.getInstance();
    showCase=pref.getString("tapClick")??"";
   getDeviceID();


    Future.delayed(const Duration(seconds: 3), () {
      

      if(showCase == "1")
      {
        AppRouteMaps.gotoHomePage();
        //update();

      }
      else
      {

        AppRouteMaps.gotoShowCaseMain();
        //update();
      }


    });
  }
}