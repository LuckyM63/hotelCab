import 'package:flutter/material.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
class HorizontalDivider extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final double margin;

  const HorizontalDivider({
    super.key,
    this.width = 1,
    this.height = 10,
    this.color = MyColor.bodyTextColor,
    this.margin = 7
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      width: width,
      height: height,
      color: color,
    );
  }
}