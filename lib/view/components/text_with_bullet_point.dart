import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/style.dart';

class TextWithBulletPoint extends StatelessWidget {
  final String text;
  const TextWithBulletPoint({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(text.tr,style: regularLarge.copyWith(color: MyColor.bodyTextColor2),),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Icon(Icons.fiber_manual_record,size: 12,color: MyColor.titleTextColor.withOpacity(.8),),
        )
      ],
    );
  }
}