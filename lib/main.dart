import 'package:demo1212/navigation/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:night_light/navigation/app_pages.dart';
// import 'package:night_light/pages/splash/splash_page_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'lavaScreen/lava_screen_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home:  LavaScreen(),
    // );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
      //home: SettingScreen(),
    );
  }
}
