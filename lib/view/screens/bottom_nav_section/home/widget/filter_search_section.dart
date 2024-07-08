import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:booking_box/view/components/buttons/gradient_rounded_button.dart';
import 'package:booking_box/view/components/calender/custom_calender.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/home/home_controller.dart';
import 'add_room_section.dart';
class FilterSearchSection extends StatelessWidget {

  final  HomeController controller;
  final bool isShowSearchButton;

  const FilterSearchSection({
    super.key,
    required this.controller,
    this.isShowSearchButton = true
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Positioned(
      top:10,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space16),
        decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(Dimensions.space8),
            boxShadow: [
              BoxShadow(color: MyColor.naturalDark.withOpacity(.2), offset: const Offset(0, -1), blurRadius: 1),
              BoxShadow(color: MyColor.naturalDark.withOpacity(.2), offset: const Offset(0, 1), blurRadius: 1),
            ]

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(RouteHelper.searchScreen),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColor.textFieldDisableBorderColor,width: .5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    Text(MyStrings.searchCityHotel.tr,style: regularSmall.copyWith(color: MyColor.thinTextColor,fontSize: 11),),
                    Text(controller.searchedPlaceName.tr,style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15),),
                    Text(controller.searchedPlaceCountry.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor.withOpacity(.7),fontSize: 13),),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: ()async{

                      await showCustomDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 370)),
                        initialDateRange: DateTimeRange(start: DateTime.now(), end:  DateTime.now().add(const Duration(days: 1))),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: MyColor.textFieldDisableBorderColor,width: .5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text(MyStrings.checkIN.tr,style: regularSmall.copyWith(color: MyColor.thinTextColor,fontSize: 11),),
                          Text(controller.checkInDate.tr,style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15),),
                          Text(controller.checkInDaysName.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor.withOpacity(.7),fontSize: 13),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: GestureDetector(
                    onTap: ()async{
                      controller.setIsClickCheckOut(true);

                      await showCustomDateRangePicker(
                        context: context,
                        firstDate: controller.dateTimeFormat(controller.checkInDate,addition: true),
                        lastDate: DateTime.now().add(const Duration(days: 370)),
                      );

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: MyColor.textFieldDisableBorderColor,width: .5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(MyStrings.checkOUT.tr,style: regularSmall.copyWith(color: MyColor.thinTextColor,fontSize: 11),),
                          Text(controller.checkOutDate.tr,style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15),),
                          controller.checkOutDate == MyStrings.checkOutDate ? const Text('') :
                          Text(controller.checkOutDaysName.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor.withOpacity(.7),fontSize: 13),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8,),
            GestureDetector(
              onTap: () {
                controller.previousRoomList = List.from(controller.roomList);
                controller.changeExpandIndex(controller.numberOfRooms - 1,true);
                CustomBottomSheet(
                    horizontalPadding: Dimensions.space20,
                    child: GetBuilder<HomeController>(
                      builder: (controller) => AddRoomsSection(controller: controller,isFromHome: true),
                    )
                ).customBottomSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColor.textFieldDisableBorderColor,width: .5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.roomsAndGuests.tr,style: regularSmall.copyWith(color: MyColor.thinTextColor,fontSize: 11)),
                    const SizedBox(height: Dimensions.space5),
                    Text("${controller.numberOfGuests} ${MyStrings.guests.tr}, ${controller.numberOfRooms} ${MyStrings.rooms.tr}",style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 14,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16,),
          isShowSearchButton?
            GradientRoundedButton(
                text: MyStrings.search.tr,
                press: () {
                  if(controller.checkOutDate == MyStrings.checkOutDate || controller.checkOutDate == MyStrings.startDate){
                    CustomSnackBar.error(errorList: [MyStrings.selectCheckOut.tr]);
                  }else{
                    Get.toNamed(RouteHelper.searchResultScreen,arguments: false);
                  }
                },
            ):const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}





