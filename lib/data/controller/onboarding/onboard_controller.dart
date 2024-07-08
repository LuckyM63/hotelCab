import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/general_setting/general_setting_response_model.dart';
import '../../model/global/response_model/response_model.dart';

class OnboardController extends GetxController{


  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index){
    currentIndex = index;
    update();
  }

  List<String> onboardTitleList = [
    MyStrings.onboardTitle1,
    MyStrings.onboardTitle2,
    MyStrings.onboardTitle3,
    MyStrings.onboardTitle4
  ];

  List<String> onboardSubTitleList = [
    MyStrings.onBoardSubTitle1,
    MyStrings.onBoardSubTitle2,
    MyStrings.onBoardSubTitle3,
    MyStrings.onBoardSubTitle4,
  ];

  List<String> onboardImageList = [

    MyImages.onboardImage1,
    MyImages.onboardImage2,
    MyImages.onboardImage3,
    MyImages.onboardImage4,

  ];



}