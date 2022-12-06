import 'dart:developer';

import 'package:demo1212/appStyle/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../HomePage/home_page_view.dart';

class ShowCaseMain extends StatelessWidget {
  const ShowCaseMain({Key? key}) : super(key: key);
  //int initialVal = 0;

  void loadCounter() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setInt('showValue', 1);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ShowCase',
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShowCaseWidget(
          onStart: (index, key) {
            log('onStart: $index, $key');
          },
          onComplete: (index, key) {
            log('onComplete: $index, $key');
            if (index == 4) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle.light.copyWith(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: AppColors.colorWhite,
                ),
              );
            }
          },
          blurValue: 1,
          autoPlayDelay: const Duration(seconds: 3),
          builder: Builder(builder: (context) =>HomePage()),

        ),
      ),
    );
  }
}

