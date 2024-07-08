import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';

class PaymentStatusWidget extends StatelessWidget {

  final String status;
  final bool onlyText;
  final double fontSize;

  const PaymentStatusWidget({
    Key? key,
    required this.status,
    this.onlyText = false,
    this.fontSize = 11
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onlyText  ? Text(
      status.tr,
      textAlign: TextAlign.center,
      style: boldSmall.copyWith(
        fontSize: fontSize,
        color: status == MyStrings.pendingPayment.tr ?
        MyColor.pendingColor.withOpacity(1) :
        status == MyStrings.successPayment.tr ?
        MyColor.colorGreen.withOpacity(1) :
        status == MyStrings.rejectPayment.tr ?
        MyColor.colorRed.withOpacity(1) : Colors.blue.withOpacity(1),
      ),
    ) : Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space7, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: status == MyStrings.pendingPayment ?
          MyColor.pendingColor.withOpacity(.1) :
          status == MyStrings.successPayment ?
          MyColor.colorGreen.withOpacity(.1) :
          status == MyStrings.rejectPayment ?
          MyColor.colorRed.withOpacity(.1) : MyColor.colorGrey.withOpacity(.1),
          border: Border.all(
            color: status == MyStrings.pendingPayment ?
            MyColor.pendingColor.withOpacity(.1) :
            status == MyStrings.successPayment ?
            MyColor.colorGreen.withOpacity(.1) :
            status == MyStrings.rejectPayment ?
            MyColor.colorRed.withOpacity(.1) : Colors.blue.withOpacity(.1),
          )
      ),
      child: Text(
        status.tr,
        textAlign: TextAlign.center,
        style: boldSmall.copyWith(
          fontSize: fontSize,
          color: status == MyStrings.pendingPayment.tr ?
          MyColor.pendingColor.withOpacity(1) :
          status == MyStrings.successPayment.tr ?
          MyColor.colorGreen.withOpacity(1) :
          status == MyStrings.rejectPayment.tr ?
          MyColor.colorRed.withOpacity(1) : Colors.blue.withOpacity(1),
        ),
      ),
    );
  }
}
