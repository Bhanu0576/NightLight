import 'package:demo1212/pages/contact_us/contact_us_controller.dart';
import 'package:get/get.dart';

class ContactUsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ContactUsPageController.new);
  }
}