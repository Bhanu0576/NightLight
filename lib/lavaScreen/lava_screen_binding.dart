import 'package:get/get.dart';

import 'lava_screen_controller.dart';

class LavaScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LavaScreenController.new);
  }
}