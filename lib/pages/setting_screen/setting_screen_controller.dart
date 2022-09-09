import 'package:demo1212/navigation/app_route_maps.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
//import 'package:night_light/navigation/app_route_maps.dart';



class SettingScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    new Future.delayed(const Duration(seconds: 4), () {
      AppRouteMaps.gotoHomePage();
    });
  }

}