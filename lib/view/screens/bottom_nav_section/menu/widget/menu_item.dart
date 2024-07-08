import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';

import '../../../../components/image/custom_svg_picture.dart';

class MenuItems extends StatelessWidget {

  final String imageSrc;
  final String label;
  final VoidCallback onPressed;
  final bool isSvgImage;
  final Color color;
  final Color titleColor;
  final double iconOpacity;

  const MenuItems({
    Key? key,
    required this.imageSrc,
    required this.label,
    required this.onPressed,
    this.isSvgImage = true,
    this.color = MyColor.colorBlack,
    this.titleColor = MyColor.titleTextColor,
    this.iconOpacity = .7,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
        color: MyColor.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isSvgImage ?
                CustomSvgPicture(image:
                  imageSrc,
                  color: color.withOpacity(iconOpacity),
                  height: 17.5, width: 17.5
                ) :
                Image.asset(
                  imageSrc,
                  color: color.withOpacity(iconOpacity),
                  height: 17.5, width: 17.5
                ),
                const SizedBox(width: Dimensions.space15),
                Text(label.tr, style: regularDefault.copyWith(color: titleColor))
              ],
            ),
            Container(
              height: 30, width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: MyColor.transparentColor, shape: BoxShape.circle),
              child: Icon(Icons.arrow_forward_ios_rounded, color: titleColor, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
