import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/data/controller/room_details/room_details_controller.dart';

import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';

class RoomDetailsBodySection extends StatelessWidget {

  final int index;

  const RoomDetailsBodySection({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomDetailsController>(
      builder: (controller) {

        var roomList = controller.roomList[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(MyStrings.amenities.tr,style: boldExtraLarge,),
            const SizedBox(height: 10,),

            Column(
                children: List.generate(roomList.amenities?.length ?? 0, (index) =>  Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.fiber_manual_record,size: 7,color: MyColor.primaryTextColor.withOpacity(.8 )),
                      const SizedBox(width: 5,),
                      Text(roomList.amenities?[index].title?.tr ?? '',style: regularLarge.copyWith(),),
                    ],
                  ),
                ),)
            ),

            const SizedBox(height: 12),

            Text(MyStrings.facilities.tr,style: boldExtraLarge,),
            const SizedBox(height: 10,),
            Column(
                children: List.generate(roomList.facilities?.length ?? 0, (index) =>  Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.fiber_manual_record,size: 7,color: MyColor.primaryTextColor.withOpacity(.8 )),
                      const SizedBox(width: 5,),
                      Text(roomList.facilities?[index].name?.tr ?? '',style: regularLarge.copyWith(),),
                    ],
                  ),
                ),)
            ),
            const SizedBox(height: 16),
            roomList.description == null || roomList.description!.isEmpty ? const SizedBox.shrink() :
            Text(MyStrings.description.tr,style: boldExtraLarge),
            const SizedBox(height: 10),
            Text(roomList.description ??''.tr,style: regularLarge.copyWith(color: MyColor.thinTextColor),textAlign: TextAlign.justify),
            const SizedBox(height: 10,)
          ],
        );
      },
    );
  }
}