import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';

class NavBarItem extends StatelessWidget {

  final String imagePath;
  final int index;
  final String label;
  final VoidCallback press;
  final bool isSelected;

  const NavBarItem({Key? key,
  required this.imagePath,
  required this.index,
  required this.label,
  required this.isSelected,
  required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isSelected ? MyColor.primaryColor.withOpacity(.2) : null,
          ),
          child: Row(
            mainAxisSize:MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              imagePath.contains('svg')?SvgPicture.asset(
                imagePath,
                colorFilter:ColorFilter.mode(
                  isSelected ? MyColor.primaryColor : MyColor.iconColor,
                  BlendMode.srcIn,
                ),
                width: 15,
                height: 15,
              )
                :Image.asset(
                imagePath,
                color: isSelected ? MyColor.primaryColor : MyColor.iconColor,
                width: 15, height: 15,
              ),
              const SizedBox(width: 8),
              Text(
                label.tr, textAlign: TextAlign.center,
                style: mediumLarge.copyWith(color: isSelected ? MyColor.primaryColor : MyColor.primaryTextColor,fontWeight: isSelected? FontWeight.w600 : FontWeight.w500)
              )
            ],
          ),
        ),
      );
  }
}
