import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/view/components/text/small_text.dart';

import '../../../../core/utils/my_color.dart';

class LanguageCard extends StatelessWidget {

  final int index;
  final int selectedIndex;
  final bool isShowTopRight;
  final String langeName;

  const LanguageCard({
    Key? key,
    required this.index,
    required this.selectedIndex,
    this.isShowTopRight = false,
    required this.langeName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.space25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColor.getCardBgColor(),
            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
            boxShadow: MyUtils.getShadow()
          ),
          child: Column(
            children: [
              Container(
                height: 55, width: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.getScreenBgColor(),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.g_translate, color: MyColor.primaryColor, size: 22.5),
              ),
              const SizedBox(height: Dimensions.space10),
              SmallText(
                text: langeName.tr,
                textStyle: semiBoldSmall.copyWith(color: MyColor.getTextColor()),
              )
            ],
          ),
        ),
        index == selectedIndex ? isShowTopRight ? Positioned(
          right: Dimensions.space12,
          top: Dimensions.space10,
          child: Container(
            height: 20, width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColor.getPrimaryColor(),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: MyColor.colorWhite, size: 10),
          ),
        ) : Positioned(
          left: 50,
          right: 50,
          top: 25,
          child: Container(
            height: 55, width: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColor.getPrimaryColor().withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: MyColor.colorWhite, size: 22.5),
          ),
        ) : const Positioned(
          top: Dimensions.space10, right: Dimensions.space12,
          child: SizedBox(),
        )
      ],
    );
  }
}
