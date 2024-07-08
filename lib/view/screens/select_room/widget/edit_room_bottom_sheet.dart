import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/divider/custom_divider.dart';

class EditRoomBottomSheet extends StatelessWidget {
  const EditRoomBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomSelectController>(
      builder: (controller) => Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(MyStrings.selectedRooms.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 16),),
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
            children: List.generate(controller.selectedRoomList.length, (index) {
              var roomList = controller.selectedRoomList[index];
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
                                height: 80,
                                width: 70,
                                fit: BoxFit.fitHeight,
                                imageUrl:roomList.image ?? MyImages.defaultImageNetwork,
                                placeholder: (context, url) => const CustomImageLoader(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(roomList.name?.tr ?? '',style: boldLarge.copyWith(color: MyColor.titleTextColor)),
                                  const SizedBox(height: 6,),
                                  Row(
                                    children: [
                                      SvgPicture.asset(MyImages.person,width: Dimensions.space15,height: Dimensions.space15,),
                                      const SizedBox(width: 5,),
                                      Expanded(child: Text('${roomList.totalAdult} ${MyStrings.adults.tr}, ${roomList.totalChild} ${MyStrings.children.tr}',style: regularDefault.copyWith(color: MyColor.titleTextColor))),
                                    ],
                                  ),
                                  const SizedBox(height: 6,),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: " ${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true).tr}",
                                            style: boldLarge.copyWith(fontSize: 16)
                                        ),
                                        TextSpan(
                                            text: "${roomList.discountedFare}",
                                            style: boldLarge.copyWith(fontSize: 16)
                                        ),
                                        TextSpan(
                                            text: ' /${MyStrings.night.tr.toTitleCase()}',
                                            style: regularLarge.copyWith(fontSize: 12)
                                        ),

                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      SvgPicture.asset(MyImages.exclamation,width: Dimensions.space15,height: Dimensions.space10,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text('${MyStrings.cancellationFee.tr} ${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(roomList.cancellationFee ?? '0')}',
                                            style: regularDefault.copyWith(color: MyColor.primaryTextColor.withOpacity(.9),fontSize: 10)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          controller.removeSelectedRoomListItem(roomList,index);
                          controller.deductFromPayableAmount(double.parse(roomList.discountedFare.toString()));
                          controller.deductGuestFromRoom(roomList);

                          if(controller.selectedRoomList.isEmpty){
                            Get.back();
                          }
                        },
                        child: Container(
                          height: 55,
                          alignment: Alignment.center,
                          color: MyColor.colorWhite,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: MyColor.titleTextColor.withOpacity(.2),width: .5)
                            ),
                            child: Text(MyStrings.remove.tr,style: regularDefault.copyWith(color: MyColor.colorRed,fontSize: 11,fontWeight: FontWeight.w500),),
                          ),
                        ),
                      )
                    ],
                  ),
                  controller.selectedRoomList.length - 1 == index ? const SizedBox(height: Dimensions.space22,) : const CustomDivider(space: 18,)
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}