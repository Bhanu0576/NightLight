import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../model/multi_model_colors.dart';
import '../../widget/ad_helper.dart';

class ColorPickPageController extends GetxController {
  var argumentData = Get.arguments;
  late Color color;
  late String audio;
  late String multipleColors;
  late int minut;
  late int secn;
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  // bool interstitialAd = false;
  InterstitialAd? interstitialAd;

  late BannerAd bannerAd;

  bool isBannerAdReady = false;
  //InterstitialAd? interstitialAd;

  bool isInterstitialAdReady = false;

  bool isRewardedAdReady = false;

  RewardedAd? rewardedAd;

  List<MultipleColors> multiColor = [];

  int c = 0;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    if (argumentData[0]["min"] != null) {
      minut = argumentData[0]["min"];
    }

    if (argumentData[0]["sec"] != null) {
      secn = argumentData[0]["sec"];
    }

    if (argumentData[0]["color"] != null) {
      color = argumentData[0]["color"];
    }

    if (argumentData[0]["multipleColors"] == null) {
      color = argumentData[0]["color"];
      minut = argumentData[0]["min"];
      update();
      // Future.delayed(Duration(minutes: minut), () {
      //   assetsAudioPlayer.stop();
      //   // Get.offNamedUntil('homePage', (route) => false);
        
      //   Get.back();
      // });
      timer = Timer(
         Duration(minutes: minut),() {
            assetsAudioPlayer.stop();
            
            timer!.cancel();
            Get.back();
            print("Single color $minut minuts timer completed");
       },
      );
    } else {
      multiColor = argumentData[0]["multipleColors"];

      color = multiColor[c].colorName!;

      timer = Timer.periodic(Duration(seconds: secn), (Timer t) {
        if (c == multiColor.length - 1) {
          c = 0;
          color = multiColor[c].colorName!;

          update();
        } else {
          c = c + 1;
          color = multiColor[c].colorName!;

          update();
        }
      });
      // Future.delayed(Duration(minutes: minut), () {
      //   assetsAudioPlayer.stop();
      //   Get.offNamedUntil('homePage', (route) => false);
      // });
      timer = Timer(
         Duration(minutes: minut),() {
            assetsAudioPlayer.stop();
            
            timer!.cancel();
            Get.back();
            print("Multi Color $minut minuts timer completed");
       },
      );


    }

    audio = argumentData[0]["audio"];

    assetsAudioPlayer.open(Audio(audio),
        autoStart: true, showNotification: false, loopMode: LoopMode.single);

    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          var isInterstitialAdReady = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          if (kDebugMode) {
            print("failed to Load Interstitial Ad ${error.message}");
          }
        }));
  }

  playOrPauseMusic() {
    AssetsAudioPlayer().stop();
  }
}
