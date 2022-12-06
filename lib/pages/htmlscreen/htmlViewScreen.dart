import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'htmlScreenController.dart';


// import 'splash_page_controller.dart';

class HtmlScreenView extends StatelessWidget{
  //  HtmlScreenView({Key? key}) : super(key: key);

  final _url = 'assets/webpage/nightlightlamp.html';
  final _key = UniqueKey();
  var dsh = Get.isRegistered<HtmlScreenController>()
    ? Get.find<HtmlScreenController>()
    : Get.put(HtmlScreenController());
   WebViewController? _controller;


  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString(_url);
    _controller!.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
  @override
  Widget build(BuildContext context) {
    dsh.onInit;
    return GetBuilder<HtmlScreenController>(builder: (controller) {
      //SplashScreenViewModel splashScreenViewModel =Get.put(SplashScreenViewModel());
      return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
            ),
            title: const Text("About Us"),
            centerTitle: true,
        ),
        
        body: WebView(
                    initialUrl: 'about:blank',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },

                ),
        
      );
    });
  }

 

}
