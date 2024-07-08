import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/data/controller/booking_details/booking_details_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/style.dart';
import '../../../components/custom_cash_image/custom_cash_network_image.dart';
class HotelInfo extends StatelessWidget {

  final BookingDetailsController controller;

  const HotelInfo({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.hotelName.tr,style: boldLarge),
              const SizedBox(height: Dimensions.space8,),
              Row(
                children: [
                  SvgPicture.asset(MyImages.location,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn)),
                  const SizedBox(width: Dimensions.space6,),
                  Expanded(child: Text(controller.location.tr,style: boldDefault.copyWith(color: MyColor.bodyTextColor)))
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: CustomCashNetworkImage(
            borderRadius: 4,
            imageHeight: MediaQuery.of(context).size.height * .07,
            imageUrl: controller.hotelImage,
          ),
        )
      ],
    );
  }
}