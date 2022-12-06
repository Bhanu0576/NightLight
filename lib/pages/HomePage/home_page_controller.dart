import 'dart:async';
// import 'dart:js';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:demo1212/model/multi_model_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/multi_modal_lava.dart';
import '../../model/multiple_audio_model.dart';
import '../../utils/app_strings.dart';
import '../../widget/ad_helper.dart';

class HomePageController extends GetxController {

  InterstitialAd? interstitialAd;
  String select = "SimpleLight ";
  int selectColor = 0;
  int colorValue = 0;
  Color? singlecolor;
  Color? singleColorLava;
  Color? multicolor;
  String? audioA;
  String? audioB;
  String? audioC;
  Color? screenPickerColor;
  String type = "color";
  // ignore: prefer_typing_uninitialized_variables
  var colorIndex;
  // ignore: prefer_typing_uninitialized_variables
  var soundIndex;
  bool isRainbowSelect = false;
  bool isRandomSelect = false;
  late String selectedScreen;
  RxBool showBubbles = false.obs;
  late String selectedScreenType;
  late String selectedScreenValue;
  late Color colorName;

  String str = "";
  String? val;
  bool buttonTap = false;
  late String buttonClickSound;
  Timer? timer;
  bool isBannerAdReady = false;
  bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;
  RewardedAd? rewardedAd;
  String showCase = "";
  String colorPickerVal = "";
  String audioSelectVal = "";
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  String soundPath = "assets/sounds/buttonsoundglasstap.mp3";
  String spColor = "";
  String spAudio = "";

  int? singleColorSp ;
  int? singleColorAudioSp ;

  //late StreamSubscription<List<PurchaseDetails>> _subscription;

  //late BannerAd bannerAd;

  // int? lavaColorSp;
  // int? lavaColorAudioSp;

  RxBool isAudioSelectedForSingle = false.obs;
  RxBool isAudioSelectedForLava = false.obs;
  RxBool isAudioSelectedForMulti = false.obs;

  RxBool isColorSelectedForSingle = false.obs;
  RxBool isColorSelectedForLava = false.obs;
  RxBool isColorSelectedForMulti = false.obs;

  RxList<MultipleAudioModel> firstmultiAudioModel = [
    MultipleAudioModel("Jungle", "assets/sounds/forestbirds.mp3", false.obs),
    MultipleAudioModel("Dreams", "assets/sounds/dreams.mp3", false.obs),
    MultipleAudioModel("Ocean", "assets/sounds/ocean.mp3", false.obs),
  ].obs;

  RxList<MultipleAudioModel> secondmultiAudioModel = [
    MultipleAudioModel("Jungle", "assets/sounds/forestbirds.mp3", false.obs),
    MultipleAudioModel("Dreams", "assets/sounds/dreams.mp3", false.obs),
    MultipleAudioModel("Ocean", "assets/sounds/ocean.mp3", false.obs),
  ].obs;

  RxList<MultipleAudioModel> thirdmultiAudioModel = [
    MultipleAudioModel("Jungle", "assets/sounds/forestbirds.mp3", false.obs),
    MultipleAudioModel("Dreams", "assets/sounds/dreams.mp3", false.obs),
    MultipleAudioModel("Ocean", "assets/sounds/ocean.mp3", false.obs),
  ].obs;

  late WebViewController webViewController;
  String htmlFilePath = 'assets/webpage/nightlightlamp.html';

  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  final keyFive = GlobalKey();
  final keySix = GlobalKey();
  BuildContext? myContext;

  List<MultipleAudioModel> multiAudioModel = [
    MultipleAudioModel("Jungle", "assets/sounds/forestbirds.mp3", false.obs),
    MultipleAudioModel("Dreams", "assets/sounds/dreams.mp3", false.obs),
    MultipleAudioModel("Ocean", "assets/sounds/ocean.mp3", false.obs),
  ];

  List<MultiLavaScreen> screens = [
    MultiLavaScreen("Round Bubbles", "circle", "simple", false.obs),
    MultiLavaScreen("Squircle Bubbles", "roundedRectangle", "simple", false.obs),
    MultiLavaScreen("Square Bubbles", "square", "simple", false.obs),
    MultiLavaScreen("Gradient Color Changing", "s", "onlygradient", false.obs),
    MultiLavaScreen("Gradient Round Bubbles", "circle", "gradient", false.obs),
    MultiLavaScreen("Gradient Squircle Bubbles", "roundedRectangle", "gradient", false.obs),
    MultiLavaScreen("Gradient Square Bubbles", "square", "gradient", false.obs),
  ];
  getSharedPrefenceValue() {
    SharedPreferences.getInstance().then((value) {
      val = value.getString("buttonSound");

      if (val == null) {
        str = "false";
      } else {
        if (val == "true") {
          str = val!;
        } else {
          str = val!;
        }
      }
    });
    update();
  }

  saveColorAndAudioSP(String name, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(name, value);
  }

  saveMultiColorSP(String name, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(name, value);
  }

  interstitialaddsfunc()
  {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialAdReady = true;
        }, onAdFailedToLoad: (LoadAdError error) {
          isInterstitialAdReady = false;
          if (kDebugMode) {
            print("failed to Load Interstitial Ad ${error.message}");
          }
        }));
  }


  @override
  void onInit() async {
    super.onInit();
    interstitialaddsfunc();
    final prefs = await SharedPreferences.getInstance();
    showCase = prefs.getString("tapClick") ?? "";


     singleColorSp = prefs.getInt('singleColor');
     singleColorAudioSp = prefs.getInt('singleColorAudio');

     
    int? singleAudioSp = prefs.getInt("singleAudio");
    int? multiAudioSp = prefs.getInt("multiAudio");
    int? lavaColorSp = prefs.getInt("lavaColor");
    int? lavaAudioSp = prefs.getInt("lavaAudio");
    List<String>? multiColorList = prefs.getStringList("multiColor");

    if (singleAudioSp != null) {
      firstmultiAudioModel[singleAudioSp].isSelect.value = true;
    }

    if (multiAudioSp != null) {
      secondmultiAudioModel[multiAudioSp].isSelect.value = true;
    }

    if (lavaAudioSp != null) {
      thirdmultiAudioModel[lavaAudioSp].isSelect.value = true;
    }

    getSharedPrefenceValue();
    initPackageInfo();
    model.clear();
    for (int i = 0; i < arrColors.length; i++) {
      MultipleColors colors = MultipleColors(colorName: arrColors[i], isSelect: false.obs);
      model.add(colors);
    }

    for (int i = 0; i < arrColors.length; i++) {
      if(singleColorSp!=null){
        if(i==singleColorSp){
          singlecolor =  arrColors[i] ;
        }
      }

      MultipleColors colors = MultipleColors(
          colorName: arrColors[i],
          isSelect: singleColorSp == null ? false.obs  : i == singleColorSp ? true.obs : false.obs
          );
      if (singleColorModel.length < 8) {
        singleColorModel.add(colors);
      }

    }



    for (int i = 0; i < arrColors.length; i++) {


      if(lavaColorSp!=null){
        if(i==lavaColorSp){
          singleColorLava =  arrColors[i] ;
        }
      }
      MultipleColors colors = MultipleColors(
          colorName: arrColors[i],
          isSelect:
          lavaColorSp != null
              ? i == lavaColorSp
                  ? true.obs
                  : false.obs
              : false.obs);
      if (singleColorModelLava.length < 8) {
        singleColorModelLava.add(colors);
      }
    }

    for (int i = 0; i < arrColors.length; i++) {
      if (multiColorList != null) {
        if (multiColorList.isNotEmpty) {
          if (multiColorList.contains(i.toString())) {
            MultipleColors colors = MultipleColors(colorName: arrColors[i], isSelect: true.obs);
            if (multiColorModel.length < 8) {
              multiColorModel.add(colors);
            }
          } else {
            MultipleColors colors = MultipleColors(colorName: arrColors[i], isSelect: false.obs);
            if (multiColorModel.length < 8) {
              multiColorModel.add(colors);
            }
          }
        }
      } else {
        MultipleColors colors = MultipleColors(colorName: arrColors[i], isSelect: false.obs);
        if (multiColorModel.length < 8) {
          multiColorModel.add(colors);
        }
      }
    }

    // final Stream purchaseUpdated =
    //     InAppPurchase.instance.purchaseStream;
    // _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    //   _listenToPurchaseUpdated(purchaseDetailsList);
    // }, onDone: () {
    //   _subscription.cancel();
    // }, onError: (error) {
    //   // handle error here.
    // });

    //   BannerAd(
    //   adUnitId: AdHelper.bannerAdUnitId,
    //   request: const AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       bannerAd = ad as BannerAd;
    //       update();
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       print('Failed to load a banner ad: ${err.message}');
    //       ad.dispose();
    //     },
    //   ),
    // ).load();

//   bannerAd = BannerAd(
//       // Change Banner Size According to Ur Need
//         size: AdSize.mediumRectangle,
//         adUnitId: AdHelper.bannerAdUnitId,
//         listener: BannerAdListener(onAdLoaded: (_) {
//           isBannerAdReady = true;
//            //update();
//         }, onAdFailedToLoad: (ad, LoadAdError error) {
//           if (kDebugMode) {
//             print("Failed to Load A Banner Ad${error.message}");
//           }
//           isBannerAdReady = false;
//           ad.dispose();
//         }),
//         request: const AdRequest())
//       ..load();
// //Interstitial Ads
//     InterstitialAd.load(
//         adUnitId: AdHelper.interstitialAdUnitId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
//           interstitialAd = ad;
//           isInterstitialAdReady = true;
//         }, onAdFailedToLoad: (LoadAdError error) {
//           if (kDebugMode) {
//             print("failed to Load Interstitial Ad ${error.message}");
//           }
//         }));

//     loadRewardedAd();
  }

//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//   purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//     if (purchaseDetails.status == PurchaseStatus.pending) {
//       _showPendingUI();
//     } else {
//       if (purchaseDetails.status == PurchaseStatus.error) {
//         _handleError(purchaseDetails.error!);
//       } else if (purchaseDetails.status == PurchaseStatus.purchased ||
//                  purchaseDetails.status == PurchaseStatus.restored) {
//         bool valid = await _verifyPurchase(purchaseDetails);
//         if (valid) {
//           _deliverProduct(purchaseDetails);
//         } else {
//           _handleInvalidPurchase(purchaseDetails);
//         }
//       }
//       if (purchaseDetails.pendingCompletePurchase) {
//         await InAppPurchase.instance
//             .completePurchase(purchaseDetails);
//       }
//     }
//   });
// }

// final bool available = await InAppPurchase.instance.isAvailable();
// if (!available) {
//   // The store cannot be reached or accessed. Update the UI accordingly.
// }

// static const Set<String> _kIds = <String>{'product1', 'product2'};
// final ProductDetailsResponse response =
//     await InAppPurchase.instance.queryProductDetails(_kIds);
// if (response.notFoundIDs.isNotEmpty) {
//   // Handle the error.
// }
// List<ProductDetails> products = response.productDetails;



  spColorandAudio(String filename, int vals ) async
  {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(filename, vals);
    // spColor = sp.getString('singleColor').toString();
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    update();
  }

//   advertisement()
//   {
//       bannerAd = BannerAd(
//       // Change Banner Size According to Ur Need
//         size: AdSize.mediumRectangle,
//         adUnitId: AdHelper.bannerAdUnitId,
//         listener: BannerAdListener(onAdLoaded: (_) {
//           isBannerAdReady = true;
//           update();
//         }, onAdFailedToLoad: (ad, LoadAdError error) {
//           if (kDebugMode) {
//             print("Failed to Load A Banner Ad${error.message}");
//           }
//           isBannerAdReady = false;
//           ad.dispose();
//         }),
//         request: const AdRequest())
//       ..load();
// //Interstitial Ads
//     InterstitialAd.load(
//         adUnitId: AdHelper.interstitialAdUnitId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
//           interstitialAd = ad;
//           isInterstitialAdReady = true;
//         }, onAdFailedToLoad: (LoadAdError error) {
//           if (kDebugMode) {
//             print("failed to Load Interstitial Ad ${error.message}");
//           }
//         }));

//     loadRewardedAd();
//   }

  // void loadRewardedAd() {
  //   RewardedAd.load(
  //     adUnitId: AdHelper.rewardedAdUnitId,
  //     request: const AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
  //       rewardedAd = ad;
  //       ad.fullScreenContentCallback =
  //           FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
  //             isRewardedAdReady = false;
  //             update();
  //             loadRewardedAd();
  //           });
  //       isRewardedAdReady = true;
  //       update();
  //     }, onAdFailedToLoad: (error) {
  //       if (kDebugMode) {
  //         print('Failed to load a rewarded ad: ${error.message}');
  //       }
  //       isRewardedAdReady = false;
  //       update();
  //     }),
  //   );
  // }

  PackageInfo packageInfo = PackageInfo(
    appName: AppStrings.Unknown,
    packageName: AppStrings.Unknown,
    version: AppStrings.Unknown,
    buildNumber: AppStrings.Unknown,
  );

  lavaScreenSelected() {
    for (int i = 0; i < screens.length; i++) {
      screens[i].isSelect.value == false;
    }
    screens[sc].isSelect.value = true;
  }

  playButtonSound() {
    playButton();
  }

  void playButton() {
    assetsAudioPlayer.open(Audio("assets/sounds/buttonsoundglasstap.mp3"),
        autoStart: true, showNotification: false, loopMode: LoopMode.single);
    assetsAudioPlayer.dispose();
    update();
  }

  void playButtonB() {
    assetsAudioPlayer.open(Audio("assets/sounds/buttonsoundtap.mp3"),
        autoStart: true, showNotification: false, loopMode: LoopMode.single);
    assetsAudioPlayer.dispose();
    update();
  }

  List<MultiLavaScreen> screens1 = [];

  int sc = 0;
  screenselectincrement() {
    if (sc < 5) {
      sc = sc + 1;
    } else {
      sc = 0;
    }
    if (sc != 3) {
      selectedScreenType = screens[sc].screenType.toString();
      showBubbles.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        showBubbles.value = false;
        update();
      });
      update();
    }
  }

  screenselectdecrement() {
    if (sc > 0) {
      sc = sc - 1;
    }
    else
    {
      sc = 5;
    }

    if (sc != 3) {
      selectedScreenType = screens[sc].screenType.toString();
      showBubbles.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        showBubbles.value = false;
        update();
      });
      update();
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
    const Color.fromRGBO(233, 52, 35, 1),
    const Color.fromRGBO(241, 169, 59, 1),
    const Color.fromRGBO(255, 254, 84, 1),
    const Color.fromRGBO(117, 251, 76, 1),
    const Color.fromRGBO(0, 0, 244, 1),
    const Color.fromRGBO(68, 7, 124, 1),
    const Color.fromRGBO(223, 136, 231, 1),
    const Color.fromRGBO(217, 217, 217, 1),
  ];

  List<MultipleColors> model = [];
  RxList<MultipleColors> singleColorModel = <MultipleColors>[].obs;
  RxList<MultipleColors> singleColorModelLava = <MultipleColors>[].obs;
  RxList<MultipleColors> multiColorModel = <MultipleColors>[].obs;

  List<MultipleColors> multiModel = [];
  List<MultipleAudioModel> multipleAudioModel1 = [];

  changeColorStateForSingle(int index) async {
    for (int i = 0; i < singleColorModel.length; i++) {
      singleColorModel[i].isSelect.value = false;
    }
    singleColorModel[index].isSelect.value = true;
    singlecolor = singleColorModel[index].colorName;

    final sp = await SharedPreferences.getInstance();
    sp.setInt("singleColor", index);

    update();
  }

  Color? getSelectedColor() {
    for (int i = 0; i < singleColorModel.length; i++) {
      if (singleColorModel[i].isSelect.value) {
        return singleColorModel[i].colorName!;
      }
    }
    return null;
  }

  String? getSelectedAudio() {
    for (int i = 0; i < firstmultiAudioModel.length; i++) {
      if (firstmultiAudioModel[i].isSelect.value) {
        return firstmultiAudioModel[i].audio;
      }
    }
    return null;
  }

  String? getSelectedAudioMulti() {
    for (int i = 0; i < secondmultiAudioModel.length; i++) {
      if (secondmultiAudioModel[i].isSelect.value) {
        return secondmultiAudioModel[i].audio;
      }
    }
    return null;
  }

  Color? getSelectedColorLava() {
    for (int i = 0; i < singleColorModelLava.length; i++) {
      if (singleColorModelLava[i].isSelect.value) {
        return singleColorModelLava[i].colorName!;
      }
    }
    return null;
  }

  String? getSelectedAudioLava() {
    for (int i = 0; i < thirdmultiAudioModel.length; i++) {
      if (thirdmultiAudioModel[i].isSelect.value) {
        return thirdmultiAudioModel[i].audio;
      }
    }
    return null;
  }

  changeColorStateForLava(int index) {
    for (int i = 0; i < singleColorModelLava.length; i++) {
      singleColorModelLava[i].isSelect.value = false;
    }
    singleColorModelLava[index].isSelect.value = true;
    singleColorLava = singleColorModel[index].colorName;
    saveColorAndAudioSP('lavaColor', index);
    update();
  }

  changeColorState(int index) async {
    for (int i = 0; i < model.length; i++) {
      model[i].isSelect.value = false;
    }
    model[index].isSelect.value = true;
    colorName = arrColors[index];

    update();
  }

  bool checkColorModelSingle() {
    for (int i = 0; i < singleColorModel.length; i++) {
      if (singleColorModel[i].isSelect.value == true) {
        return true;
      }
    }
    return false;
  }

  bool checkAudioModelSingle() {
    for (int i = 0; i < firstmultiAudioModel.length; i++) {
      if (firstmultiAudioModel[i].isSelect.value == true) {
        return true;
      }
    }
    return false;
  }

  bool checkColorModelMulti() {
    for (int i = 0; i < multiColorModel.length; i++) {
      if (multiColorModel[i].isSelect.value == true) {
        return true;
      }
    }
    return false;
  }

  bool checkAudioModelMulti() {
    for (int i = 0; i < secondmultiAudioModel.length; i++) {
      if (secondmultiAudioModel[i].isSelect.value == true) {
        return true;
      }
    }
    return false;
  }

  bool checkColorModelLava() {
    for (int i = 0; i < singleColorModelLava.length; i++) {
      if (singleColorModelLava[i].isSelect.value == true) {
        return true;
      }
    }
    return false;
  }

  bool checkAudioModelLava() {
    for (int i = 0; i < thirdmultiAudioModel.length; i++) {
      if (thirdmultiAudioModel[i].isSelect.value == true) {
        return true;
      }
    }
    return false;
  }

  colorPickBorder() {
    colorPickerVal = "1";
  }

  multiColorSelect(int index) {
    multiColorModel[index].isSelect.value == false
        ? multiColorModel[index].isSelect.value = true
        : multiColorModel[index].isSelect.value = false;
    final List<String> indexList = [];
    for (int i = 0; i < multiColorModel.length; i++) {
      if (multiColorModel[i].isSelect.value) {
        indexList.add(i.toString());
      }
    }
    saveMultiColorSP("multiColor", indexList);
    update();
  }

  multipleColorSelection() {
    if (multiModel.isNotEmpty) {
      multiModel.clear();
    }
    for (int i = 0; i < multiColorModel.length; i++) {
      if (multiColorModel[i].isSelect.value == true) {
        multiModel.add(model[i]);
      }
    }
  }

  int selectRandomValue() {
    Random r = Random();
    return r.nextInt(singleColorModel.length - 1);
  }

  rainbowSelector() {
    for (int i = 0; i < multiColorModel.length; i++) {
      if (i < 6) {
        multiColorModel[i].isSelect.value = true;
      } else {
        multiColorModel[i].isSelect.value = false;
      }
    }
    final List<String> indexList = [];
    for (int i = 0; i < multiColorModel.length; i++) {
      if (multiColorModel[i].isSelect.value) {
        indexList.add(i.toString());
      }
    }
    saveMultiColorSP("multiColor", indexList);
    update();
  }

  selectAudioFirst(int index) async {
    for (int i = 0; i < firstmultiAudioModel.length; i++) {
      firstmultiAudioModel[i].isSelect.value = false;
    }
    firstmultiAudioModel[index].isSelect.value = true;

    final sp = await SharedPreferences.getInstance();
    await sp.setInt('singleColorAudio', index);

    // audioA = firstmultiAudioModel[index].value;
    update();
  }

  selectAudioSecond(int index) {
    for (int i = 0; i < secondmultiAudioModel.length; i++) {
      secondmultiAudioModel[i].isSelect.value = false;
    }
    secondmultiAudioModel[index].isSelect.value = true;
    update();
  }

  selectAudioThird(int index) {
    for (int i = 0; i < thirdmultiAudioModel.length; i++) {
      thirdmultiAudioModel[i].isSelect.value = false;
    }
    thirdmultiAudioModel[index].isSelect.value = true;
    update();
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }
}
