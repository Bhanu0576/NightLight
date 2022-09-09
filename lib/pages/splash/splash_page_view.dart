import 'package:demo1212/appStyle/app_color.dart';
import 'package:demo1212/appStyle/app_dimension.dart';
import 'package:demo1212/appStyle/assets_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:night_light/appStyle/app_color.dart';
// import 'package:night_light/appStyle/app_dimension.dart';
// import 'package:night_light/appStyle/assets_images.dart';
// import 'package:night_light/pages/splash/splash_page_controller.dart';

import 'splash_page_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(builder: (controller) {
      //SplashScreenViewModel splashScreenViewModel =Get.put(SplashScreenViewModel());
      return Scaffold(
        backgroundColor: AppColors.colorBlueDark,
        body:Center(child: Container(
            padding: EdgeInsets.only(left: AppDimensions.forty, top: AppDimensions.twenty, right: AppDimensions.forty, bottom: AppDimensions.twenty) ,decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.twohundred),
            boxShadow: [BoxShadow(
              color: AppColors.colorWhite,
              blurRadius: AppDimensions.tenpointzero,
            ),]
        ) ,
            child: Image.asset(AssetsBase.bulbyellowIcon))),
      );
    });
  }



}
