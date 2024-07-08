import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../components/divider/custom_divider.dart';
import '../../../components/divider/horizontal_divider.dart';

class RoomReviewSection extends StatelessWidget {
  const RoomReviewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {


    return GetBuilder<HotelDetailsScreenController>(
      builder: (hotelDetailsController) => GetBuilder<RoomSelectController>(
        builder: (roomSelectController) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(7)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CustomCashNetworkImage(
                        imageHeight: 72,
                        imageUrl:hotelDetailsController.hotelSetting?.ImageUrl ?? MyImages.defaultImageNetwork,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hotelDetailsController.hotelSetting?.name?.tr ?? '' ,style: semiBoldLarge.copyWith(fontSize: 16),),
                          const SizedBox(height: 5,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text('${roomSelectController.homeController.numberOfGuests} ${MyStrings.guests.tr}', style: regularDefault.copyWith(color: MyColor.colorBlack)),
                                const HorizontalDivider(),
                                Text('${roomSelectController.selectedRoomList.length} ${MyStrings.room.tr}', style: regularDefault.copyWith(color: MyColor.colorBlack)),
                                const HorizontalDivider(),
                                Text('${roomSelectController.homeController.numberOfNights()} ${MyStrings.night.toLowerCase().tr}', style: regularDefault.copyWith(color: MyColor.colorBlack)),
                              ],
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(roomSelectController.selectedRoomList.length, (index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.only(left: 8,top: 8,right: 8,bottom: 8),
                      decoration: BoxDecoration(
                        color: MyColor.primaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(roomSelectController.selectedRoomList[index].name?.tr ?? '',style: boldLarge,),
                          const SizedBox(height: 4,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(MyImages.bed,width: 16,height: 16,colorFilter: const ColorFilter.mode(MyColor.titleTextColor, BlendMode.srcIn),),
                                const SizedBox(width: 4),
                                Text('${roomSelectController.selectedRoomList[index].bedInfo?.tr}',style: regularDefault.copyWith(color: MyColor.titleTextColor),),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('${MyStrings.discountFare.tr} ${roomSelectController.getDiscountedRoomFare(roomSelectController.selectedRoomList[index].discountedFare.toString())} ${hotelDetailsController.hotelDetailsRepo.apiClient.getCurrencyOrUsername()}',style: regularDefault,),
                        ],
                      ),
                    ),)
                ),
              ),
              const CustomDivider(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(roomSelectController.homeController.checkInDaysName.tr,style: regularDefault,),
                        const SizedBox(height: 3,),
                        Text(roomSelectController.homeController.checkInDate.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor.withOpacity(.9)),),
                        const SizedBox(height: 3,),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${MyStrings.checkIn.tr}:",
                                  style: regularDefault
                              ),
                              TextSpan(
                                  text: " ${DateConverter.convertTimeToTime(hotelDetailsController.hotelSetting?.checkinTime?.tr ?? '',)}",
                                  style: boldDefault.copyWith(color: MyColor.titleTextColor.withOpacity(.9))
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(roomSelectController.homeController.checkOutDaysName.tr,style: regularDefault),
                        const SizedBox(height: 3),
                        Text(roomSelectController.homeController.checkOutDate.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor.withOpacity(.9))),
                        const SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${MyStrings.checkOut.tr}:",
                                  style: regularDefault
                              ),
                              TextSpan(
                                  text: " ${DateConverter.convertTimeToTime(hotelDetailsController.hotelSetting?.checkoutTime?.tr ?? '')}",
                                  style: boldDefault.copyWith(color: MyColor.titleTextColor.withOpacity(.9))
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}