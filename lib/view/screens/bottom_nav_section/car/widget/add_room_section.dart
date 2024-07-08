import 'package:booking_box/view/screens/bottom_nav_section/car/widget/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/car/car_controller.dart';
import '../../../../components/bottom-sheet/bottom_sheet_header_row.dart';
import '../../../../components/divider/custom_divider.dart';
import 'adding_room_card.dart';

class AddRoomsSection extends StatelessWidget {
  final bool isFromHome;

  final CarController controller;

  const AddRoomsSection(
      {super.key, required this.controller, this.isFromHome = false});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (controller.isClickDone == false) {
          controller.roomList = List.from(controller.previousRoomList);
          controller.countTotalGuest();
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            BottomSheetHeaderRow(
              header: MyStrings.selectGuests.tr,
              onCancelButtonTap: () {
                // controller.roomList.removeRange(1, controller.roomList.length);
                controller.roomList = List.from(controller.previousRoomList);
                controller.countTotalGuest();
                Get.back();
              },
            ),
            const CustomDivider(space: 2),
            Column(
              children: List.generate(
                controller.roomList.length,
                (index) => GestureDetector(
                    onTap: () {
                      controller.changeExpandIndex(index);
                    },
                    child:
                        AddingRoomCard(controller: controller, index: index)),
              ),
            ),

            ///add another room button
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.addRoom();
                    // controller.countTotalGuest();
                    // controller.changeExpandIndex(controller.numberOfRooms - 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: .5)),
                    child: Row(
                      children: [
                        QuantityButton(
                          press: () {},
                          controller: controller,
                          icon: Icons.add,
                          bgColor: MyColor.primaryColor,
                          iconColor: MyColor.colorBlack,
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          MyStrings.addAnotherRoom.tr,
                          style: regularLarge,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.countTotalGuest();
                    controller.isClickDone = true;
                    Get.back();
                    controller.isClickDone = false;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      MyStrings.done.tr,
                      style: boldLarge.copyWith(color: MyColor.colorWhite),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
