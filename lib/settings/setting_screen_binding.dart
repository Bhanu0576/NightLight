import 'package:demo1212/settings/setting_page_controller.dart';
import 'package:get/get.dart';

class SettingScreenBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(SettingPageController.new);
  }

}