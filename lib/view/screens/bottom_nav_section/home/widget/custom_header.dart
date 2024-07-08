import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
class CustomHeader extends StatelessWidget {

  final String title;
  final String actionText;
  final VoidCallback? actionPress;
  final bool isChangeActionColor;
  final bool isShowSeeMoreButton;

  const CustomHeader({
    super.key,
    required this.title,
    this.actionText = MyStrings.viewAll,
    this.actionPress,
    this.isChangeActionColor = false,
    this.isShowSeeMoreButton = true
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimensions.space20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 2,
                child: Text(title.tr,style: boldMediumLarge.copyWith(fontSize: 17))),
            // const Spacer(),
            isShowSeeMoreButton ?
            Expanded(
                flex: 1,
                child: InkWell(
                onTap: actionPress,
                child: Text(actionText.tr,style: mediumDefault.copyWith(
                    color: isChangeActionColor && Get.find<HomeController>().roomList.length > 1 ?
                    MyColor.primaryColor : MyColor.bodyTextColor),textAlign: TextAlign.end,)
              )
            ) : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: Dimensions.space16),
      ],
    );
  }
}