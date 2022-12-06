// ignore: file_names
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../appStyle/app_color.dart';

class CustomShowcaseWidget extends StatelessWidget
{
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  // ignore: use_key_in_widget_constructors
  const CustomShowcaseWidget({
    required this.description,
    required this.child,
    required this.globalKey
  });


  @override
  Widget build(BuildContext context) => Showcase(
    key: globalKey,
    description: description,
    showcaseBackgroundColor: AppColors.colorBlueDark,
    contentPadding: const EdgeInsets.all(12),
    //showArrow: false,
    //disableAnimation: true,
    title: "Tap here",
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
    descTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16
    ),
    overlayColor: Colors.grey,
    overlayOpacity: 0.7,
    child: child,
  );



}