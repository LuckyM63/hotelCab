import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/data/controller/booking_details/booking_details_controller.dart';
import 'package:booking_box/view/screens/booking_details/widget/summary_item.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/util.dart';
import '../../../components/dotted_line_painter.dart';
class SummarySection extends StatelessWidget {

  final BookingDetailsController controller;

  const SummarySection({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
      decoration: BoxDecoration(
        color: MyColor.colorWhite,
        borderRadius: BorderRadius.circular(4),
        boxShadow: MyUtils.getShadow2()
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(MyStrings.fareSummary.tr,style: boldDefault,),
          const SizedBox(height: Dimensions.space12,),
          SummaryItem(
            title: MyStrings.totalFare,
            amount: Converter.formatNumber(controller.booking?.bookingFare ?? ''),
          ),
          SummaryItem(
            title: MyStrings.discount,
            amount: Converter.formatNumber(controller.booking?.totalDiscount ?? ''),
            symbol: '-',
          ),
          SummaryItem(
            textColor: MyColor.darkBlue,
            title: MyStrings.subTotal,
            amount: Converter.formatNumber(controller.paymentInfo?.subtotal ?? ''),
            symbol: '=',
            fontWeight: FontWeight.w600,
          ),
          CustomPaint(
            size: const Size(double.infinity, 0),
            painter: DottedLinePainter(
                width: 1,
                spacing: 3,
                color: MyColor.naturalDark
            ),
          ),
          const SizedBox(height: Dimensions.space8),
          SummaryItem(
            title: '${controller.taxName}(${Converter.formatNumber(controller.booking?.taxPercent ?? '')}%)',
            amount: Converter.formatNumber(controller.booking?.taxCharge ?? ''),
            symbol: '+',
          ),
          SummaryItem(
            title: MyStrings.canceledFare,
            amount: Converter.formatNumber(controller.booking?.cancellationFee ?? ''),
            symbol: '-',
          ),
          SummaryItem(
            title: '${MyStrings.canceled} ${controller.taxName}',
            amount: Converter.formatNumber(controller.booking?.cancellationFee ?? ''),
            symbol: '-',
          ),
          SummaryItem(
            title: MyStrings.extraServiceCharge,
            amount: Converter.formatNumber(controller.booking?.serviceCost ?? ''),
            symbol: '+',
          ),
          SummaryItem(
            title: MyStrings.totalAmount,
            amount:  Converter.formatNumber(controller.paymentInfo?.totalAmount ?? ''),
            symbol: '=',
            textColor: MyColor.darkBlue,
            fontWeight: FontWeight.w600,
          ),
          CustomPaint(
            size: const Size(double.infinity, 0),
            painter: DottedLinePainter(
                width: 1,
                spacing: 3,
                color: MyColor.naturalDark
            ),
          ),
          const SizedBox(height: Dimensions.space8,),
          SummaryItem(
            title: MyStrings.paymentReceived,
            amount:  Converter.formatNumber(controller.paymentInfo?.paymentReceived ?? ''),
          ),
          SummaryItem(
            title: MyStrings.refunded,
            amount: Converter.formatNumber(controller.paymentInfo?.refunded ?? ''),
          ),
          CustomPaint(
            size: const Size(double.infinity, 0),
            painter: DottedLinePainter(
                width: 1,
                spacing: 3,
                color: MyColor.naturalDark
            ),
          ),
          const SizedBox(height: Dimensions.space8,),
          SummaryItem(
            title: MyStrings.receivableFromUser,
            amount: Converter.formatNumber(controller.booking?.dueAmount ?? ''),
            textColor: MyColor.colorRed,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}