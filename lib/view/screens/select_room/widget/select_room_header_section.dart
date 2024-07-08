import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../components/divider/horizontal_divider.dart';
class SelectRoomHeaderSection extends StatelessWidget {
  const SelectRoomHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => GetBuilder<RoomSelectController>(
        builder: (roomSelectController) => Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20,),
                Text(MyStrings.selectRoom.tr,style: boldMediumLarge,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${DateConverter.formatDateInDayMonth(controller.checkInDate)} ${MyStrings.to.tr} ${DateConverter.formatDateInDayMonth(controller.checkOutDate)}',style: regularSmall.copyWith(color: MyColor.bodyTextColor),),
                    const HorizontalDivider(),
                    SvgPicture.asset(MyImages.bed,width: 12,height: 12,),
                    Text('  ${controller.numberOfRooms} ${MyStrings.room.tr}',style: regularSmall.copyWith(color: MyColor.bodyTextColor),),
                    const HorizontalDivider(),
                    SvgPicture.asset(MyImages.person,width: 12,height: 12,),
                    Text('  ${controller.numberOfGuests} ${MyStrings.guests.tr}',style: regularSmall.copyWith(color: MyColor.bodyTextColor),),
                  ],),
                const SizedBox(height: 7),
              ],
            ),
            Positioned(
              top: 18,
              child: IconButton(onPressed: (){
                roomSelectController.clearTotalRoomCount();
                Get.back();
              }, icon: const Icon(Icons.arrow_back_ios)),
            )
          ],
        ),
      ),
    );
  }
}