import 'package:demo1212/navigation/app_route_maps.dart';
import 'package:get/get.dart';
//import 'package:night_light/navigation/app_route_maps.dart';



class SplashPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      AppRouteMaps.gotoHomePage();

    });


  }



}