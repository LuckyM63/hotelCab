
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';

import 'my_strings.dart';

class MyUtils{

  static splashScreen(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MyColor.transparentColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.transparentColor,
        systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  static allScreen(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: MyColor.colorWhite,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.colorWhite,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  static dynamic getShadow2({double blurRadius = 8}) {
    return [
      BoxShadow(
        color: MyColor.getShadowColor().withOpacity(0.3),
        blurRadius: blurRadius,
        spreadRadius: 3,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: MyColor.getShadowColor().withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: blurRadius,
        offset: const Offset(0, 1),
      ),
    ];
  }

  static dynamic getShadow(){
    return  [
      BoxShadow(
        blurRadius: 15.0,
        offset: const Offset(0, 25),
        color: Colors.grey.shade500.withOpacity(0.6),
        spreadRadius: -35.0
      ),
    ];
  }

  static dynamic getBottomSheetShadow(){
    return  [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static dynamic getCardShadow(){
    return  [
      BoxShadow(
        color: Colors.grey.shade400.withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static bool isRtl(BuildContext context){
    final TextDirection currentDirection = Directionality.of(context);
    final bool isRTL = currentDirection == TextDirection.rtl;
    return isRTL;
  }


  static getOperationTitle(String value) {
    String number = value;
    RegExp regExp = RegExp(r'^(\d+)(\w+)$');
    Match? match = regExp.firstMatch(number);
    if(match!=null){
      String? num = match.group(1)??'';
      String? unit = match.group(2)??'';
      String title = '${MyStrings.last.tr} $num ${unit.capitalizeFirst}';
      return title.tr;
    } else{
      return value.tr;
    }
  }

}