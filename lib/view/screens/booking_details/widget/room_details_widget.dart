import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/data/controller/booking_details/booking_details_controller.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/util.dart';
import '../../../components/divider/custom_divider.dart';
import '../../../components/marquee_widget/marquee_widget.dart';

class RoomDetailsWidget extends StatelessWidget {

  final BookingDetailsController controller;

  const RoomDetailsWidget({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(MyStrings.roomDetails.tr,style: boldOverLargeRajdhani),
        // const SizedBox(height: Dimensions.space14),
        Column(
          children: List.generate(controller.roomDetails.length, (index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space6,vertical: Dimensions.space8),
              margin: const EdgeInsets.only(bottom: Dimensions.space10),
              decoration: BoxDecoration(
                  borderRadius: index == controller.roomDetails.length-1 ?  const BorderRadius.only(
                    bottomLeft:  Radius.circular(4),
                    bottomRight:  Radius.circular(4),
                  ):null,
                  color: MyColor.colorWhite,
                  boxShadow: MyUtils.getShadow2()
              ),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(DateConverter.formatStringDateTime(controller.roomDetails[index].date ?? '',onlyDate: true),style: boldLargeManrope)
                  ),
                  const CustomDivider(space: 10,),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MarqueeWidget(child: Text(MyStrings.roomTypes.tr,style: boldDefault.copyWith(color: MyColor.darkBlue),)),
                              const SizedBox(height: Dimensions.space8,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(controller.roomDetails[index].rooms?.length ?? 0, (roomIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child:MarqueeWidget(child: Text(controller.roomDetails[index].rooms?[roomIndex].roomType?.name ?? ''.tr,style: boldDefault.copyWith(color: MyColor.colorBlack.withOpacity(.7)),maxLines: 1,)),
                                  );
                                }),
                              )
                            ],
                          )
                      ),
                      Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(MyStrings.roomNo.tr,style: boldDefault.copyWith(color: MyColor.darkBlue),),
                                  const SizedBox(height: Dimensions.space8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(controller.roomDetails[index].rooms?.length ?? 0, (roomIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(controller.roomDetails[index].rooms?[roomIndex].room?.roomNumber ?? '',style: boldDefault.copyWith(color: MyColor.colorBlack.withOpacity(.7)),maxLines: 1,),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                      Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(MyStrings.farePerNight.tr,style: boldDefault.copyWith(color: MyColor.darkBlue),),
                                  const SizedBox(height: Dimensions.space8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: List.generate(controller.roomDetails[index].rooms?.length ?? 0, (roomIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(Converter.formatNumber(controller.roomDetails[index].rooms?[roomIndex].fare ?? ''),style: boldDefault.copyWith(color: MyColor.colorBlack.withOpacity(.7)),maxLines: 1,),
                                      );
                                    }),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}