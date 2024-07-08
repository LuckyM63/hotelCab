import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

class HistoryStatusWidget extends StatelessWidget {

  final String status;

  const HistoryStatusWidget({
    Key? key,
    required this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space7, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: status == MyStrings.upcoming ?
            MyColor.pendingColor.withOpacity(.9) :
            status == MyStrings.running ?
            MyColor.colorGreen.withOpacity(.9) :
            status == MyStrings.canceled ?
            MyColor.colorRed.withOpacity(.9) : Colors.blue.withOpacity(.9),
            border: Border.all(
                color: status == MyStrings.upcoming ?
                MyColor.pendingColor.withOpacity(.9) :
                status == MyStrings.running ?
                MyColor.colorGreen.withOpacity(.9) :
                status == MyStrings.canceled ?
                MyColor.colorRed.withOpacity(.9) : Colors.blue.withOpacity(.9),
            )
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: boldSmall.copyWith(
          color: MyColor.colorWhite
        ),
      ),
    );
  }
}
