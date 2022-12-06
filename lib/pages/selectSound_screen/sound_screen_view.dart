import 'package:demo1212/pages/selectSound_screen/sound_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorPickScreen extends StatelessWidget {
  const ColorPickScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SoundScreenController>(builder: (controller) {
      return const Scaffold(
        //backgroundColor: Color.fromRGBO(233, 52, 35, 1),




      );
    });

  }



}
