import 'package:demo1212/pages/colorPickPage/color_pick_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ColorPickScreen extends StatelessWidget {
  const ColorPickScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ScreenBrightness().setScreenBrightness(1.0);
    return GetBuilder<ColorPickPageController>(builder: (controller) {
      return WillPopScope(
          onWillPop: () async  
        {
               controller.assetsAudioPlayer.stop();
               controller.assetsAudioPlayer.dispose();
               Get.back();
               controller.timer!.cancel();
               return true;
        },
        child: Scaffold(
            backgroundColor: controller.color,
            body: GestureDetector(
              onTap: () {
               controller.assetsAudioPlayer.stop();
               controller.assetsAudioPlayer.dispose();
               controller.timer!.cancel();
               Get.back();
              //  Get.offNamedUntil('homePage', (route) => false);
                },
            ),
        ),
      );
    });
  }
}