import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/utils/my_color.dart';
class CircularBackButton extends StatelessWidget {
  const CircularBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Container(
            alignment: Alignment.center,
            padding: const EdgeInsetsDirectional.only(start: 10,end: 4,top: 4,bottom: 4),
            decoration: BoxDecoration(
                color: MyColor.primaryColor.withOpacity(.3),
                shape: BoxShape.circle
            ),
            child: const Center(child: Icon(Icons.arrow_back_ios,color: MyColor.colorWhite,size: 20,))));
  }
}