import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/view/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:booking_box/view/components/text/bottom_sheet_header_text.dart';

class BottomSheetHeaderRow extends StatelessWidget {
  final String header ;
  final double bottomSpace;
  final VoidCallback? onCancelButtonTap;
  const BottomSheetHeaderRow({Key? key,this.header = '',this.bottomSpace = Dimensions.space10,this.onCancelButtonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColor.colorGrey.withOpacity(0.2),
            ),
          ),
        ),
        const SizedBox(height: 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Expanded(child: BottomSheetHeaderText(text: header.tr)),
            BottomSheetCloseButton(onCancelButtonTap: onCancelButtonTap,)
          ],
        ),
        SizedBox(height: bottomSpace),
      ],
    );
  }
}
