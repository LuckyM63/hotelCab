import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/data/controller/booking_details/booking_details_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
class CheckinCheckoutSection extends StatelessWidget {

  final BookingDetailsController controller;

  const CheckinCheckoutSection({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(MyStrings.bookedAt.tr,style: regularDefault.copyWith(color: MyColor.naturalDark),),
                  const SizedBox(height: Dimensions.space4),
                  Row(
                    children: [
                      Expanded(child: Text(DateConverter.formatStringDateTime(controller.booking?.createdAt ?? '',onlyDate: true),style: boldLarge)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(MyStrings.forText.tr,style: regularDefault.copyWith(color: MyColor.naturalDark),),
                  const SizedBox(height: Dimensions.space4),
                  Text("${DateConverter.calculateNumberOfNights(controller.checkIn, controller.checkOut)} ${MyStrings.night.tr}",style: boldLarge),
                ],
              ),
            ),
          ],
        ),
        // const CustomDivider(space: Dimensions.space10,),
        const SizedBox(height: Dimensions.space12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(MyStrings.checkIN.tr,style: regularDefault.copyWith(color: MyColor.naturalDark),),
                  const SizedBox(height: Dimensions.space4),

                  Row(
                    children: [
                      Expanded(
                          child: Text(DateConverter.formatStringDateTime(controller.checkIn,onlyDate: true),style: boldLarge),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(MyStrings.checkOUT.tr,style: regularDefault.copyWith(color: MyColor.naturalDark),),
                  const SizedBox(height: Dimensions.space4),
                  Text(DateConverter.formatStringDateTime(controller.checkOut,onlyDate: true),style: boldLarge),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}