import 'package:demo1212/appStyle/app_color.dart';
import 'package:demo1212/appStyle/app_dimension.dart';
import 'package:demo1212/appStyle/assets_images.dart';
import 'package:demo1212/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
            
        ) ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsBase.splashlight, height: AppDimensions.hundredtwenty, width: AppDimensions.hundredtwenty,),
                Text(AppStrings.nightLamp, style: TextStyle(color: AppColors.colorWhite, fontSize: AppDimensions.thirtySeven),),
              ],
            ),
        )),
      );
    });
  }



}
