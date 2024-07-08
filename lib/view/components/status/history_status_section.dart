import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

class HistoryStatusSection extends StatelessWidget {

  final String status;

  const HistoryStatusSection({
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
          color: status == "1" ? MyColor.colorGreen.withOpacity(.1)
              : status == "2" ? Colors.orangeAccent.withOpacity(.1)
              : status == "3" ? Colors.red : MyColor.colorGreen.withOpacity(.1),
          border: Border.all(color:
                status == "1" ? MyColor.colorGreen
              : status == "2" ? Colors.orangeAccent
              : status == "3" ? Colors.red : MyColor.colorGreen)
      ),
      child: Text(
        status == "1" ? MyStrings.approved.tr
            : status == "2" ? MyStrings.pending.tr
            : status == "3" ? MyStrings.rejected.tr
            : "",
        textAlign: TextAlign.center,
        style: mediumSmall.copyWith(
            color: status == "1" ? MyColor.colorGreen
                : status == "2" ? Colors.orangeAccent
                : status == "3" ? Colors.red : MyColor.colorGreen,
        ),
      ),
    );
  }
}
