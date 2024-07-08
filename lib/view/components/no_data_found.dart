import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

import '../../core/utils/my_color.dart';

class NoDataFound extends StatelessWidget {

  final String errorMsg;
  final String imageUrl;
  final bool isSvg;

  const NoDataFound({
    Key? key,
    this.errorMsg = MyStrings.noDataFound,
    this.imageUrl = MyImages.emptyBox,
    this.isSvg = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSvg ? SvgPicture.asset(
            imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ) : Image.asset(
            imageUrl,
            height: 100, width: 100,
          ),
          const SizedBox(height: Dimensions.space10),
          Text(
            errorMsg.tr,
            style: semiBoldDefault.copyWith(color: MyColor.getTextColor()),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
