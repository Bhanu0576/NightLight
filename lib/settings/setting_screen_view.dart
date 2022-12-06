import 'dart:ui';

import 'package:demo1212/appStyle/app_color.dart';
import 'package:demo1212/appStyle/app_dimension.dart';
import 'package:demo1212/settings/setting_page_controller.dart';
import 'package:demo1212/utils/switchButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';



class SettingScreen extends GetView<SettingPageController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPageController>(builder: (controller) {

      return Scaffold(
        backgroundColor: AppColors.colorBlueDark,
        appBar: AppBar(
          backgroundColor: AppColors.colorBlueDark,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.colorWhite),
            onPressed: () { Get.back(result: controller.isStart) ; },
          ),
          centerTitle: true,
          title: Text("Settings",),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.twenty),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Button Sound", style: TextStyle(color: AppColors.colorWhite, fontSize: AppDimensions.seventeen),),
                   Transform.scale(
                    scale: 1,
                    child: CustomSwitch(
                      value: controller.isStart,
                      onChanged: (value) {
                        controller.isStart = value;
                        if(value==true){
                          controller.addBoolToSF("true");
                          // controller.update();
                        }else{
                          controller.addBoolToSF("false");
                          // controller.update();
                        }
                        controller.update();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: AppDimensions.twentyTwo),
              alignment: Alignment.topLeft,

                child: Text("Brightness", style: TextStyle(color: AppColors.colorWhite, fontSize: AppDimensions.seventeen), textAlign: TextAlign.start,)
            ),
            Container(
              padding: EdgeInsets.only(top: AppDimensions.fifTeen ,left: AppDimensions.twenty, right: AppDimensions.twenty, bottom: AppDimensions.twenty),
              
              child:Row(
                    children: [
                      AnimatedCrossFade(
                          firstChild: Icon(Icons.brightness_7, size: AppDimensions.thirty, color: AppColors.colorWhite,),
                          secondChild: Icon(Icons.brightness_3, size: AppDimensions.thirty, color: AppColors.colorWhite,),
                          crossFadeState: controller.toggle ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(seconds: 1)
                      ),
                      Expanded(child: Slider(
                        min: 0.0,
                        max: 1.0,
                        value: controller.brightness,
                        onChanged: (value)  {
                          controller.brightness = value;
                        
                          ScreenBrightness().setScreenBrightness(controller.brightness);
                          
                          // try {
                          //       ScreenBrightness().setScreenBrightness(controller.brightness);
                          //     } 
                          // catch (e) 
                          //     {
                          //     print(e);
                          //     throw 'Failed to set brightness';
                          //     }


                          // controller.brightness = value;
                          // FlutterScreenWake.setBrightness(controller.brightness);
                          if(controller.brightness == 0)
                          {
                            controller.toggle = true;
                          }
                          else
                          {
                            controller.toggle = false;
                          }
                          controller.update();
                        },

                      )),
                    ],
                  ),

              ),
          ],
        ),
      );

        });
  }

}