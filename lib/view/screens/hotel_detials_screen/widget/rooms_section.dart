import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_images.dart';

class RoomsSection extends StatelessWidget {
  const RoomsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HotelDetailsScreenController>(
      builder: (controller){

        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Text(MyStrings.rooms.tr,style: semiBoldMediumLarge,),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(controller.roomTypesList.length, (index){

                return GestureDetector(
                  onTap: () {
                    // Get.toNamed(RouteHelper.hotelDetailsScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                height: 114,
                                width: 253,
                                fit: BoxFit.cover,
                                imageUrl:controller.roomTypesList[index].image.toString(),
                                placeholder: (context, url) => const CustomImageLoader(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space16),
                        Text(controller.roomTypesList[index].name.toString().tr,style: mediumLarge),
                        const SizedBox(height: Dimensions.space8),
                        Row(
                          children: [
                            SvgPicture.asset(MyImages.bed,width: 14,height: 14,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                            const SizedBox(width: Dimensions.space8),
                            Text(controller.roomTypesList[index].beds?.length.toString() ?? '',style: regularDefault.copyWith(color: MyColor.titleTextColor),),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.fiber_manual_record,size: 8,),
                            ),
                            SvgPicture.asset(MyImages.person,width: 14,height: 14,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                            const SizedBox(width: Dimensions.space8),
                            Text('${controller.roomTypesList[index].totalAdult} ${MyStrings.adults.tr}, ${controller.roomTypesList[index].totalChild} ${MyStrings.children}',style: regularDefault.copyWith(color: MyColor.titleTextColor))

                          ],
                        ),
                        const SizedBox(height: Dimensions.space12,),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: regularDefault,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " \$${Converter.formatNumber(controller.roomTypesList[index].fare.toString())}",
                                      style: regularDefault.copyWith(color: MyColor.primaryColor)
                                  ),
                                  TextSpan(
                                      text: "/${MyStrings.perNight.tr}",
                                      style: regularDefault.copyWith(color: MyColor.bodyTextColor)
                                  ),
                                  // You can add more TextSpan widgets for different styles
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      );},
    );
  }
}