import 'package:flutter/material.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';

import '../../../../../core/utils/my_color.dart';

class QuantityButton extends StatelessWidget {

  final HomeController controller;
  final IconData icon;
  final Color bgColor;
  final VoidCallback press;
  final Color iconColor;
  final double width;
  final double height;

  const QuantityButton({
    super.key,
    required this.controller,
    required this.press,
    required this.icon,
    this.bgColor = MyColor.colorGrey,
    this.iconColor = MyColor.colorBlack,
    this.width = 24,
    this.height = 24
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: MyColor.grayScale600),
          shape: BoxShape.circle
        ),
        child: Icon(icon,color: iconColor,size: 16),
      ),
    );
  }
}