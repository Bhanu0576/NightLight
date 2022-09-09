import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:demo1212/appStyle/app_color.dart';
import 'package:demo1212/appStyle/app_dimension.dart';
import 'package:demo1212/appStyle/app_theme_style.dart';
import 'package:demo1212/appStyle/assets_images.dart';
import 'package:demo1212/model/multi_model_colors.dart';
import 'package:demo1212/model/multiple_audio_model.dart';
import 'package:demo1212/navigation/app_route_maps.dart';
import 'package:demo1212/pages/HomePage/home_page_controller.dart';
import 'package:demo1212/utils/app_strings.dart';
import '../../widget/oval_top_clipper.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var dsh = Get.isRegistered<HomePageController>()
      ? Get.find<HomePageController>()
      : Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    dsh.onInit();
    return GetBuilder<HomePageController>(builder: (controller) {
      print("Controller Color ..... ${controller.color}");
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.colorBlueDark,
          appBar: AppBar(
            elevation: AppDimensions.zero,
            backgroundColor: AppColors.colorBlueDark,
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
                                    color: AppColors.colorGrey),
                                child: const Image(
                                    image: AssetImage(AssetsBase.yellowbulb)),
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
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                      height: AppDimensions.twenty,
                      width: AppDimensions.twenty,
                      child: Image.asset(AssetsBase.help_Icon)),
                  title: Text(AppStrings.help,textScaleFactor: AppDimensions.onepointtwo,),
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                      height: AppDimensions.twenty,
                      width: AppDimensions.twenty,
                      child: Image.asset(AssetsBase.trophy_Icon)),
                  title: Text(
                    AppStrings.trophy,
                    textScaleFactor: AppDimensions.onepointtwo,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                      height: AppDimensions.twenty,
                      width: AppDimensions.twenty,
                      child: Image.asset(AssetsBase.rating_Icon)),
                  title: Text(
                    AppStrings.rate,
                    textScaleFactor: AppDimensions.onepointtwo,
                  ),
                  onTap: () {},
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
                  onTap: () {},
                ),
                ListTile(
                  leading: SizedBox(
                      height: AppDimensions.twenty,
                      width: AppDimensions.twenty,
                      child: Image.asset(AssetsBase.setting_Icon)),
                  title: Text(
                    AppStrings.setting,
                    textScaleFactor: AppDimensions.onepointtwo,
                  ),
                  onTap: () {},
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text: AppStrings.version,
                    style: TextStyle( color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: controller.packageInfo.version,),
                    ],
                  ),
                ),
                 //Text(controller.packageInfo.version),
                SizedBox(height: AppDimensions.twenty),
              ],
            ),
          ),
          body: Column(
            children: [
              const Spacer(),
              Container(
                height: controller.selectColor == 0
                    ? MediaQuery.of(context).size.height / 2.3
                    : MediaQuery.of(context).size.height / 1.9,
                margin: EdgeInsets.only(
                    left: AppDimensions.fifTeen, right: AppDimensions.fifTeen),
                padding: EdgeInsets.all(AppDimensions.twenty),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(AppDimensions.thirty)),
                child: Column(
                  children: [
                     SizedBox(
                      height: AppDimensions.twenty,
                    ),
                     Text(
                      AppStrings.nightlightduration,
                      style: TextStyle(
                        fontSize: AppDimensions.eighteen,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.select = AppStrings.simpleLight;
                              controller.update();
                              controller.selectColor = 0;
                            },
                            child: Container(
                              // margin: EdgeInsets.all(10) ,
                              padding: EdgeInsets.all(AppDimensions.eighteen),
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(AppDimensions.ten),
                                  border: Border.all(
                                      color: controller.selectColor == 0
                                          ? Colors.black
                                          : Colors.white70)),
                              child: Image.asset(
                                AssetsBase.white_light,
                                height: AppDimensions.fifty,
                                width: AppDimensions.fifty,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.select = "RainbowLight";
                              controller.update();
                              controller.selectColor = 1;
                            },
                            child: Container(
                              // margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(AppDimensions.eighteen),
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(AppDimensions.ten),
                                  border: Border.all(
                                      color: controller.selectColor == 1
                                          ? Colors.black
                                          : Colors.white70)),
                              child: Image.asset(
                                AssetsBase.multicolor_light,
                                height: AppDimensions.fifty,
                                width: AppDimensions.fifty,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.select = "YellowLight";
                              controller.update();
                              controller.selectColor = 2;
                            },
                            child: Container(
                              // margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(AppDimensions.eighteen),
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(AppDimensions.ten),
                                  border: Border.all(
                                      color: controller.selectColor == 2
                                          ? Colors.black
                                          : Colors.white70)),
                              child: Image.asset(
                                AssetsBase.gradientlight,
                                height: AppDimensions.fifty,
                                width: AppDimensions.fifty,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.selectColor == 0
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.decrement();
                                    },
                                    child: Container(
                                      height: AppDimensions.forty,
                                      width: AppDimensions.forty,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppDimensions.twentyFive),
                                        color: AppColors.colorBlueDark,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 7),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: AppDimensions.forty,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                        color: AppColors.colorBlueDark,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${controller.mint} Mins",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.colorWhite),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                   SizedBox(
                                    width: AppDimensions.ten,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.increment();
                                    },
                                    child: Container(
                                      height: AppDimensions.forty,
                                      width: AppDimensions.forty,
                                      decoration: BoxDecoration(
                                          color: AppColors.colorBlueDark,
                                          borderRadius: BorderRadius.circular(AppDimensions.twenty)),
                                      child: const Center(
                                          child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: AppDimensions.twenty,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      showDialog(
                                          context: Get.context!,
                                          builder: (context) {
                                            return AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                     SizedBox(height: AppDimensions.twenty),
                                                     Text(
                                                      AppStrings.moodLightColor,
                                                    ),
                                                     SizedBox(
                                                      height: AppDimensions.ten,
                                                    ),
                                                    LayoutBuilder(
                                                      builder:
                                                          (BuildContext context,BoxConstraints constraints) {
                                                        final boxWidth =constraints.constrainWidth();
                                                        const dashWidth = 4.0;
                                                        final dashCount = (boxWidth /(2 *dashWidth)).floor();
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  dashCount,
                                                                  (_) {
                                                            return const SizedBox(
                                                              width: dashWidth,
                                                              height: 1,
                                                              child:DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                    color: Color.fromRGBO(61, 61, 61, 0.4)),
                                                              ),
                                                            );
                                                          }),
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          direction: Axis.horizontal,
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: AppDimensions.ten,
                                                    ),
                                                    Obx(
                                                      () => Wrap(
                                                        children: [
                                                          for (int index = 0; index < controller.model.length; index++)
                                                            InkWell(
                                                              onTap: () {
                                                                controller.changeColorState(index);
                                                                // for(int i=0;i<controller.model.length;i++){
                                                                //   controller.model[i].isSelect.value=false;
                                                                // }
                                                                // controller.model[index].isSelect.value=true;
                                                                //
                                                                if (kDebugMode) {
                                                                  print(
                                                                      "Colors:${controller.model[index].colorName}");
                                                                }
                                                                controller.color = controller.model[index].colorName!;
                                                              },
                                                              child: Padding(
                                                                padding: AppDimensions.margin0_5_5_5,
                                                                child:
                                                                    Container(
                                                                  height: AppDimensions.thirtyFive,
                                                                  width: AppDimensions.thirtyFive,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: controller.model[index].colorName),
                                                                  child: controller.model[index].isSelect.value
                                                                      ? const Icon(Icons.check,
                                                                          color: Colors.white,
                                                                        )
                                                                      : Container(),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:AppDimensions.twenty,
                                                    ),
                                                    LayoutBuilder(
                                                      builder:
                                                          (BuildContext context, BoxConstraints constraints) {
                                                        final boxWidth = constraints.constrainWidth();
                                                        const dashWidth = 4.0;
                                                        final dashCount =
                                                            (boxWidth /(2 *dashWidth)).floor();
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  dashCount,
                                                                  (_) {
                                                            return const SizedBox(
                                                              width: dashWidth,
                                                              height: 1,
                                                              child:
                                                                  DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                    color: Color.fromRGBO(61, 61, 61, 0.4)),
                                                              ),
                                                            );
                                                          }),
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          direction: Axis.horizontal,
                                                        );
                                                      },
                                                    ),
                                                     SizedBox(
                                                      height: AppDimensions.ten,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller.changeColorState(controller.selectRandomValue());

                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.all(AppDimensions.ten),
                                                            padding: EdgeInsets.all(AppDimensions.five),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              border: Border.all(color: Colors.black),
                                                            ),
                                                            child: Text(AppStrings.random,
                                                              style: TextStyle(color: Colors.black),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        //AppRouteMaps.gotoColorPick(color);
                                                        Get.back();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          primary: AppColors.colorBlueDark,
                                                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(AppDimensions.twenty))),
                                                      child: Text( AppStrings.ok, style: TextStyle(color:Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ));
                                          });
                                    },
                                    child: Image.asset(
                                      AssetsBase.color_picker,
                                      height: AppDimensions.thirty,
                                      width: AppDimensions.thirty,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: Get.context!,
                                            builder: (context) {
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.zero,
                                                content: Column(
                                                  mainAxisSize:MainAxisSize.min,
                                                  children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Container(
                                                            padding: AppDimensions.padding10,
                                                            child: Text(
                                                              AppStrings.background_sound,
                                                              textAlign:TextAlign.start,
                                                              style: TextStyle(fontWeight:FontWeight.bold),
                                                            ))),
                                                    LayoutBuilder(
                                                      builder:
                                                          (BuildContext context,BoxConstraints constraints) {
                                                        final boxWidth = constraints.constrainWidth();
                                                        const dashWidth = 4.0;
                                                        final dashCount =
                                                            (boxWidth / (2 * dashWidth)).floor();
                                                        return Flex(
                                                          children:
                                                              List.generate(
                                                                  dashCount,
                                                                  (_) {
                                                            return const SizedBox(
                                                              width: dashWidth,
                                                              height: 1,
                                                              child:
                                                                  DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                    color: Color.fromRGBO(61, 61, 61, 0.4)),
                                                              ),
                                                            );
                                                          }),
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          direction:Axis.horizontal,
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: AppDimensions.ten,
                                                    ),
                                                    Column(
                                                      children: [
                                                        ListView.builder(
                                                          itemCount: controller.multiAudioModel.length,
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                                padding: AppDimensions.padding10_10_5_5,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      if (kDebugMode) {
                                                                        print(
                                                                            "Audio play");
                                                                        print(
                                                                            "audio...${controller.multiAudioModel[index].audio.toString()}");
                                                                        print(
                                                                            "isSelect...${controller.multiAudioModel[index].isSelect.toString()}");
                                                                      }
                                                                      controller.audio = controller.multiAudioModel[index].audio.toString();
                                                                      controller.selectAudio(index);
                                                                    },
                                                                    child: Obx(
                                                                      () =>
                                                                          Container(
                                                                        height: AppDimensions.fifty,
                                                                        width: double.infinity,
                                                                        // ignore: unrelated_type_equality_checks
                                                                        color: controller.multiAudioModel[index].isSelect == true
                                                                            ? AppColors.colorBlueDark
                                                                            : Colors.transparent,
                                                                        // ignore: unrelated_type_equality_checks
                                                                        child: Center(
                                                                            child: Text(controller.multiAudioModel[index].name,
                                                                          style: TextStyle(color: controller.multiAudioModel[index].isSelect == true ? Colors.white : AppColors.blackColor),
                                                                        )),
                                                                      ),
                                                                    )));
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            primary: AppColors.colorBlueDark,
                                                            shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20)),
                                                            padding: const EdgeInsets.all(10)),
                                                        child: Text( AppStrings.ok,
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Image.asset(
                                        AssetsBase.music_select,
                                        height: AppDimensions.thirty,
                                        width: AppDimensions.thirty,
                                      )),
                                ],
                              )
                            ],
                          )
                        // Multiple color select Bulb
                        : controller.selectColor == 1
                            ? Column(
                                children: [
                                  SizedBox(height: AppDimensions.twenty),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.decrementSec();
                                          print("J decrement");
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(AppDimensions.twentyFive),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: AppDimensions.seven),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${controller.sec} Sec",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.incrementSec();
                                          print("J Increment");
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                              color: AppColors.colorBlueDark,
                                              borderRadius: BorderRadius.circular(AppDimensions.twenty)),
                                          child: const Center(
                                              child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: AppDimensions.twenty),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.decrement();
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(AppDimensions.twentyFive),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: AppDimensions.seven),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${controller.mint} Mins",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.increment();
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                              color: AppColors.colorBlueDark,
                                              borderRadius:
                                                  BorderRadius.circular(AppDimensions.twenty)),
                                          child: const Center(
                                              child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppDimensions.twenty,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: Get.context!,
                                              builder: (context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                         SizedBox(
                                                            height: AppDimensions.twenty),
                                                         Text(
                                                           AppStrings.moodLightColor,
                                                        ),
                                                         SizedBox(
                                                          height: AppDimensions.ten,
                                                        ),
                                                        LayoutBuilder(
                                                          builder: (BuildContext context,
                                                              BoxConstraints constraints) {
                                                            final boxWidth = constraints.constrainWidth();
                                                            const dashWidth = 4.0;
                                                            final dashCount = (boxWidth / (2 * dashWidth)).floor();
                                                            return Flex(
                                                              children:
                                                                  List.generate(
                                                                      dashCount,
                                                                      (_) {
                                                                return const SizedBox(
                                                                  width:
                                                                      dashWidth,
                                                                  height: 1,
                                                                  child:
                                                                      DecoratedBox(
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromRGBO(61,61, 61, 0.4)),
                                                                  ),
                                                                );
                                                              }),
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              direction: Axis.horizontal,
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: AppDimensions.twenty,
                                                        ),
                                                        Obx(
                                                          () => Wrap(
                                                            children: [
                                                              for (int index =0; index < controller.model.length; index++)
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller.multiColorSelect(index);
                                                                    // for (int i = 0;i <controller.model.length;i++) {
                                                                    //   controller.model[i].isSelect.value = false;
                                                                    // }
                                                                    // controller.model[index].isSelect.value = true;

                                                                    if (kDebugMode) {
                                                                      print(
                                                                          "Colors:${controller.model[index].colorName}");
                                                                      //controller.multiModel.add(controller.model[index].colorName!) ;
                                                                      //print("Colors Selected is--> $controller.model[index].colorName");
                                                                    }
                                                                    // controller.color=controller.multiModel;
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets.only(left: 5, right:5, bottom:5),
                                                                    child:
                                                                        Container(
                                                                      height: AppDimensions.thirtyFive,
                                                                      width: AppDimensions.thirtyFive,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: controller.model[index].colorName),
                                                                      child: controller.model[index].isSelect.value
                                                                          ? const Icon(Icons.check,
                                                                              color: Colors.white,
                                                                            )
                                                                          : Container(),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: AppDimensions.twenty,
                                                        ),
                                                        LayoutBuilder(
                                                          builder: (BuildContext context,
                                                              BoxConstraints constraints) {
                                                            final boxWidth = constraints.constrainWidth();
                                                            const dashWidth = 4.0;
                                                            final dashCount = (boxWidth / (2 * dashWidth)).floor();
                                                            return Flex(
                                                              children:
                                                                  List.generate(
                                                                      dashCount,
                                                                      (_) {
                                                                return const SizedBox(
                                                                  width:
                                                                      dashWidth,
                                                                  height: 1,
                                                                  child:
                                                                      DecoratedBox(
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromRGBO(61,61, 61, 0.4)),
                                                                  ),
                                                                );
                                                              }),
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              direction: Axis.horizontal,
                                                            );
                                                          },
                                                        ),
                                                         SizedBox(
                                                          height: AppDimensions.ten
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  //controller.isRainbowSelect ==false ? controller.isRainbowSelect =true : controller.isRainbowSelect =false;
                                                                  controller.rainbowSelector();
                                                                  controller.isRainbowSelect = true;
                                                                  // controller.color=[Colors.red,Colors.black] as Color;
                                                                  // print("wopuireowrw...${controller.color}");
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.all(AppDimensions.five),
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.twenty),
                                                                    border: Border.all(color: Colors.black),
                                                                  ),
                                                                  child: Text(
                                                                    AppStrings.rainbow,
                                                                    style: TextStyle(color: Colors.black),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            //AppRouteMaps.gotoColorPick(color);
                                                            Get.back();
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              primary: AppColors.colorBlueDark,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(AppDimensions.twenty))),
                                                          child: Text(
                                                            AppStrings.ok,
                                                            style: TextStyle(
                                                                color: Colors.white),
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                              });
                                        },
                                        child: Image.asset(
                                          AssetsBase.color_picker,
                                          height: AppDimensions.thirty,
                                          width: AppDimensions.thirty,
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: Get.context!,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    contentPadding: EdgeInsets.zero,
                                                    content: Column(
                                                      mainAxisSize:MainAxisSize.min,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Container(
                                                                padding:AppDimensions.padding10,
                                                                child: Text(
                                                                  AppStrings.background_sound,
                                                                  textAlign: TextAlign.start,
                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                ))),
                                                        LayoutBuilder(
                                                          builder: (BuildContext context, BoxConstraints constraints) {
                                                            final boxWidth = constraints.constrainWidth();
                                                            const dashWidth = 4.0;
                                                            final dashCount = (boxWidth / (2 * dashWidth)).floor();
                                                            return Flex(
                                                              children:
                                                                  List.generate(
                                                                      dashCount,
                                                                      (_) {
                                                                return const SizedBox(
                                                                  width:
                                                                      dashWidth,
                                                                  height: 1,
                                                                  child:
                                                                      DecoratedBox(
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromRGBO( 61, 61, 61, 0.4)),
                                                                  ),
                                                                );
                                                              }),
                                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                              direction: Axis.horizontal,
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: AppDimensions.ten,
                                                        ),
                                                        Column(
                                                          children: [
                                                            ListView.builder(
                                                              itemCount: controller.multiAudioModel.length,
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,index) {
                                                                return Padding(
                                                                    padding: AppDimensions.padding10_10_5_5,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          if (kDebugMode) {
                                                                            print("Audio play");
                                                                            print("audio...${controller.multiAudioModel[index].audio.toString()}");
                                                                            print("isSelect...${controller.multiAudioModel[index].isSelect.toString()}");
                                                                          }
                                                                          controller.audio = controller.multiAudioModel[index].audio.toString();
                                                                          controller.selectAudio(index);
                                                                        },
                                                                        child: Obx(
                                                                          () =>
                                                                              Container(
                                                                            height: AppDimensions.fifty,
                                                                            width: double.infinity,
                                                                            // ignore: unrelated_type_equality_checks
                                                                            color: controller.multiAudioModel[index].isSelect == true
                                                                                ? AppColors.colorBlueDark
                                                                                : Colors.transparent,
                                                                            // ignore: unrelated_type_equality_checks
                                                                            child: Center(
                                                                                child: Text(
                                                                              controller.multiAudioModel[index].name,
                                                                              style: TextStyle(color: controller.multiAudioModel[index].isSelect == true ? Colors.white : AppColors.blackColor),
                                                                            )),
                                                                          ),
                                                                        )));
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                primary: AppColors.colorBlueDark,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(AppDimensions.twenty)),
                                                                padding: EdgeInsets.all(AppDimensions.ten)),
                                                            child: Text(AppStrings.ok,
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Image.asset(
                                            AssetsBase.music_select,
                                            height: AppDimensions.thirty,
                                            width: AppDimensions.thirty,
                                          )),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(height: AppDimensions.twenty),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.screenselectdecrement();
                                          //print("ajlsjlfjs.....${controller.sc}");
                                          controller.update();
                                          //print("Screen decrement");
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(AppDimensions.twentyFive),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: AppDimensions.seven),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius:BorderRadius.circular(AppDimensions.twenty),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${controller.screens[controller.sc].screenName.toString()}",
                                               // "${controller.screens[controller.sc].toString()}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.screenselectincrement();
                                          controller.update();
                                          print("Screen Increment....${controller.sc}");
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                              color: AppColors.colorBlueDark,
                                              borderRadius: BorderRadius.circular(AppDimensions.twenty)),
                                          child: const Center(
                                              child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: AppDimensions.twenty),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.decrement();
                                          controller.update();
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(AppDimensions.twentyFive),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: AppDimensions.seven),
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(AppDimensions.twenty),
                                            color: AppColors.colorBlueDark,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${controller.mint} Mins",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                       SizedBox(
                                        width: AppDimensions.ten,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.increment();
                                        },
                                        child: Container(
                                          height: AppDimensions.forty,
                                          width: AppDimensions.forty,
                                          decoration: BoxDecoration(
                                              color: AppColors.colorBlueDark,
                                              borderRadius:
                                                  BorderRadius.circular(AppDimensions.twenty)),
                                          child: const Center(
                                              child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppDimensions.twenty,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: Get.context!,
                                              builder: (context) {
                                                return AlertDialog(
                                                    contentPadding: EdgeInsets.zero,
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                         SizedBox(height: AppDimensions.twenty),
                                                         Text(AppStrings.moodLightColor,),
                                                         SizedBox(height: AppDimensions.ten,),
                                                        LayoutBuilder(
                                                          builder:
                                                              (BuildContext context, BoxConstraints constraints) {
                                                            final boxWidth = constraints.constrainWidth();
                                                            const dashWidth = 4.0;
                                                            final dashCount =
                                                            (boxWidth /
                                                                (2 *
                                                                    dashWidth))
                                                                .floor();
                                                            return Flex(
                                                              children:
                                                              List.generate(
                                                                  dashCount,
                                                                      (_) {
                                                                    return const SizedBox(
                                                                      width: dashWidth,
                                                                      height: 1,
                                                                      child:
                                                                      DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromRGBO(61,61,61,0.4)),
                                                                      ),
                                                                    );
                                                                  }),
                                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                              direction:Axis.horizontal,
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: AppDimensions.ten,
                                                        ),
                                                        Obx(
                                                              () => Wrap(
                                                            children: [
                                                              for (int index = 0; index < controller.model.length; index++)
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller.changeColorState(index);
                                                                    // for(int i=0;i<controller.model.length;i++){
                                                                    //   controller.model[i].isSelect.value=false;
                                                                    // }
                                                                    // controller.model[index].isSelect.value=true;
                                                                    //
                                                                    if (kDebugMode) {
                                                                      print(
                                                                          "Colors:${controller.model[index].colorName}");
                                                                    }
                                                                    controller.color = controller.model[index].colorName!;
                                                                  },
                                                                  child: Padding(
                                                                    padding:
                                                                    AppDimensions.margin0_5_5_5,
                                                                    child:
                                                                    Container(
                                                                      height: AppDimensions.thirtyFive,
                                                                      width: AppDimensions.thirtyFive,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: controller.model[index].colorName),
                                                                      child: controller.model[index].isSelect.value
                                                                          ? const Icon(Icons.check, color: Colors.white,)
                                                                          : Container(),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                          AppDimensions.twenty,
                                                        ),
                                                        LayoutBuilder(
                                                          builder:
                                                              (BuildContext context, BoxConstraints constraints) {
                                                            final boxWidth =
                                                            constraints.constrainWidth();
                                                            const dashWidth = 4.0;
                                                            final dashCount =
                                                            (boxWidth /(2 * dashWidth)).floor();
                                                            return Flex(
                                                              children:
                                                              List.generate(
                                                                  dashCount,
                                                                      (_) {
                                                                    return const SizedBox(
                                                                      width: dashWidth,
                                                                      height: 1,
                                                                      child:
                                                                      DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromRGBO(61,61,61,0.4)),
                                                                      ),
                                                                    );
                                                                  }),
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              direction: Axis.horizontal,
                                                            );
                                                          },
                                                        ),
                                                         SizedBox(
                                                          height: AppDimensions.ten,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:MainAxisAlignment.start,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                controller.changeColorState(controller.selectRandomValue());
                                                                controller.update();
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.all(AppDimensions.ten),
                                                                padding: EdgeInsets.all(AppDimensions.five),
                                                                decoration:
                                                                BoxDecoration(borderRadius:BorderRadius.circular(AppDimensions.twenty),
                                                                  border: Border.all(color: Colors.black),
                                                                ),
                                                                child: Text(
                                                                  AppStrings.random,
                                                                  style: TextStyle(color: Colors.black),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            //AppRouteMaps.gotoColorPick(color);
                                                            Get.back();
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                              primary: AppColors.colorBlueDark,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(AppDimensions.twenty))),
                                                          child: Text(
                                                            AppStrings.ok,
                                                            style: TextStyle(color:Colors.white),
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                              });
                                        },
                                        child: Image.asset(
                                          AssetsBase.color_picker,
                                          height: AppDimensions.thirty,
                                          width: AppDimensions.thirty,
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: Get.context!,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    contentPadding: EdgeInsets.zero,
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Container(
                                                                padding: AppDimensions.padding10,
                                                                child: Text(
                                                                  AppStrings.background_sound,
                                                                  textAlign: TextAlign.start,
                                                                  style: TextStyle( fontWeight: FontWeight.bold),
                                                                ))),
                                                        LayoutBuilder(
                                                          builder:
                                                              (BuildContext context,
                                                              BoxConstraints
                                                              constraints) {
                                                            final boxWidth =
                                                            constraints
                                                                .constrainWidth();
                                                            const dashWidth = 4.0;
                                                            final dashCount =
                                                            (boxWidth /
                                                                (2 *
                                                                    dashWidth))
                                                                .floor();
                                                            return Flex(
                                                              children:
                                                              List.generate(
                                                                  dashCount,
                                                                      (_) {
                                                                    return const SizedBox(
                                                                      width: dashWidth,
                                                                      height: 1,
                                                                      child:
                                                                      DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromRGBO(61,61,61,0.4)),
                                                                      ),
                                                                    );
                                                                  }),
                                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                              direction:Axis.horizontal,
                                                            );
                                                          },
                                                        ),
                                                         SizedBox(
                                                          height: AppDimensions.ten,
                                                        ),
                                                        Column(
                                                          children: [
                                                            ListView.builder(
                                                              itemCount: controller.multiAudioModel.length,
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context, index) {
                                                                return Padding(
                                                                    padding:
                                                                    AppDimensions.padding10_10_5_5,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          if (kDebugMode) {
                                                                            print(
                                                                                "Audio play");
                                                                            print(
                                                                                "audio...${controller.multiAudioModel[index].audio.toString()}");
                                                                            print(
                                                                                "isSelect...${controller.multiAudioModel[index].isSelect.toString()}");
                                                                          }
                                                                          controller.audio = controller.multiAudioModel[index].audio.toString();
                                                                          controller.selectAudio(index);
                                                                        },
                                                                        child: Obx(
                                                                              () =>
                                                                              Container(
                                                                                height: AppDimensions.fifty,
                                                                                width: double.infinity,
                                                                                // ignore: unrelated_type_equality_checks
                                                                                color: controller.multiAudioModel[index].isSelect ==
                                                                                    true
                                                                                    ? AppColors.colorBlueDark
                                                                                    : Colors.transparent,
                                                                                // ignore: unrelated_type_equality_checks
                                                                                child: Center(
                                                                                    child: Text(
                                                                                      controller.multiAudioModel[index].name,
                                                                                      style: TextStyle(color: controller.multiAudioModel[index].isSelect == true ? Colors.white : AppColors.blackColor),
                                                                                    )),
                                                                              ),
                                                                        )));
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                primary: AppColors.colorBlueDark,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(AppDimensions.twenty)),
                                                                padding: EdgeInsets.all(AppDimensions.ten)),
                                                            child: Text(
                                                              AppStrings.ok,
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Image.asset(
                                            AssetsBase.music_select,
                                            height: AppDimensions.thirty,
                                            width: AppDimensions.thirty,
                                          )),
                                    ],
                                  )
                                ],
                              )
                  ],
                ),
              ),
              const Spacer(),
              ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  height: AppDimensions.hundredtwenty,
                  color: Colors.white70,
                  child: Center(
                      child: SizedBox(
                    height: AppDimensions.forty,
                    width: AppDimensions.hundredeighty,
                    child: ElevatedButton(
                        onPressed: () {
                          print("min.......${controller.mint}");
                          print("sec.......${controller.sec}");
                          print(
                              "multiModel...:${controller.multiModel.length}");
                          print("multiModelColor...:${controller.multiModel}");
                          //
                          // if(controller.color == null || controller.multiModel == null)
                          // {
                          //   Fluttertoast.showToast(
                          //       msg: "Please Select Color !",
                          //       toastLength: Toast.LENGTH_SHORT,
                          //       gravity: ToastGravity.CENTER,
                          //       timeInSecForIosWeb: 1,
                          //       backgroundColor: Colors.grey,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0
                          //   );
                          // }
                          // else if(controller.audio == null)
                          // {
                          //   Fluttertoast.showToast(
                          //       msg: "Please Select Audio !",
                          //       toastLength: Toast.LENGTH_SHORT,
                          //       gravity: ToastGravity.CENTER,
                          //       timeInSecForIosWeb: 1,
                          //       backgroundColor: Colors.grey,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0
                          //   );
                          // } else {
                          if (controller.selectColor == 0) {
                            if (!controller.checkModel()) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Color !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (controller.audio == null) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Audio !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              AppRouteMaps.gotoColorPick(controller.colorName!,
                                  controller.audio!, controller.mint);
                            }
                          } else if (controller.selectColor == 1) {
                            if (!controller.checkModel()) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Color !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (controller.audio == null) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Audio !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              controller.multipleColorSelection();
                              AppRouteMaps.gotoColorPick1(
                                  controller.isRainbowSelect == true
                                      ? controller.multiModel.reversed.toList()
                                      : controller.multiModel,
                                  controller.audio!,
                                  controller.mint,
                                  controller.sec);
                            }
                          } else {
                            // controller.multipleColorSelection();
                            // AppRouteMaps.gotoColorPick2(controller.isRainbowSelect == true
                            //     ? controller.multiModel.reversed.toList()
                            //     : controller.multiModel,
                            //     controller.audio!,
                            //     controller.mint);

                            if (!controller.checkModel()) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Color !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (controller.audio == null) {
                              Fluttertoast.showToast(
                                  msg: "Please Select Audio !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                               controller.selectedScreen = controller.screens[controller.sc].screenName.toString();
                               controller.selectedScreenType = controller.screens[controller.sc].screenType.toString();
                               controller.selectedScreenValue = controller.screens[controller.sc].screenValue.toString();
                              AppRouteMaps.goToLavaPage(controller.colorName!, controller.selectedScreen, controller.selectedScreenType, controller.selectedScreenValue,
                                  controller.audio!, controller.mint);
                            }
                            // } else {
                            //   //AppRouteMaps.goToLavaPage(controller.colors.,
                            //     //  controller.audio!, controller.mint);
                            // }

                            // if (!controller.checkModel()) {
                            //   Fluttertoast.showToast(
                            //       msg: "Please Select Color !",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.CENTER,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.grey,
                            //       textColor: Colors.white,
                            //       fontSize: 16.0);
                            // } else if (controller.audio == null) {
                            //   Fluttertoast.showToast(
                            //       msg: "Please Select Audio !",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.CENTER,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.grey,
                            //       textColor: Colors.white,
                            //       fontSize: 16.0);
                            // } else {
                            //   AppRouteMaps.goToLavaPage(controller.isRainbowSelect == true
                            //       ? controller.multiModel.reversed.toList()
                            //       : controller.multiModel,
                            //       controller.audio!,
                            //       controller.mint);
                            //
                            //   // controller.multipleColorSelection();
                            //   // AppRouteMaps.gotoColorPick1(
                            //   //     controller.isRainbowSelect == true
                            //   //         ? controller.multiModel.reversed.toList()
                            //   //         : controller.multiModel,
                            //   //     controller.audio!,
                            //   //     controller.mint,
                            //   //     controller.sec);
                            // }

                            //AppRouteMaps.goToLavaPage();
                          }
                          // }
                          //controller.multipleColorSelection();
                          // AppRouteMaps.gotoColorPick(controller.color,controller.audio):
                          // // AppRouteMaps.gotoColorPick1(controller.multiModel as MultipleColors);
                          // print("Multiple Colors printer... ${controller.multiModel}");
                        },
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff040438),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.all(10)),
                        child: Text(
                          AppStrings.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppDimensions.eighteen,
                          ),
                        )),
                  )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
