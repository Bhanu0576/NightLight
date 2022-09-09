import 'package:demo1212/pages/splash/splash_page_controller.dart';
import 'package:get/get.dart';
//import 'package:night_light/pages/splash/splash_page_controller.dart';

class SplashPageBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SplashPageController.new);

  }
}