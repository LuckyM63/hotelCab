import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/view/screens/bottom_nav_section/home/widget/quantity_button.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/home/home_controller.dart';
import '../../../../components/animated_widget/expanded_widget.dart';
import '../../../../components/divider/custom_divider.dart';
import 'custom_header.dart';
class AddingRoomCard extends StatelessWidget {

  final HomeController controller;
  final int index;

  const AddingRoomCard({
    super.key,
    required this.controller,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.colorWhite,
      child: Column(
        children: [
          CustomHeader(
            title: "${MyStrings.room.tr} ${index + 1}",
            actionText: MyStrings.remove.tr,
            actionPress: () => controller.removeRoom(index),
            isChangeActionColor: true,
          ),
          const CustomDivider(space: 5 ),
          ExpandedSection(
            expand: controller.expandIndex==index,
            duration: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(MyStrings.adults.tr,style: regularLarge.copyWith(color: MyColor.bodyTextColor),),
                    Row(
                      children: [
                        QuantityButton(
                          controller: controller,
                          icon: Icons.remove,
                          press: (){
                            controller.decreaseQuantityAdults(index);
                            // controller.changeExpandIndex(controller.numberOfRooms - 1);
                          },
                        ),
                        const SizedBox(width: Dimensions.space32,),
                        Text(controller.roomList[index].adults.toString(),style: regularLarge,),
                        const SizedBox(width: Dimensions.space32,),
                        QuantityButton(
                          press: (){
                            controller.increaseQuantityAdults(index);
                          },
                          controller: controller,
                          icon: Icons.add,
                          bgColor: MyColor.primaryColor,
                          iconColor: MyColor.colorBlack,
                        ),
                      ],
                    ),
                  ],
                ),
                const CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(MyStrings.children.tr,style: regularLarge.copyWith(color: MyColor.bodyTextColor),),
                    Row(
                      children: [
                        QuantityButton(
                          controller: controller,
                          icon: Icons.remove,
                          press: () => controller.decreaseQuantityChildren(index),
                        ),
                        const SizedBox(width: Dimensions.space32,),
                        Text("${controller.roomList[index].children}",style: regularLarge,),
                        const SizedBox(width: Dimensions.space32,),
                        QuantityButton(
                          press: () => controller.increaseQuantityChildren(index),
                          controller: controller,
                          icon: Icons.add,
                          bgColor: MyColor.primaryColor,
                          iconColor: MyColor.colorBlack,
                        ),
                      ],
                    ),
                  ],
                ),
                const CustomDivider(),
              ],
            ),)
        ],
      ),
    );
  }
}