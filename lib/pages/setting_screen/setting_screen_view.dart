import 'package:demo1212/pages/splash/splash_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:night_light/pages/splash/splash_page_controller.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Color(0xff040438),
        appBar: AppBar(
          leading: InkWell(onTap: (){
            Get.back();
            } ,
          child: Icon(Icons.arrow_back_ios)),

          title: Text("Setting", style: TextStyle(color: Colors.white),),
        ),
        // body: Center(child: Container(
        //     padding: EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20) ,decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(200),
        //     boxShadow: const [BoxShadow(
        //       color: Colors.white70,
        //       blurRadius: 10.0,
        //     ),]
        // ) ,
        //     child: Image.asset("assets/images/bulbyellow_icon.png"))),
      );
    });

  }



}
