import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo1212/pages/colorPickPage/color_pick_controller.dart';
import '../HomePage/home_page_view.dart';

class ColorPickScreen extends StatelessWidget {
  const ColorPickScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorPickPageController>(builder: (controller) {
      return Scaffold(

          backgroundColor: controller.color,

          body: GestureDetector(
            onTap: () {
             controller.assetsAudioPlayer.stop();
             Get.offNamedUntil('homePage', (route) => false);
              },
          )
      );
    });
  }
}