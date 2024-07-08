import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/style.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';

class InfoItem extends StatelessWidget {

  final String firstText,lastText;
  final String icon;
  final bool isShowDivider;

  const InfoItem({Key? key,
    required this.firstText,
    required this.lastText,
    required this.icon,
    this.isShowDivider = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.space10, top: Dimensions.space10),
          child: Row(
            children: [
              Container(
                height: 40, width: 40,
                padding: const EdgeInsets.all(Dimensions.space5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: MyColor.screenBgColor,
                  shape: BoxShape.circle
                ),
                child: SvgPicture.asset(icon, colorFilter: const ColorFilter.mode(MyColor.primaryColor, BlendMode.srcIn), height: 20, width: 20),
              ),
              const SizedBox(width: Dimensions.space10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstText.tr, style: regularDefault.copyWith(color: MyColor.smallTextColor1)),
                  Text(lastText.tr, style: regularSmall.copyWith(color: MyColor.titleColor)),
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: isShowDivider,
          child: const Divider(color: MyColor.lineColor, height: 0.5, thickness: 1))
      ],
    );
  }
}
