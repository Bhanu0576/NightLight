import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MultipleAudioModel{
  late String name;
  late String audio;
  RxBool isSelect= false.obs;


  MultipleAudioModel(
      this.name,
      this.audio,
      this.isSelect
      );
}





