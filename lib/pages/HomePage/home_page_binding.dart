import 'package:get/get.dart';
import 'package:demo1212/pages/HomePage/home_page_controller.dart';

class HomePageBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomePageController.new);
  }
}