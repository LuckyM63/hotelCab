import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/data/services/api_service.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/style.dart';
class SummaryItem extends StatelessWidget {

  final String title;
  final String amount;
  final String symbol;
  final Color textColor;
  final FontWeight? fontWeight;

  const SummaryItem({
    super.key,
    required this.title,
    required this.amount,
    this.symbol = '',
    this.textColor = MyColor.primaryTextColor,
    this.fontWeight = FontWeight.w400
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(title.tr,style: regularDefault.copyWith(color: textColor,fontWeight: fontWeight),maxLines: 1,)
            ),
            Text("$symbol$amount ${Get.find<ApiClient>().getCurrencyOrUsername()}",style: boldLargeManrope.copyWith(color: textColor,fontSize: 13),),
          ],
        ),
        const SizedBox(height: Dimensions.space10),
      ],
    );
  }
}