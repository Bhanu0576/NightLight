import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:night_light/navigation/app_route_maps.dart';



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

  //var color;
  late int time = (minut * 60);

  // var time;

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

      print("The color is:.... ${color}");
      minut = argumentData[0]["min"];
      selectedScreenName = argumentData[0]["ScreenName"];
      selectedScreenType = argumentData[0]["ScreenType"];
      selectedScreenValue = argumentData[0]["ScreenValue"];
      //multipleColors.add(argumentData[0]["multipleColors"]);


      time = (minut * 60);
      Future.delayed( Duration(minutes: minut), () {
        assetsAudioPlayer.stop();
        Get.offNamedUntil('homePage', (route) => false);
        });

    Future.delayed( Duration(seconds: 3), () {
      bottomColor = colorList[1];
      print("The Colors List color is..... ${bottomColor}");
      update();
    });


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

  playOrPauseMusic() {
    AssetsAudioPlayer().stop();
  }

}