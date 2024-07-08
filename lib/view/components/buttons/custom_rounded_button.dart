import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/style.dart';
import '../../../core/utils/util.dart';
class CustomRoundedButton extends StatelessWidget {

  final String labelName;
  final String? svgImage;
  final VoidCallback press;
  final double verticalPadding;
  final Color buttonColor;
  final Color buttonTextColor;
  final double horizontalPadding;
  const CustomRoundedButton({
    super.key,
    required this.labelName,
    required this.press,
    this.svgImage,
    this.verticalPadding = 13,
    this.horizontalPadding = 15,
    this.buttonColor = MyColor.primaryColor,
    this.buttonTextColor = MyColor.colorWhite
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: press,
      child: Container(

        padding: EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: MyColor.primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: MyUtils.getCardShadow()
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgImage != null ?
            SvgPicture.asset(svgImage!,width: 34 ,):const SizedBox.shrink(),
            svgImage != null ? const SizedBox(width: Dimensions.space7): const SizedBox.shrink(),
            Text(labelName.tr,style: semiBoldMediumLarge.copyWith(color: MyColor.colorWhite,fontSize: 15),)
          ],
        ),
      ),
    );
  }
}