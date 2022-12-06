import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LavaScreenController extends GetxController {
  var argumentData=Get.arguments;
  late Color color;
  late String audio;
  late String selectedScreenName;
  late String selectedScreenType;
  late String selectedScreenValue;
  late List<Color> multipleColors;
  late int minut;
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  int index = 0;
  late Color bottomColor;
  late Color topColor;
  late Color bubbleColorA ;
  late Color bubbleColorB ;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  Timer? timer;

  late int time = (minut * 60);

  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];


  @override
  void onInit() {
    super.onInit();

      color=argumentData[0]["color"];
      bottomColor = colorList[0];
      topColor = color;
      bubbleColorA = colorList[0];
      bubbleColorB = colorList[1];

      minut = argumentData[0]["min"];
      selectedScreenName = argumentData[0]["ScreenName"];
      selectedScreenType = argumentData[0]["ScreenType"];
      selectedScreenValue = argumentData[0]["ScreenValue"];
      //multipleColors.add(argumentData[0]["multipleColors"]);


      time = (minut * 60);
      // Future.delayed( Duration(minutes: minut), () {
      //   assetsAudioPlayer.stop();
      //   // Get.offNamedUntil('homePage', (route) => false);
      //   Get.back();
      //   });

        timer = Timer(
         Duration(minutes: minut),() {
            assetsAudioPlayer.stop();
            Get.back();
            timer!.cancel();
            print("$minut minuts timer completed");
       },
      );

    Future.delayed( Duration(seconds: 3), () {
      bottomColor = colorList[1];
      update();
    });

    // final sectimer = Timer(
    //      Duration(seconds: minut),() {
    //         assetsAudioPlayer.stop();
    //         Get.back();
    //         print("$minut minuts timer completed");
    // // Navigate to your favorite place
    //    },
    //   );


    audio=argumentData[0]["audio"];
    assetsAudioPlayer.open(
        Audio(audio),
        autoStart: true,
        showNotification: false,
        loopMode: LoopMode.single
    );

  }

  gradientCircleColor()
  {
    for(int i=0; i<colorList.length; i++)
      {
        bubbleColorA = colorList[i];
        bubbleColorB = colorList[i];
      }
    update();
  }

  gradientColor()
  {
        index = index + 1;
        bottomColor = colorList[index % colorList.length];
        topColor = colorList[(index + 1) % colorList.length];
        update();
  }

  onBackButton()
  {
    AssetsAudioPlayer().stop();
    Get.back();
    return false;

  }

  playOrPauseMusic() {
    AssetsAudioPlayer().stop();
       AssetsAudioPlayer().dispose();

  }

}