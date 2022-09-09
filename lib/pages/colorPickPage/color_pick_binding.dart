import 'package:get/get.dart';
import 'package:demo1212/pages/colorPickPage/color_pick_controller.dart';

class ColorPickPageBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ColorPickPageController.new);
  }
}