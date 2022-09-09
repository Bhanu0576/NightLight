// // ignore: import_of_legacy_library_into_null_safe
// import 'dart:async';
// import 'dart:ffi';
//
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../model/multi_model_colors.dart';
//
//
//
// class ColorPickPageController extends GetxController {
//   var argumentData=Get.arguments;
//   late Color color;
//   late String audio;
//   late String multipleColors;
//   late int minut;
//   late int secn;
//
//   final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
//   List<MultipleColors> multiColor =[];
//
//   // int index = 0;
//   //  Color? bottomColor;
//   //  Color? topColor;
//   // Alignment begin = Alignment.bottomLeft;
//   // Alignment end = Alignment.topRight;
//
//   int c=0;
//   Timer? timer;
//
//
//   List<Color> colorList = [];
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     minut = argumentData[0]["min"];
//     secn = argumentData[0]["sec"];
//
//     if(argumentData[0]["multipleColors"]==null){
//       color=argumentData[0]["color"];
//       minut = argumentData[0]["min"];
//       Future.delayed( Duration(minutes: minut), () {
//         assetsAudioPlayer.stop();
//         Get.offNamedUntil('homePage', (route) => false);
//         print("minut...,,, ${minut}");});
//
//     }else {
//       multiColor = argumentData[0]["multipleColors"];
//       print("colors length...${multiColor.length}");
//       print("sec.....${secn}");
//       print("minut.....${minut}");
//
//       Future.delayed( Duration(minutes: minut), () {
//
//       //   bottomColor = multiColor[1].colorName!;
//       // topColor = multiColor[0].colorName!;
//
//
//       // update();
//       // Future.delayed( Duration(seconds: 1), () {
//       //
//       //   bottomColor = multiColor[2].colorName!;
//       //  update();
//       // });
//
//      color = Colors.red;
//         timer = Timer.periodic(Duration(seconds: secn), (Timer t) {
//           print(c);
//           print(multiColor.length-1);
//
//           // index = index + 1;
//           // // animate the color
//           // bottomColor = multiColor[index % multiColor.length].colorName!;
//           // topColor = multiColor[(index + 1) % multiColor.length].colorName!;
//
//
//           if (c == multiColor.length - 1) {
//           c = 0;
//           color = multiColor[c].colorName!;
//           print("C value....${c}");
//           print("MultiColor value.... ${multiColor.length-1}");
//           update();
//         } else {
//             c = c + 1;
//             color = multiColor[c].colorName!;
//           print("C value....${c}");
//           print("MultiColor value.... ${multiColor.length-1}");
//           update();
//         }
//         });
//       });
//     };
//       Future.delayed( Duration(minutes: minut), () {
//         assetsAudioPlayer.stop();
//         Get.offNamedUntil('homePage', (route) => false);
//         print("minut...,,, ${minut}");
//
//       });
//         // assetsAudioPlayer.stop();
//         // Get.offNamedUntil('homePage', (route) => false);
//       // });
//
//
//     audio=argumentData[0]["audio"];
//     // multipleColors=argumentData[0]["multipleColors"];
// //    print("audio.....$audio");
//     assetsAudioPlayer.open(
//       Audio(audio),
//       autoStart: true,
//       showNotification: false,
//       loopMode: LoopMode.single
//     );
// }
//
// // colorIndex()
// // {
// //
// //   update();
// // }
//   //music_player_controller.dart
//   playOrPauseMusic() {
//     AssetsAudioPlayer().stop();
//   }
//
//
// //Timer(Duration(seconds: minut))
//
//
//
// }

// ignore: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/multi_model_colors.dart';



class ColorPickPageController extends GetxController {
  var argumentData=Get.arguments;
  late Color color;
  late String audio;
  late String multipleColors;
  late int minut;
  late int secn;
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  List<MultipleColors> multiColor =[];

  int c=0;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    minut = argumentData[0]["min"];
    secn = argumentData[0]["sec"];

    if(argumentData[0]["multipleColors"]==null){
      color=argumentData[0]["color"];
      minut = argumentData[0]["min"];
      Future.delayed( Duration(minutes: minut), () {
        assetsAudioPlayer.stop();
        Get.offNamedUntil('homePage', (route) => false);
        print("minut...,,, ${minut}");});

    }else {
      multiColor = argumentData[0]["multipleColors"];
      print("colors length...${multiColor.length}");
      print("sec.....${secn}");
      print("minut.....${minut}");

      // Future.delayed( Duration(minutes: minut), () {

      color = multiColor[c].colorName!;
      // color = Colors.red;
      timer = Timer.periodic(Duration(seconds: secn), (Timer t) {
        print(c);
        print(multiColor.length-1);

        if (c == multiColor.length - 1) {
          c = 0;
          color = multiColor[c].colorName!;
          print("C value....${c}");
          print("MultiColor value.... ${multiColor.length-1}");
          update();
        } else {
          c = c + 1;
          color = multiColor[c].colorName!;
          print("C value....${c}");
          print("MultiColor value.... ${multiColor.length-1}");
          update();
        }}
      );
      Future.delayed( Duration(minutes: minut), () {
        assetsAudioPlayer.stop();
        Get.offNamedUntil('homePage', (route) => false);
        print("minut...,,, ${minut}");

      });
      // assetsAudioPlayer.stop();
      // Get.offNamedUntil('homePage', (route) => false);
      // });
    }

    audio=argumentData[0]["audio"];
    // multipleColors=argumentData[0]["multipleColors"];
    print("color.....${color}");
    print("audio.....$audio");
    assetsAudioPlayer.open(
        Audio(audio),
        autoStart: true,
        showNotification: false,
        loopMode: LoopMode.single
    );
  }
  //music_player_controller.dart
  playOrPauseMusic() {
    AssetsAudioPlayer().stop();
  }


//Timer(Duration(seconds: minut))



}
