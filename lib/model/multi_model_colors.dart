// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleColors{
  Color? colorName;
  RxBool isSelect= false.obs;

  MultipleColors({this.colorName, required this.isSelect});
}