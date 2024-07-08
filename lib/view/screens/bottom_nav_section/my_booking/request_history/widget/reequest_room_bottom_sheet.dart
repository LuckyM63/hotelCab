import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/data/model/booking_history/booking_request_history_response_model.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_images.dart';
import '../../../../../../core/utils/my_strings.dart';
import '../../../../../../core/utils/style.dart';
import '../../../../../../data/services/api_service.dart';
import '../../../../../components/divider/custom_divider.dart';


class RequestRoomBottomSheet extends StatelessWidget {
  final BookingRequest bookingRequest;
  const RequestRoomBottomSheet({
    super.key,
    required this.bookingRequest
  });

  @override
  Widget build(BuildContext context) {

    String currency = Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true);

    return GetBuilder<MyBookingController>(
      builder: (controller) => Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(MyStrings.requestedRoomsDetails.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 16),),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: MyColor.colorWhite,
                    padding: const EdgeInsets.only(left: 15,right: 6,top: 0,bottom: 8),
                    child: const Icon(Icons.close,size: 17,weight: 17,color: MyColor.titleTextColor,),
                  ),
                ),
              )
            ],
          ),
          const CustomDivider(space: 6),

          Column(
            children: List.generate(bookingRequest.bookingRequestDetails?.length ?? 0, (index) {
              var roomList = bookingRequest.bookingRequestDetails?[index];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                height: 100,
                                width: 85,
                                fit: BoxFit.fitHeight,
                                imageUrl:roomList?.roomType?.image ?? MyImages.defaultImageNetwork,
                                placeholder: (context, url) => const CustomImageLoader(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MarqueeWidget(child: Text(roomList?.roomType?.name?.tr ?? '',style: boldLarge.copyWith(color: MyColor.titleTextColor))),
                                  const SizedBox(height: 6),
                                  Text('${MyStrings.numbersOfRooms.tr} ${roomList?.numberOfRooms ?? '0'}',style: regularLarge.copyWith(fontSize: 13),),
                                  const SizedBox(height: 6),
                                  Text('${MyStrings.unitFare.tr} $currency${Converter.formatNumber(roomList?.unitFare ?? '0')}',style: regularLarge.copyWith(fontSize: 13),),
                                  const SizedBox(height: 6),
                                  Text('${MyStrings.taxCharge.tr} $currency${Converter.formatNumber(roomList?.taxCharge ?? '0')}',style: regularLarge.copyWith(fontSize: 13,color: MyColor.colorRed),),
                                  const SizedBox(height: 6),
                                  Text('${MyStrings.totalAmount.tr} $currency${Converter.formatNumber(roomList?.totalAmount ?? '0')}',style: boldLarge.copyWith(fontSize: 13)),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  bookingRequest.bookingRequestDetails!.length - 1 == index ? const SizedBox(height: Dimensions.space22,) : const CustomDivider(space: 18,)
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}