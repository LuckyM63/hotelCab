import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';

class BottomSheetCloseButton extends StatelessWidget {

  final VoidCallback? onCancelButtonTap;

  const BottomSheetCloseButton({Key? key,this.onCancelButtonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCancelButtonTap ?? () =>  Navigator.pop(context),
      child: Container(
        height: 30, width: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.space5),
        decoration:  BoxDecoration(color: MyColor.colorGrey.withOpacity(.1), shape: BoxShape.circle),
        child: const Icon(Icons.clear, color: MyColor.colorBlack, size: 15),
      ),
    );
  }
}
