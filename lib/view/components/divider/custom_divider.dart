import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {

  final double space;
  final Color color;
  final double thickness;

  const CustomDivider({
    Key? key,
    this.space = Dimensions.space20,
    this.color = MyColor.colorBlack,
    this.thickness = 0.5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: space),
        Divider(color: color.withOpacity(0.2), height: 0.5, thickness: thickness),
        SizedBox(height: space),
      ],
    );
  }
}
