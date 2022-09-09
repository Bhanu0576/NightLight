import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo1212/model/multi_model_colors.dart';
import 'package:demo1212/pages/HomePage/home_page_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../model/multi_modal_lava.dart';
import '../../model/multiple_audio_model.dart';
import '../../utils/app_strings.dart';

class HomePageController extends GetxController {
  String select = "SimpleLight ";
  int selectColor = 0;
  int colorValue = 0;
  Color? color;
  String? audio;
  Color? screenPickerColor;
  String type = "color";
  var colorIndex;
  var soundIndex;
  bool isRainbowSelect = false;
  bool isRandomSelect = false;
  late String selectedScreen;
  late String selectedScreenType;
  late String selectedScreenValue;
  late Color colorName;

  List<MultipleAudioModel> multiAudioModel = [
    MultipleAudioModel("Perfect rilence", "assets/sounds/forestbirds.mp3", false.obs),
    MultipleAudioModel("Gentle rainfall", "assets/sounds/dreams.mp3", false.obs),
    MultipleAudioModel("Topical jungle", "assets/sounds/ocean.mp3", false.obs),
  ];

  List<MultiLavaScreen> screens = [
    MultiLavaScreen("Round Bubbles", "circle", "simple", false.obs),
    MultiLavaScreen("Rectangle Bubbles", "roundedRectangle", "simple", false.obs),
    MultiLavaScreen("Square Bubbles", "square", "simple", false.obs),
    MultiLavaScreen("Gradient Color Changing", "s", "onlygradient", false.obs),
    MultiLavaScreen("Gradient Round Bubbles", "circle", "gradient", false.obs),
    MultiLavaScreen("Gradient Rectangle Bubbles", "roundedRectangle", "gradient", false.obs),
    MultiLavaScreen("Gradient Square Bubbles", "square", "gradient", false.obs),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initPackageInfo();
    model.clear();
    for (int i = 0; i < arrColors.length; i++) {
      MultipleColors colors =
          MultipleColors(colorName: arrColors[i], isSelect: false.obs);
      print("Colors add....$colors");
      model.add(colors);
    }

    //selectedScreen = screens[sc].screenName.toString();

    // model1.clear();
  }
  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    update();
  }

  PackageInfo packageInfo = PackageInfo(
    appName: AppStrings.Unknown,
    packageName: AppStrings.Unknown,
    version: AppStrings.Unknown,
    buildNumber: AppStrings.Unknown,
  );

  lavaScreenSelected()
  {
    for(int i=0; i<screens.length; i++)
      {
        screens[i].isSelect.value == false;
      }
    screens[sc].isSelect.value= true;
  }

  List<MultiLavaScreen> screens1 = [];

  int sc=0;
  screenselectincrement()
  {
    //screens[index];
        if(sc<5)
          {
            sc = sc +1;
          }
  }
  screenselectdecrement()
  {

    if(sc>0){
      sc = sc-1;
    }
  }


  int mint = 2;
  increment() {
    mint = mint + 1;
    update();
  }

  decrement() {
    if (mint != 1) {
      mint = mint - 1;
      update();
    }
  }

  int sec = 5;
  incrementSec() {
    if (sec != 60) {
      sec = sec + 1;
      update();
    }
  }

  decrementSec() {
    if (sec != 1) {
      sec = sec - 1;
      update();
    }
  }

  bool value = false;


  List<Color> arrColors = [
    Color.fromRGBO(233, 52, 35, 1),
    Color.fromRGBO(241, 169, 59, 1),
    Color.fromRGBO(255, 254, 84, 1),
    Color.fromRGBO(117, 251, 76, 1),
    Color.fromRGBO(0, 0, 244, 1),
    Color.fromRGBO(68, 7, 124, 1),
    Color.fromRGBO(223, 136, 231, 1),
    Color.fromRGBO(217, 217, 217, 1),
  ];

  // List<String> arrAudio = [
  //   "assets/sounds/dreams.mp3",
  //   "assets/sounds/forestbirds.mp3",
  //   "assets/sounds/ocean.mp3",
  //   "assets/sounds/forestbirds.mp3",
  // ];

  List<MultipleColors> model =[]; //we have made List model of MultipleColor(multi_model_colors) class
  List<MultipleColors> multiModel = [];
  List<MultipleAudioModel> multipleAudioModel1 = [];

  changeColorState(int index) {
    for (int i = 0; i < model.length; i++) {
      model[i].isSelect.value = false;
    }
    model[index].isSelect.value = true;

    colorName = arrColors[index];
    //color.add(model);
    update();
  }

  bool checkModel()
  {
    for(int i=0; i<model.length ; i++)
      {
        if(model[i].isSelect.value == true)
          {
            return true;

          }
      }
    return false;
  }

  multiColorSelect(int index) {
    model[index].isSelect.value == false ? model[index].isSelect.value = true : model[index].isSelect.value = false;
    update();
  }

  multipleColorSelection() {
    if (multiModel.isNotEmpty) {
      multiModel.clear();
    }
    for (int i = 0; i < model.length; i++) {
      if (model[i].isSelect == true) {
        multiModel.add(model[i]);
      }
    }
    print("Color is...,,, ${multiModel.length}");
  }

  int selectRandomValue() {
    Random r = Random();
    return r.nextInt(model.length - 1);
    update();
  }


  rainbowSelector() {
    //isRainbowSelect ==false ? isRainbowSelect =true : isRainbowSelect =false;

    for (int i = 0; i < model.length; i++) {
      if (i < 6) {
        model[i].isSelect.value = true;
      } else {
        model[i].isSelect.value = false;
      }
    }
    update();
  }

  selectAudio(int index) {
    for (int i = 0; i < multiAudioModel.length; i++) {
      multiAudioModel[i].isSelect.value = false;
    }
    multiAudioModel[index].isSelect.value = true;
    update();
  }
}
