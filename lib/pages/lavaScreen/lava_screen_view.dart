import 'package:demo1212/appStyle/app_color.dart';
import 'package:demo1212/appStyle/app_dimension.dart';
import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'lava_screen_controller.dart';

class LavaScreen extends StatelessWidget {
  // ScreenBrightness().setScreenBrightness(1.0);

  @override
  Widget build(BuildContext context) {
    ScreenBrightness().setScreenBrightness(1.0);


    return GetBuilder<LavaScreenController>(builder: (controller) {
      return WillPopScope(
          onWillPop: () async {
            controller.assetsAudioPlayer.stop();
            controller.assetsAudioPlayer.dispose();
             Get.back();
             controller.timer!.cancel();

            return true;
          },
        child: Scaffold(
          body: GestureDetector(
            onTap: (){
              // Get.offNamedUntil('homePage', (route) => false);
              Get.back();
              controller.assetsAudioPlayer.stop();
              controller.assetsAudioPlayer.dispose();
              controller.timer!.cancel();
            },
            child: controller.selectedScreenValue == "simple"?
            Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                       color: controller.color,
                      
                    ),
                  ),
                  Positioned.fill(
                    child: FloatingBubbles(
                      noOfBubbles: 45,
                      colorsOfBubbles: [
                        Colors.green.withAlpha(30),
                        AppColors.colorYellow,
                      ],
                      sizeFactor: 0.16,
                      duration: controller.time, // 120 seconds.
                      opacity: 70,
                      paintingStyle: PaintingStyle.stroke,
                      strokeWidth: AppDimensions.thirteen,
                      shape: controller.selectedScreenType == "circle" ? BubbleShape.circle
                          : controller.selectedScreenType == "roundedRectangle" ? BubbleShape.roundedRectangle
                          : BubbleShape.square,
                      //BubbleShape.circle, // circle is the default. No need to explicitly mention if its a circle.
                    ),
                  )
                ]
            )
                : controller.selectedScreenValue == "gradient"
                ? Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 3),
                      onEnd: () {
                        controller.gradientColor();
                        controller.gradientCircleColor();
                      },
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: controller.begin, end: controller.end, colors: [controller.bottomColor, controller.topColor]
                          )
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: FloatingBubbles(
                      noOfBubbles: 45,
                      colorsOfBubbles: controller.colorList,
                      sizeFactor: 0.16,
                      duration: controller.time, // 120 seconds.
                      opacity: 70,
              
                      paintingStyle: PaintingStyle.stroke,
                      strokeWidth: AppDimensions.thirteen,
                      shape: controller.selectedScreenType == "circle" ? BubbleShape.circle
                          : controller.selectedScreenType == "roundedRectangle" ? BubbleShape.roundedRectangle
                          : BubbleShape.square,
                      //BubbleShape.circle, // circle is the default. No need to explicitly mention if its a circle.
                    ),
                  )
                ]
            )
                : Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 5),
                      onEnd: () {
                        controller.gradientColor();
                      },
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: controller.begin, end: controller.end, colors: [controller.bottomColor, controller.topColor]
                          )
                      ),
                      
                    ),
                  ),
                  
                ]
            )
          ),
        ),
      );
    });
 }
}

