// ignore_for_file: empty_catches

import 'dart:async';
import 'dart:io';

import 'package:demo1212/appStyle/app_color.dart';
import 'package:demo1212/appStyle/app_dimension.dart';
import 'package:demo1212/appStyle/app_theme_style.dart';
import 'package:demo1212/appStyle/assets_images.dart';
import 'package:demo1212/navigation/app_route_maps.dart';
import 'package:demo1212/pages/HomePage/home_page_controller.dart';
import 'package:demo1212/utils/app_strings.dart';
import 'package:demo1212/utils/dotted_line.dart';
import 'package:floating_bubbles/floating_bubbles.dart';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/CustomShowcaseWidget.dart';
import '../../widget/ad_helper.dart';
import '../../widget/oval_top_clipper.dart';

import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final bool _kAutoConsume = Platform.isIOS || true;

const String _kConsumableId = 'com.app.product';
const List<String> _kProductIds = <String>[
  _kConsumableId,
];

class _HomePageState extends State<HomePage> {
  // late StreamSubscription<List<PurchaseDetails>> _subscription;
  var bannerAd;
  // late InterstitialAd interstitialAd;
  late RewardedAd rewardedAd;
  bool isBannerAdReady = false;

  //InterstitialAd? interstitialAd;
  // bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;

  bool colorSelectValSingle = false;
  bool audioSelectValSingle = false;

  bool colorSelectValMulti = false;
  bool audioSelectValMulti = false;

  bool colorSelectValLava = false;
  bool audioSelectValLava = false;

  bool inAppVal = false;

  var dsh = Get.isRegistered<HomePageController>()
      ? Get.find<HomePageController>()
      : Get.put(HomePageController());
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  final keyFive = GlobalKey();
  late BuildContext contextCustom;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<PurchaseDetails> purchaseDetailsList = <PurchaseDetails>[];

  @override
  void initState() {
    dsh.onInit();
    super.initState();
    MobileAds.instance.initialize();

    ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) {
      ShowCaseWidget.of(contextCustom).startShowCase([
        keyOne,
        keyTwo,
        keyThree,
        keyFour,
        keyFive,
      ]);
    });

    bannerAd = BannerAd(
        // Change Banner Size According to Ur Need
        size: AdSize.largeBanner,
        adUnitId: AdHelper.bannerAdUnitId,
        // adUnitId: AdHelper.bannerAdUnitId,
        //"ca-app-pub-3906841028286221/8591736738",
        //adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(onAdLoaded: (_) {
          isBannerAdReady = true;
          print("abcdefgh");
          //update();
        }, onAdFailedToLoad: (ad, LoadAdError error) {
          if (kDebugMode) {
            print(
                "Failed to Load A Banner Ad${error.message} => ${error.code}");
          }
          isBannerAdReady = false;
          ad.dispose();
        }),
        request: AdRequest());
    bannerAd.load();

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {});
    initStoreInfo();

    getLastPurchase();
    super.initState();
  }

  Future<void> getLastPurchase() async {
    final prefs = await SharedPreferences.getInstance();
    inAppVal = prefs.getBool('inAppPurchased') ?? false;
    setState(() {});
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      setState(() {});
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
      });
    }
  }

  Future<void> _listenToPurchaseUpdated(purchaseDetailsList) async {
    print("purchaseDetailsList $purchaseDetailsList");
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      print("purchaseDetails $purchaseDetails");
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("PurchaseStatus.pending ${PurchaseStatus.pending}");
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        print("PurchaseStatus.error ${PurchaseStatus.error}");
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        print("PurchaseStatus.status ${purchaseDetails.status}");

        //--------------------------------
        // if (purchaseDetails.status == PurchaseStatus.purchased) {
        //   final prefs = await SharedPreferences.getInstance();
        //   prefs.setBool("inPurchased", true);
        // }
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("inAppPurchased", true);
          inAppVal = prefs.getBool('inAppPurchased')!;
          setState(() {});
          print("Purchase detale status ${purchaseDetails.status} ");
        }

        //----------------------------------
        final bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          deliverProduct(purchaseDetails);
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }
      }
      if (Platform.isAndroid) {
        if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (controller) {
      // print("sdfjhsdjf ${controller.singleColorModel.length}");
      return Container(
        color: AppColors.colorBlueDark,
        child: SafeArea(
          top: true,

          // bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.colorBlueDark,
            appBar: AppBar(
              elevation: 0,
              //title:Image(image: AssetImage(AssetsBase.splashlight)),
              title: const Text("Night Lamp"),
              centerTitle: true,
              backgroundColor: AppColors.colorBlueDark,
              actions: [
                //Image(image: AssetImage(AssetsBase.splashlight,), height: 10,),
                Container(
                  padding: EdgeInsets.all(7),
                  height: AppDimensions.fiftyFive,
                  width: AppDimensions.fiftyFive,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.colorBlueDark),
                  child: const Image(
                    image: AssetImage(AssetsBase.splashlight),
                  ),
                ),
              ],
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                      height: AppDimensions.eighty,
                      width: double.infinity,
                      decoration:
                          const BoxDecoration(color: AppColors.colorBlueDark),
                      child: Row(
                        children: [
                          DrawerHeader(
                            decoration: const BoxDecoration(
                                color: AppColors.colorBlueDark),
                            child: Row(
                              children: [
                                Container(
                                  height: AppDimensions.fifty,
                                  width: AppDimensions.fifty,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColors.colorBlack),
                                  child: const Image(
                                      image:
                                          AssetImage(AssetsBase.splashlight)),
                                ),
                                SizedBox(
                                  width: AppDimensions.twenty,
                                ),
                                Text(
                                  AppStrings.navigationDrawerHeader,
                                  style: AppThemeStyles.whiteLight,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  ListTile(
                    leading: SizedBox(
                        height: AppDimensions.twenty,
                        width: AppDimensions.twenty,
                        child: Image.asset(AssetsBase.aboutIcon)),
                    title: Text(
                      AppStrings.about,
                      textScaleFactor: AppDimensions.onepointtwo,
                    ),
                    onTap: () {
                      launch('https://nightlamp.worksdelight.com/about.html');
                      // AppRouteMaps.goToHtmlPageView();
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                        height: AppDimensions.twenty,
                        width: AppDimensions.twenty,
                        child: Image.asset(AssetsBase.help_Icon)),
                    title: Text(
                      AppStrings.contactUs,
                      textScaleFactor: AppDimensions.onepointtwo,
                    ),
                    onTap: () {
                      // launch(
                      //   'https://worksdelight.com/contact/',
                      // );
                      AppRouteMaps.goToContactUsPage();
                    },
                  ),

                  ListTile(
                    leading: SizedBox(
                        //MediaQuery.of(context).size.height*0.3
                        height: AppDimensions.twenty,
                        width: AppDimensions.twenty,
                        child: Image.asset(AssetsBase.share_Icon)),
                    title: Text(
                      AppStrings.share,
                      textScaleFactor: AppDimensions.onepointtwo,
                    ),
                    onTap: () {
                      if (Platform.isAndroid) {
                        share(
                            "https://play.google.com/store/apps/details?id=com.app.nightlight",
                            "");
                      } else {
                        share(
                            "https://apps.apple.com/in/app/com.app.nightlight/id6443600387",
                            "");
                      }
                    },
                  ),
                  ListTile(
                    leading: SizedBox(
                        height: AppDimensions.twenty,
                        width: AppDimensions.twenty,
                        child: Image.asset(AssetsBase.setting_Icon)),
                    title: GestureDetector(
                      onTap: () async {
                        var result =
                            await AppRouteMaps.gotoSettingPage().then((value) {
                          // print("value...$value");
                          controller.getSharedPrefenceValue();
                        });
                      },
                      child: Text(
                        AppStrings.setting,
                        textScaleFactor: AppDimensions.onepointtwo,
                      ),
                    ),
                    // onTap: () {},
                  ),
                  // !inAppVal ?
                  ListTile(
                    leading: SizedBox(
                        height: AppDimensions.twenty,
                        width: AppDimensions.twenty,
                        child: Image.asset(AssetsBase.removead)),
                    title: Text(
                      AppStrings.skipAd,
                      textScaleFactor: AppDimensions.onepointtwo,
                    ),
                    onTap: () async {
                      // late PurchaseParam purchaseParam;

                      // if (Platform.isAndroid) {
                      //   purchaseParam = GooglePlayPurchaseParam(
                      //     productDetails: _products[0],
                      //   );
                      // } else {
                      //   purchaseParam = PurchaseParam(
                      //     productDetails: _products[0],
                      //   );
                      // }

                      // if (_products[0].id == _kConsumableId) {
                      //   _inAppPurchase.buyConsumable(
                      //       purchaseParam: purchaseParam,
                      //       autoConsume: _kAutoConsume);
                      // } else {
                      //   _inAppPurchase.buyNonConsumable(
                      //       purchaseParam: purchaseParam);
                      // }
                      // controller.removeAds_dialog();
                       AppRouteMaps.goToRemoveAdsPage();
                    },
                  ),
                  // : ListTile(
                  //     leading: SizedBox(
                  //         height: AppDimensions.twenty,
                  //         width: AppDimensions.twenty,
                  //         child: Image.asset(AssetsBase.restore_purchase)),
                  //     title: Text(
                  //       "Restore Purchase",
                  //       textScaleFactor: AppDimensions.onepointtwo,
                  //     ),
                  //     onTap: () async {},
                  //   ),
                  const Spacer(),
                  RichText(
                    text: TextSpan(
                      text: AppStrings.version,
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: controller.packageInfo.version,
                        ),
                      ],
                    ),
                  ),
                  //Text(controller.packageInfo.version),
                  SizedBox(height: AppDimensions.twenty),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  ShowCaseWidget(
                    onFinish: () async {
                      final pref = await SharedPreferences.getInstance();
                      pref.setString("tapClick", "1");
                      controller.showCase = pref.getString("tapClick") ?? "";
                      controller.update();
                    },
                    builder: Builder(builder: (context) {
                      contextCustom = context;
                      return Column(
                        children: [
                          !inAppVal
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: AdWidget(
                                    ad: bannerAd,
                                  ),
                                )
                              : controller.selectColor == 0
                                  ? Container(
                                      height: 60,
                                    )
                                  : Container(),

                          SizedBox(
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                          // const Spacer(),

                          Container(
                            height: controller.selectColor == 0
                                ? MediaQuery.of(context).size.height / 2.3
                                : MediaQuery.of(context).size.height / 1.9,
                            margin: EdgeInsets.only(
                                left: AppDimensions.fifTeen,
                                right: AppDimensions.fifTeen),
                            padding: EdgeInsets.only(
                                top: AppDimensions.twenty,
                                left: AppDimensions.twenty,
                                right: AppDimensions.twenty,
                                bottom: AppDimensions.ten),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.thirty)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: AppDimensions.ten,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          controller.select =
                                              AppStrings.simpleLight;
                                          controller.selectColor = 0;
                                          controller.update();
                                          if (controller.val == "true") {
                                            controller.playButton();
                                            controller.update();
                                          }
                                        },
                                        child: controller.showCase == "1"
                                            ? Container(
                                                //key:keyOne,
                                                padding: EdgeInsets.all(
                                                    AppDimensions.eighteen),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimensions.ten),
                                                    border: Border.all(
                                                        color: controller
                                                                    .selectColor ==
                                                                0
                                                            ? Colors.black
                                                            : Colors.white70)),
                                                child: Image.asset(
                                                  AssetsBase.white_light,
                                                  height: AppDimensions.fifty,
                                                  width: AppDimensions.fifty,
                                                ),
                                              )
                                            : CustomShowcaseWidget(
                                                globalKey: keyOne,
                                                description: 'For Single Color',
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      AppDimensions.eighteen),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimensions
                                                                  .ten),
                                                      border: Border.all(
                                                          color: controller
                                                                      .selectColor ==
                                                                  0
                                                              ? Colors.black
                                                              : Colors
                                                                  .white70)),
                                                  child: Image.asset(
                                                    AssetsBase.white_light,
                                                    height: AppDimensions.fifty,
                                                    width: AppDimensions.fifty,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // print("object");
                                          controller.select = "RainbowLight";
                                          controller.selectColor = 1;
                                          controller.update();
                                          if (controller.val == "true") {
                                            controller.playButton();
                                            controller.update();
                                          }
                                        },
                                        child: controller.showCase == "1"
                                            ? Container(
                                                padding: EdgeInsets.all(
                                                    AppDimensions.eighteen),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimensions.ten),
                                                    border: Border.all(
                                                        color: controller
                                                                    .selectColor ==
                                                                1
                                                            ? Colors.black
                                                            : Colors.white70)),
                                                child: Image.asset(
                                                  AssetsBase.multicolor_light,
                                                  height: AppDimensions.fifty,
                                                  width: AppDimensions.fifty,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  final pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  pref.setString(
                                                      "tapClick", "1");
                                                },
                                                child: CustomShowcaseWidget(
                                                  globalKey: keyTwo,
                                                  description:
                                                      'For Multiple Color',
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        AppDimensions.eighteen),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppDimensions
                                                                        .ten),
                                                        border: Border.all(
                                                            color: controller
                                                                        .selectColor ==
                                                                    1
                                                                ? Colors.black
                                                                : Colors
                                                                    .white70)),
                                                    child: Image.asset(
                                                      AssetsBase
                                                          .multicolor_light,
                                                      height:
                                                          AppDimensions.fifty,
                                                      width:
                                                          AppDimensions.fifty,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          controller.select = "YellowLight";
                                          controller.selectColor = 2;
                                          controller.update();
                                          if (controller.val == "true") {
                                            controller.playButton();
                                            controller.update();
                                          }
                                        },
                                        child: controller.showCase == "1"
                                            ? Container(
                                                padding: EdgeInsets.all(
                                                    AppDimensions.eighteen),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimensions.ten),
                                                    border: Border.all(
                                                        color: controller
                                                                    .selectColor ==
                                                                2
                                                            ? Colors.black
                                                            : Colors.white70)),
                                                child: Image.asset(
                                                  AssetsBase.gradientlight,
                                                  height: AppDimensions.fifty,
                                                  width: AppDimensions.fifty,
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  final pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  pref.setString(
                                                      "tapClick", "1");
                                                  controller.onInit();
                                                },
                                                child: CustomShowcaseWidget(
                                                  globalKey: keyThree,
                                                  description:
                                                      'For Gradient Color',
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        AppDimensions.eighteen),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white70,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppDimensions
                                                                        .ten),
                                                        border: Border.all(
                                                            color: controller
                                                                        .selectColor ==
                                                                    2
                                                                ? Colors.black
                                                                : Colors
                                                                    .white70)),
                                                    child: Image.asset(
                                                      AssetsBase.gradientlight,
                                                      height:
                                                          AppDimensions.fifty,
                                                      width:
                                                          AppDimensions.fifty,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                controller.selectColor == 0
                                    ? Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              "Night Light Duration",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.decrement();

                                                  if (controller.val ==
                                                      "true") {
                                                    controller.playButtonB();
                                                    controller.update();
                                                  }
                                                },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 7),
                                                  child: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  padding: EdgeInsets.all(8),
                                                  backgroundColor: AppColors
                                                      .colorBlueDark, // <-- Button color
                                                  foregroundColor: Colors
                                                      .blue, // <-- Splash color
                                                ),
                                              ),
                                              // const SizedBox(
                                              //   width: 10,
                                              // ),
                                              Expanded(
                                                child: Container(
                                                  height: AppDimensions.forty,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimensions
                                                                .twenty),
                                                    color:
                                                        AppColors.colorBlueDark,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${controller.mint} Mins",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .colorWhite),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: AppDimensions.ten,
                                              // ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.increment();
                                                  // controller.playButtonB();
                                                  // controller.update();

                                                  if (controller.val ==
                                                      "true") {
                                                    controller.playButtonB();
                                                    controller.update();
                                                  }
                                                },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  padding: EdgeInsets.all(8),
                                                  backgroundColor: AppColors
                                                      .colorBlueDark, // <-- Button color
                                                  foregroundColor: Colors
                                                      .blue, // <-- Splash color
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: AppDimensions.ten,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                        title: '',
                                                        content: Column(
                                                          children: [
                                                            Text(
                                                              AppStrings
                                                                  .moodLightColor,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  AppDimensions
                                                                      .ten,
                                                            ),
                                                            const DotteLine(
                                                              linecolor: Color
                                                                  .fromRGBO(
                                                                      61,
                                                                      61,
                                                                      61,
                                                                      0.4),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  AppDimensions
                                                                      .ten,
                                                            ),
                                                            Obx(
                                                              () => Wrap(
                                                                children: [
                                                                  for (int index =
                                                                          0;
                                                                      index <
                                                                          controller
                                                                              .singleColorModel
                                                                              .length;
                                                                      index++)
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          colorSelectValSingle =
                                                                              false;
                                                                        });
                                                                        controller
                                                                            .changeColorState(index);
                                                                        controller.singlecolor = controller
                                                                            .singleColorModel[index]
                                                                            .colorName!;
                                                                        for (int i =
                                                                                0;
                                                                            i < controller.singleColorModel.length;
                                                                            i++) {
                                                                          if (controller.singlecolor ==
                                                                              controller.singleColorModel[i].colorName!) {
                                                                            controller.singleColorModel[i].isSelect.value =
                                                                                true;
                                                                          } else {
                                                                            controller.singleColorModel[i].isSelect.value =
                                                                                false;
                                                                          }
                                                                        }
                                                                        controller.spColorandAudio(
                                                                            'singleColor',
                                                                            index);

                                                                        //controller.saveColorandAudioSP('singleColor', index);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            AppDimensions.margin0_5_5_5,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              AppDimensions.thirtyFive,
                                                                          width:
                                                                              AppDimensions.thirtyFive,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: controller.singleColorModel[index].colorName),
                                                                          child: controller.singleColorModel[index].isSelect.value
                                                                              ? const Icon(
                                                                                  Icons.check,
                                                                                  color: Colors.white,
                                                                                )
                                                                              : Container(),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            const DotteLine(
                                                              linecolor: Color
                                                                  .fromRGBO(
                                                                      61,
                                                                      61,
                                                                      61,
                                                                      0.4),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    controller.changeColorStateForSingle(
                                                                        controller
                                                                            .selectRandomValue());
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: AppDimensions
                                                                            .twenty,
                                                                        top: AppDimensions
                                                                            .ten),
                                                                    padding: EdgeInsets.all(
                                                                        AppDimensions
                                                                            .five),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    child: Text(
                                                                      AppStrings
                                                                          .random,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();

                                                                if (controller
                                                                        .val ==
                                                                    "true") {
                                                                  controller
                                                                      .playButtonB();
                                                                  controller
                                                                      .update();
                                                                }
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: AppColors
                                                                      .colorBlueDark,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              AppDimensions.twenty))),
                                                              child: Text(
                                                                AppStrings.ok,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                                  },
                                                  child: controller.showCase ==
                                                          "1"
                                                      ? Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 13,
                                                                      right: 13,
                                                                      bottom:
                                                                          3),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: colorSelectValSingle
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .transparent,
                                                                    width: 5),
                                                              ),
                                                              child:
                                                                  Image.asset(
                                                                AssetsBase
                                                                    .color_picker,
                                                                height:
                                                                    AppDimensions
                                                                        .thirty,
                                                                width:
                                                                    AppDimensions
                                                                        .thirty,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                if (controller
                                                                        .singlecolor !=
                                                                    null)
                                                                  Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration: BoxDecoration(
                                                                        color: controller
                                                                            .singlecolor,
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(50))),
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : CustomShowcaseWidget(
                                                          globalKey: keyFour,
                                                          description: AppStrings
                                                              .colorSelection,
                                                          child: Image.asset(
                                                            AssetsBase
                                                                .color_picker,
                                                            height:
                                                                AppDimensions
                                                                    .thirty,
                                                            width: AppDimensions
                                                                .thirty,
                                                          ),
                                                        ),
                                                  //Text("Audio Selected", style: TextStyle(color: Colors.black),),
                                                ),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    Get.defaultDialog(
                                                        title: "",
                                                        content: Column(
                                                          children: [
                                                            Text(
                                                              AppStrings
                                                                  .background_sound,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  AppDimensions
                                                                      .ten,
                                                            ),
                                                            const DotteLine(
                                                              linecolor: Color
                                                                  .fromRGBO(
                                                                      61,
                                                                      61,
                                                                      61,
                                                                      0.4),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  4,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    controller
                                                                        .multiAudioModel
                                                                        .length,
                                                                shrinkWrap:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Padding(
                                                                      padding:
                                                                          AppDimensions
                                                                              .padding10_10_5_5,
                                                                      child: InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              audioSelectValSingle = false;
                                                                            });
                                                                            controller.selectAudioFirst(index);

                                                                            controller.spColorandAudio('singleAudio',
                                                                                index);
                                                                          },
                                                                          child: Obx(
                                                                            () =>
                                                                                Container(
                                                                              height: AppDimensions.fifty,
                                                                              width: double.infinity,
                                                                              color: controller.firstmultiAudioModel[index].isSelect.value == true ? AppColors.colorBlueDark : Colors.transparent,
                                                                              // ignore: unrelated_type_equality_checks
                                                                              child: Center(
                                                                                  child: Text(
                                                                                controller.firstmultiAudioModel[index].name,
                                                                                style: TextStyle(
                                                                                    // ignore: unrelated_type_equality_checks
                                                                                    color: controller.firstmultiAudioModel[index].isSelect.value == true ? AppColors.colorWhite : AppColors.blackColor),
                                                                              )),
                                                                            ),
                                                                          )));
                                                                },
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();

                                                                if (controller
                                                                        .val ==
                                                                    "true") {
                                                                  controller
                                                                      .playButtonB();
                                                                  controller
                                                                      .update();
                                                                }
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                  primary: AppColors
                                                                      .colorBlueDark,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              AppDimensions.twenty))),
                                                              child: Text(
                                                                AppStrings.ok,
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .colorWhite),
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                                  },
                                                  child:
                                                      controller.showCase == "1"
                                                          ? Column(
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 13,
                                                                      right: 13,
                                                                      bottom:
                                                                          3),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: audioSelectValSingle
                                                                              ? Colors.red
                                                                              : Colors.transparent,
                                                                          width: 5)),
                                                                  child: Image
                                                                      .asset(
                                                                    AssetsBase
                                                                        .music_select,
                                                                    height: AppDimensions
                                                                        .thirty,
                                                                    width: AppDimensions
                                                                        .thirty,
                                                                  ),
                                                                ),
                                                                // audioSelectVal
                                                                //     ? Text("")
                                                                //     : Text(
                                                                //         "Selected Audio",
                                                                //         style: TextStyle(
                                                                //             color: Colors
                                                                //                 .black),
                                                                //       ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    for (int i =
                                                                            0;
                                                                        i <
                                                                            controller
                                                                                .firstmultiAudioModel.length;
                                                                        i++)
                                                                      if (controller
                                                                          .firstmultiAudioModel[
                                                                              i]
                                                                          .isSelect
                                                                          .value)
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          color:
                                                                              Colors.transparent,
                                                                          child: Text(controller
                                                                              .firstmultiAudioModel[i]
                                                                              .name),
                                                                        ),
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                          : InkWell(
                                                              onTap: () async {
                                                                // print("showcase 5");
                                                                final pref =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                controller
                                                                        .showCase =
                                                                    pref.getString(
                                                                            "tapClick") ??
                                                                        "";
                                                                controller
                                                                    .update();
                                                              },
                                                              child:
                                                                  CustomShowcaseWidget(
                                                                globalKey:
                                                                    keyFive,
                                                                description:
                                                                    AppStrings
                                                                        .audioSelection,
                                                                child:
                                                                    Image.asset(
                                                                  AssetsBase
                                                                      .music_select,
                                                                  height:
                                                                      AppDimensions
                                                                          .thirty,
                                                                  width:
                                                                      AppDimensions
                                                                          .thirty,
                                                                ),
                                                              ),
                                                            ),

                                                  // InkWell(
                                                  //     onTap: () {
                                                  //       controller.update();
                                                  //     },
                                                  //         ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : controller.selectColor == 1
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                  height: AppDimensions.ten),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  "Night Light Frequency",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.decrementSec();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 7),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  Expanded(
                                                    child: Container(
                                                      height:
                                                          AppDimensions.forty,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppDimensions
                                                                    .twenty),
                                                        color: AppColors
                                                            .colorBlueDark,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${controller.sec} Sec",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.incrementSec();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    AppDimensions.twentyFive,
                                                child: const Text(
                                                  "Duration",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.decrement();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 7),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  Expanded(
                                                    child: Container(
                                                      height:
                                                          AppDimensions.forty,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppDimensions
                                                                    .twenty),
                                                        color: AppColors
                                                            .colorBlueDark,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${controller.mint} Mins",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.increment();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: AppDimensions.twelve,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        Get.defaultDialog(
                                                            title: '',
                                                            content: Column(
                                                              children: [
                                                                Text(
                                                                  AppStrings
                                                                      .moodLightColor,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      AppDimensions
                                                                          .ten,
                                                                ),
                                                                const DotteLine(
                                                                  linecolor: Color
                                                                      .fromRGBO(
                                                                          61,
                                                                          61,
                                                                          61,
                                                                          0.4),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      AppDimensions
                                                                          .ten,
                                                                ),
                                                                Obx(
                                                                  () => Wrap(
                                                                    children: [
                                                                      for (int index =
                                                                              0;
                                                                          index <
                                                                              controller.multiColorModel.length;
                                                                          index++)
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            colorSelectValMulti =
                                                                                false;
                                                                            controller.multiColorSelect(index);
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 5,
                                                                                right: 5,
                                                                                bottom: 5),
                                                                            child:
                                                                                Container(
                                                                              height: AppDimensions.thirtyFive,
                                                                              width: AppDimensions.thirtyFive,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: controller.multiColorModel[index].colorName),
                                                                              child: controller.multiColorModel[index].isSelect.value
                                                                                  ? const Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.white,
                                                                                    )
                                                                                  : Container(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const DotteLine(
                                                                  linecolor: Color
                                                                      .fromRGBO(
                                                                          61,
                                                                          61,
                                                                          61,
                                                                          0.4),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller
                                                                              .rainbowSelector();
                                                                          controller.isRainbowSelect =
                                                                              true;
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(AppDimensions.five),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(AppDimensions.twenty),
                                                                            border:
                                                                                Border.all(color: Colors.black),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            AppStrings.rainbow,
                                                                            style:
                                                                                const TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();

                                                                    if (controller
                                                                            .val ==
                                                                        "true") {
                                                                      controller
                                                                          .playButtonB();
                                                                      controller
                                                                          .update();
                                                                    }
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          AppColors
                                                                              .colorBlueDark,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(AppDimensions.twenty))),
                                                                  child: Text(
                                                                    AppStrings
                                                                        .ok,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              ],
                                                            ));
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3,
                                                                    left: 13,
                                                                    right: 13,
                                                                    bottom: 3),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: colorSelectValMulti
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .transparent,
                                                                    width: 5)),
                                                            child: Image.asset(
                                                              AssetsBase
                                                                  .color_picker,
                                                              height:
                                                                  AppDimensions
                                                                      .thirty,
                                                              width:
                                                                  AppDimensions
                                                                      .thirty,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              for (int i = 0;
                                                                  i <
                                                                      controller
                                                                          .multiColorModel
                                                                          .length;
                                                                  i++)
                                                                if (controller
                                                                    .multiColorModel[
                                                                        i]
                                                                    .isSelect
                                                                    .value)
                                                                  Container(
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration: BoxDecoration(
                                                                        color: controller
                                                                            .multiColorModel[
                                                                                i]
                                                                            .colorName!,
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(50))),
                                                                  ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Get.defaultDialog(
                                                              title: "",
                                                              content: Column(
                                                                children: [
                                                                  Text(
                                                                    AppStrings
                                                                        .background_sound,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        AppDimensions
                                                                            .ten,
                                                                  ),
                                                                  const DotteLine(
                                                                    linecolor: Color
                                                                        .fromRGBO(
                                                                            61,
                                                                            61,
                                                                            61,
                                                                            0.4),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        4,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: controller
                                                                          .multiAudioModel
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Padding(
                                                                            padding:
                                                                                AppDimensions.padding10_10_5_5,
                                                                            child: InkWell(
                                                                                onTap: () {
                                                                                  audioSelectValMulti = false;
                                                                                  controller.selectAudioSecond(index);
                                                                                  controller.spColorandAudio('multiAudio', index);
                                                                                },
                                                                                child: Obx(
                                                                                  () => Container(
                                                                                    height: AppDimensions.fifty,
                                                                                    width: double.infinity,

                                                                                    color: controller.secondmultiAudioModel[index].isSelect.value == true ? AppColors.colorBlueDark : Colors.transparent,
                                                                                    // ignore: unrelated_type_equality_checks
                                                                                    child: Center(
                                                                                        child: Text(
                                                                                      controller.secondmultiAudioModel[index].name,
                                                                                      style: TextStyle(
                                                                                          // ignore: unrelated_type_equality_checks
                                                                                          color: controller.secondmultiAudioModel[index].isSelect.value == true ? Colors.white : AppColors.blackColor),
                                                                                    )),
                                                                                  ),
                                                                                )));
                                                                      },
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();

                                                                      if (controller
                                                                              .val ==
                                                                          "true") {
                                                                        controller
                                                                            .playButtonB();
                                                                        controller
                                                                            .update();
                                                                      }
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            AppColors
                                                                                .colorBlueDark,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(AppDimensions.twenty))),
                                                                    child: Text(
                                                                      AppStrings
                                                                          .ok,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              AppColors.colorWhite),
                                                                    ),
                                                                  )
                                                                ],
                                                              ));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 13,
                                                                      right: 13,
                                                                      bottom:
                                                                          3),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: audioSelectValMulti
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .transparent,
                                                                      width:
                                                                          5)),
                                                              child:
                                                                  Image.asset(
                                                                AssetsBase
                                                                    .music_select,
                                                                height:
                                                                    AppDimensions
                                                                        .thirty,
                                                                width:
                                                                    AppDimensions
                                                                        .thirty,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                for (int i = 0;
                                                                    i <
                                                                        controller
                                                                            .secondmultiAudioModel
                                                                            .length;
                                                                    i++)
                                                                  if (controller
                                                                      .secondmultiAudioModel[
                                                                          i]
                                                                      .isSelect
                                                                      .value)
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      color: Colors
                                                                          .transparent,
                                                                      child: Text(controller
                                                                          .secondmultiAudioModel[
                                                                              i]
                                                                          .name),
                                                                    ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(
                                                  height: AppDimensions.ten),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 5.0),
                                                child: Text(
                                                  "Night Light Frequency",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .screenselectdecrement();
                                                      controller.update();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 7),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.five,
                                                  // ),
                                                  Expanded(
                                                    child: Container(
                                                      height:
                                                          AppDimensions.forty,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppDimensions
                                                                    .twenty),
                                                        color: AppColors
                                                            .colorBlueDark,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${controller.screens[controller.sc].screenName.toString()}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .screenselectincrement();
                                                      controller.update();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    AppDimensions.twentyFive,
                                                child: const Text(
                                                  "Duration",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.decrement();
                                                      controller.update();

                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 7),
                                                      child: Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  Expanded(
                                                    child: Container(
                                                      height:
                                                          AppDimensions.forty,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppDimensions
                                                                    .twenty),
                                                        color: AppColors
                                                            .colorBlueDark,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${controller.mint} Mins",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: AppDimensions.ten,
                                                  // ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller.increment();
                                                      if (controller.val ==
                                                          "true") {
                                                        controller
                                                            .playButtonB();
                                                        controller.update();
                                                      }
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      backgroundColor: AppColors
                                                          .colorBlueDark, // <-- Button color
                                                      foregroundColor: Colors
                                                          .blue, // <-- Splash color
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: AppDimensions.five,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        Get.defaultDialog(
                                                            title: '',
                                                            content: Column(
                                                              children: [
                                                                Text(
                                                                  AppStrings
                                                                      .moodLightColor,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      AppDimensions
                                                                          .ten,
                                                                ),
                                                                const DotteLine(
                                                                  linecolor: Color
                                                                      .fromRGBO(
                                                                          61,
                                                                          61,
                                                                          61,
                                                                          0.4),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      AppDimensions
                                                                          .ten,
                                                                ),
                                                                Obx(
                                                                  () => Wrap(
                                                                    children: [
                                                                      for (int index =
                                                                              0;
                                                                          index <
                                                                              controller.singleColorModelLava.length;
                                                                          index++)
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            colorSelectValLava =
                                                                                false;
                                                                            controller.changeColorState(index);
                                                                            controller.singleColorLava =
                                                                                controller.singleColorModelLava[index].colorName!;
                                                                            for (int i = 0;
                                                                                i < controller.singleColorModelLava.length;
                                                                                i++) {
                                                                              if (controller.singleColorLava == controller.singleColorModelLava[i].colorName!) {
                                                                                controller.singleColorModelLava[i].isSelect.value = true;
                                                                              } else {
                                                                                controller.singleColorModelLava[i].isSelect.value = false;
                                                                              }
                                                                            }

                                                                            controller.saveColorAndAudioSP('lavaColor',
                                                                                index);
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                AppDimensions.margin0_5_5_5,
                                                                            child:
                                                                                Container(
                                                                              height: AppDimensions.thirtyFive,
                                                                              width: AppDimensions.thirtyFive,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: controller.singleColorModelLava[index].colorName),
                                                                              child: controller.singleColorModelLava[index].isSelect.value
                                                                                  ? const Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.white,
                                                                                    )
                                                                                  : Container(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const DotteLine(
                                                                  linecolor: Color
                                                                      .fromRGBO(
                                                                          61,
                                                                          61,
                                                                          61,
                                                                          0.4),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .changeColorStateForLava(controller.selectRandomValue());
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                AppDimensions.twenty,
                                                                            top: AppDimensions.ten),
                                                                        padding:
                                                                            EdgeInsets.all(AppDimensions.five),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                          border:
                                                                              Border.all(color: Colors.black),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          AppStrings
                                                                              .random,
                                                                          style:
                                                                              const TextStyle(color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();

                                                                    if (controller
                                                                            .val ==
                                                                        "true") {
                                                                      controller
                                                                          .playButtonB();
                                                                      controller
                                                                          .update();
                                                                    }
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          AppColors
                                                                              .colorBlueDark,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(AppDimensions.twenty))),
                                                                  child: Text(
                                                                    AppStrings
                                                                        .ok,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                )
                                                              ],
                                                            ));
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3,
                                                                    left: 13,
                                                                    right: 13,
                                                                    bottom: 3),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: colorSelectValLava
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .transparent,
                                                                    width: 5)),
                                                            child: Image.asset(
                                                              AssetsBase
                                                                  .color_picker,
                                                              height:
                                                                  AppDimensions
                                                                      .thirty,
                                                              width:
                                                                  AppDimensions
                                                                      .thirty,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              if (controller
                                                                      .singleColorLava !=
                                                                  null)
                                                                Container(
                                                                  height: 12,
                                                                  width: 12,
                                                                  decoration: BoxDecoration(
                                                                      color: controller
                                                                          .singleColorLava!,
                                                                      borderRadius: const BorderRadius
                                                                              .all(
                                                                          Radius.circular(
                                                                              50))),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Get.defaultDialog(
                                                              title: "",
                                                              content: Column(
                                                                children: [
                                                                  Text(
                                                                    AppStrings
                                                                        .background_sound,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        AppDimensions
                                                                            .ten,
                                                                  ),
                                                                  const DotteLine(
                                                                    linecolor: Color
                                                                        .fromRGBO(
                                                                            61,
                                                                            61,
                                                                            61,
                                                                            0.4),
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        4,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: controller
                                                                          .multiAudioModel
                                                                          .length,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Padding(
                                                                            padding:
                                                                                AppDimensions.padding10_10_5_5,
                                                                            child: InkWell(
                                                                                onTap: () {
                                                                                  audioSelectValLava = false;
                                                                                  controller.selectAudioThird(index);
                                                                                  controller.saveColorAndAudioSP('lavaAudio', index);
                                                                                },
                                                                                child: Obx(
                                                                                  () => Container(
                                                                                    height: AppDimensions.fifty,
                                                                                    width: double.infinity,

                                                                                    // ignore: unrelated_type_equality_checks
                                                                                    color: controller.thirdmultiAudioModel[index].isSelect.value == true ? AppColors.colorBlueDark : Colors.transparent,
                                                                                    // ignore: unrelated_type_equality_checks
                                                                                    child: Center(
                                                                                        child: Text(
                                                                                      controller.thirdmultiAudioModel[index].name,
                                                                                      style: TextStyle(
                                                                                          // ignore: unrelated_type_equality_checks
                                                                                          color: controller.thirdmultiAudioModel[index].isSelect.value == true ? AppColors.colorWhite : AppColors.blackColor),
                                                                                    )),
                                                                                  ),
                                                                                )));
                                                                      },
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();

                                                                      if (controller
                                                                              .val ==
                                                                          "true") {
                                                                        controller
                                                                            .playButtonB();
                                                                        controller
                                                                            .update();
                                                                      }
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            AppColors
                                                                                .colorBlueDark,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(AppDimensions.twenty))),
                                                                    child: Text(
                                                                      AppStrings
                                                                          .ok,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )
                                                                ],
                                                              ));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 13,
                                                                      right: 13,
                                                                      bottom:
                                                                          3),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: audioSelectValLava
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .transparent,
                                                                      width:
                                                                          5)),
                                                              child:
                                                                  Image.asset(
                                                                AssetsBase
                                                                    .music_select,
                                                                height:
                                                                    AppDimensions
                                                                        .thirty,
                                                                width:
                                                                    AppDimensions
                                                                        .thirty,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                for (int i = 0;
                                                                    i <
                                                                        controller
                                                                            .thirdmultiAudioModel
                                                                            .length;
                                                                    i++)
                                                                  if (controller
                                                                      .thirdmultiAudioModel[
                                                                          i]
                                                                      .isSelect
                                                                      .value)
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      color: Colors
                                                                          .transparent,
                                                                      child: Text(controller
                                                                          .thirdmultiAudioModel[
                                                                              i]
                                                                          .name),
                                                                    ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                              ],
                            ),
                          ),
                          // const Spacer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),

                          Container(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: AppDimensions.forty,
                                    width: AppDimensions.hundredeighty,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (controller.val == "true") {
                                            controller.playButtonB();
                                            controller.update();
                                          }
                                          if (controller.selectColor == 0) {
                                            if (!controller
                                                .checkColorModelSingle()) {
                                              Fluttertoast.showToast(
                                                  msg: "Please Select Color !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                colorSelectValSingle = true;
                                              });
                                            } else if (!controller
                                                .checkAudioModelSingle()) {
                                              Fluttertoast.showToast(
                                                  msg: "Please Select Audio !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                colorSelectValSingle = false;
                                                audioSelectValSingle = true;
                                              });
                                            } else {
                                              // print(
                                              //     'isInterstitialAdReady $isInterstitialAdReady');
                                              if (!inAppVal) {
                                                try {
                                                  if (controller
                                                      .isInterstitialAdReady) {
                                                    controller.interstitialAd
                                                        ?.show()
                                                        .then((value) {
                                                      controller
                                                          .interstitialaddsfunc();
                                                    });
                                                  }
                                                } catch (e) {
                                                  print('e ${e.toString()}');
                                                }
                                              }

                                              AppRouteMaps.gotoColorPick(
                                                  controller
                                                      .getSelectedColor()!,
                                                  controller
                                                      .getSelectedAudio()!,
                                                  controller.mint);
                                              setState(() {
                                                colorSelectValSingle = false;
                                                audioSelectValSingle = false;
                                                controller
                                                        .isInterstitialAdReady =
                                                    true;
                                                // print("Add Loaded");
                                              });
                                            }
                                          } else if (controller.selectColor ==
                                              1) {
                                            if (!controller
                                                .checkColorModelMulti()) {
                                              Fluttertoast.showToast(
                                                  msg: "Please Select Color !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                colorSelectValMulti = true;
                                              });
                                            } else if (!controller
                                                .checkAudioModelMulti()) {
                                              Fluttertoast.showToast(
                                                  msg: "Please Select Audio !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                colorSelectValMulti = false;
                                                audioSelectValMulti = true;
                                              });
                                            } else {
                                              if (!inAppVal) {
                                                try {
                                                  print(
                                                      'isInterstitialAdReady $controller.isInterstitialAdReady');
                                                  if (controller
                                                      .isInterstitialAdReady) {
                                                    controller.interstitialAd
                                                        ?.show()
                                                        .then((value) {
                                                      controller
                                                          .interstitialaddsfunc();
                                                    }).onError((error,
                                                            stackTrace) {
                                                      print(
                                                          'error ${error.toString()}');
                                                    });
                                                  }
                                                } catch (e) {}
                                              }

                                              controller
                                                  .multipleColorSelection();
                                              AppRouteMaps.gotoColorPick1(
                                                  controller.isRainbowSelect ==
                                                          true
                                                      ? controller
                                                          .multiModel.reversed
                                                          .toList()
                                                      : controller.multiModel,
                                                  controller
                                                      .getSelectedAudioMulti()!,
                                                  controller.mint,
                                                  controller.sec);

                                              setState(() {
                                                controller
                                                        .isInterstitialAdReady =
                                                    true;
                                                colorSelectValMulti = false;
                                                audioSelectValMulti = false;
                                              });
                                            }
                                          } else {
                                            if (!controller
                                                .checkColorModelLava()) {
                                              Fluttertoast.showToast(
                                                  msg: "Please Select Color !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                colorSelectValLava = true;
                                              });
                                            } else if (!controller
                                                .checkAudioModelLava()) {
                                              Fluttertoast.showToast(
                                                  msg: "Please Select Audio !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                              setState(() {
                                                colorSelectValLava = false;
                                                audioSelectValLava = true;
                                              });
                                            } else {
                                              if (!inAppVal) {
                                                try {
                                                  print(
                                                      'isInterstitialAdReady $controller.isInterstitialAdReady');
                                                  if (controller
                                                      .isInterstitialAdReady) {
                                                    controller.interstitialAd
                                                        ?.show()
                                                        .then((value) {
                                                      controller
                                                          .interstitialaddsfunc();
                                                    });
                                                  }
                                                } catch (e) {}
                                              }

                                              controller.selectedScreen =
                                                  controller
                                                      .screens[controller.sc]
                                                      .screenName
                                                      .toString();
                                              controller.selectedScreenType =
                                                  controller
                                                      .screens[controller.sc]
                                                      .screenType
                                                      .toString();

                                              controller.selectedScreenValue =
                                                  controller
                                                      .screens[controller.sc]
                                                      .screenValue
                                                      .toString();
                                              AppRouteMaps.goToLavaPage(
                                                  controller
                                                      .getSelectedColorLava()!,
                                                  controller.selectedScreen,
                                                  controller.selectedScreenType,
                                                  controller
                                                      .selectedScreenValue,
                                                  controller
                                                      .getSelectedAudioLava()!,
                                                  controller.mint);
                                              setState(() {
                                                controller
                                                        .isInterstitialAdReady =
                                                    true;
                                                colorSelectValLava = false;
                                                audioSelectValLava = false;
                                              });
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromARGB(255, 15, 183, 6),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            padding: const EdgeInsets.all(10)),
                                        child: Text(
                                          AppStrings.start,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppDimensions.eighteen,
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  !inAppVal
                                      ? ElevatedButton(
                                          onPressed: () {
                                            AppRouteMaps.goToRemoveAdsPage();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 186, 186, 193),
                                          ),
                                          child: Text(
                                            AppStrings.skipAd + ">>",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        )
                                      : Container()
                                ],
                              )),
                        ],
                      );
                    }),
                  ),
                  Positioned.fill(
                    child: controller.showBubbles.value
                        ? SafeArea(
                            child: FloatingBubbles(
                              noOfBubbles: 45,
                              colorsOfBubbles: [
                                Colors.green.withAlpha(30),
                                AppColors.colorYellow,
                              ],
                              sizeFactor: 0.16,
                              duration: 2, // 120 seconds.
                              opacity: 70,
                              paintingStyle: PaintingStyle.stroke,
                              strokeWidth: AppDimensions.thirteen,
                              shape: controller.selectedScreenType == "circle"
                                  ? BubbleShape.circle
                                  : controller.selectedScreenType ==
                                          "roundedRectangle"
                                      ? BubbleShape.roundedRectangle
                                      : BubbleShape.square,
                              //BubbleShape.circle, // circle is the default. No need to explicitly mention if its a circle.
                            ),
                          )
                        : const IgnorePointer(),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> share(dynamic link, String title) async {
    await FlutterShare.share(
      title: "Property",
      text: title,
      linkUrl: link,
      chooserTitle: "Where You Want to Share",
    );
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

class ConsumableStore {
  static const String _kPrefKey = 'consumables';
  static Future<void> _writes = Future<void>.value();

  static Future<void> save(String id) {
    _writes = _writes.then((void _) => _doSave(id));
    return _writes;
  }

  static Future<void> consume(String id) {
    _writes = _writes.then((void _) => _doConsume(id));
    return _writes;
  }

  static Future<List<String>> load() async {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
        <String>[];
  }

  static Future<void> _doSave(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.add(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

  static Future<void> _doConsume(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }
}
