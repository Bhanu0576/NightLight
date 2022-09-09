
import 'package:get/get.dart';

class MultiLavaScreen{
  late String screenName;
  late String screenType;
  late String screenValue;

  RxBool isSelect = false.obs;

  MultiLavaScreen(this.screenName, this.screenType, this.screenValue, this.isSelect);
}