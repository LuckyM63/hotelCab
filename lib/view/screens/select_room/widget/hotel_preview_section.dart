import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
class HotelPreviewSection extends StatelessWidget {

  final int index;

  const HotelPreviewSection({super.key,required this.index});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<RoomSelectController>(
      builder: (controller) {
        var roomList = controller.roomList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.roomDetailsScreen,arguments: index);
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CustomCashNetworkImage(
                          imageUrl: controller.roomList[index].image ?? MyImages.defaultImageNetwork,
                          imageHeight: 135,
                        ),
                      ),

                      controller.roomList[index].isFeatured  == '1' ?

                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                          margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: MyColor.primaryColor.withOpacity(.7)
                          ),
                          child: Text(MyStrings.featured.tr,style: mediumDefault.copyWith(color: MyColor.colorWhite),),
                        ),
                      ) : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15,),
              Expanded(
                  flex: 5,
                  child: Container(
                    // color: Colors.green,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        Text(controller.roomList[index].name?.tr ?? '',style: boldLarge.copyWith(color: MyColor.titleTextColor)),
                        const SizedBox(height: Dimensions.space11,),
                        Row(
                          children: [
                            SvgPicture.asset(MyImages.bed,width: Dimensions.space15,height: Dimensions.space11,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                            const SizedBox(width: 1,),
                            Expanded(child: Text(controller.getBedInfo(index).tr,style: regularDefault.copyWith(color: MyColor.primaryTextColor.withOpacity(.9)),textAlign: TextAlign.start,)),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space11,),
                        Row(
                          children: [
                            SvgPicture.asset(MyImages.person,width: Dimensions.space15,height: Dimensions.space15,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                            const SizedBox(width: 5,),
                            Expanded(child: Text('${roomList.totalAdult} ${MyStrings.adults.tr}, ${roomList.totalChild} ${MyStrings.children.tr}',style: regularDefault.copyWith(color: MyColor.primaryTextColor.withOpacity(.9)))),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space10,),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text('${MyStrings.cancellationFee.tr} ${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(roomList.cancellationFee ?? '')}',style: regularDefault.copyWith(color: MyColor.primaryTextColor.withOpacity(.9))),
                            ),
                            Positioned(
                                top: 1,
                                child: SvgPicture.asset(MyImages.exclamationOutline,width: Dimensions.space15,height: Dimensions.space15,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),)),
                          ],
                        ),

                        const SizedBox(height: Dimensions.space10,),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.roomDetailsScreen,arguments: index);
                          },
                          child: Row(
                            children: [
                              Text(MyStrings.viewDetails.tr,style: regularDefault.copyWith(color: MyColor.primaryColor),),
                              const SizedBox(height: 5),
                              const Icon(Icons.arrow_forward_ios,color: MyColor.primaryColor,size: 10,)
                            ],
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  )
              ),
            ],
          ),
        );
      }
    );
  }
}
