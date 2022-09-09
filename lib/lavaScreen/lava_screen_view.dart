import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lava_screen_controller.dart';
// import 'package:night_light/appStyle/app_color.dart';
// import 'package:night_light/appStyle/app_dimension.dart';
// import 'package:night_light/appStyle/assets_images.dart';
// import 'package:night_light/pages/splash/splash_page_controller.dart';
class LavaScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LavaScreenController>(builder: (controller) {
      return GestureDetector(
        onTap: (){
          Get.offNamedUntil('homePage', (route) => false);
          controller.assetsAudioPlayer.stop();
        },
        child: controller.selectedScreenValue == "simple"?
        Stack(
            children: [
              Positioned.fill(
                child: Container(

                   color: controller.color,
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [controller.color, Colors.lightBlue.shade900])),
                ),
              ),
              Positioned.fill(
                child: FloatingBubbles(
                  noOfBubbles: 45,
                  colorsOfBubbles: [
                    Colors.green.withAlpha(30),
                    Colors.yellow,

                  ],
                  sizeFactor: 0.16,
                  duration: controller.time, // 120 seconds.
                  opacity: 70,
                  paintingStyle: PaintingStyle.stroke,
                  strokeWidth: 13,
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
                  strokeWidth: 13,
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
                  // color: controller.color,
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [controller.color, Colors.lightBlue.shade900])),
                ),
              ),
              /*Positioned.fill(
                child: FloatingBubbles(
                  noOfBubbles: 45,
                  colorsOfBubbles: [
                    Colors.green.withAlpha(30),
                    Colors.yellow,
                  ],
                  sizeFactor: 0.16,
                  duration: controller.time, // 120 seconds.
                  opacity: 70,
                  paintingStyle: PaintingStyle.stroke,
                  strokeWidth: 13,
                  shape: controller.selectedScreenType == "circle" ? BubbleShape.circle
                      : controller.selectedScreenType == "roundedRectangle" ? BubbleShape.roundedRectangle
                      : BubbleShape.square,
                  //BubbleShape.circle, // circle is the default. No need to explicitly mention if its a circle.
                ),
              )*/
            ]
        )
      );
    });
 }
}

