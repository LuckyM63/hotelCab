
import 'package:flutter/material.dart';

import '../../core/utils/my_color.dart';
class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 7,
      height: 7,
      decoration: const BoxDecoration(
          color: MyColor.bodyTextColor,
          shape: BoxShape.circle
      ),
    );
  }
}