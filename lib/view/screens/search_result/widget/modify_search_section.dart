import 'package:booking_box/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../components/calender/custom_calender.dart';
import '../../../components/divider/custom_divider.dart';
import '../../bottom_nav_section/home/widget/add_room_section.dart';

class ModifySearchSection extends StatelessWidget {

  final bool isShowDestinationSearch;
  final VoidCallback onTap;
  final VoidCallback onBackPress;

  const ModifySearchSection({
    super.key,
    this.isShowDestinationSearch = false,
    required this.onTap,
    required this.onBackPress
  });

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      builder: (controller) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(MyStrings.hotel.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 16),),
                  ),
                  GestureDetector(
                    onTap: onBackPress,
                    child: Align(
                      alignment: MyUtils.isRtl(context) ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                          color: MyColor.colorWhite,
                          padding: const EdgeInsetsDirectional.only(start: 6,end: 20,top: 6,bottom: 10),

                          child: const Icon(Icons.arrow_back_ios,size: 17,weight: 17,color: MyColor.titleTextColor,)),
                    ),
                  )
                ],
              ),
              const CustomDivider(space: 4,),
              isShowDestinationSearch?
              GestureDetector(
                onTap: () {
                  // Get.find<HomeController>().searchDataList.clear();
                  Get.toNamed(RouteHelper.searchScreen);
                },
                child: Container(
                  color: MyColor.colorWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(MyImages.location,),
                          const SizedBox(width: 8,),
                          Text(MyStrings.searchCityHotel.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor,fontSize: 12),),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(controller.searchedPlaceName.tr,style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 18),),
                      const SizedBox(height: 3),
                      Text(controller.searchedPlaceCountry.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor.withOpacity(.7),fontSize: 11),),
                    ],
                  ),
                ),
              ) : const SizedBox.shrink(),
              isShowDestinationSearch? const CustomDivider(space: 15) : const SizedBox.shrink(),
              const SizedBox(height: Dimensions.space10,),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{
                        await showCustomDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 370)),
                          initialDateRange: controller.checkOutDate == MyStrings.checkOutDate ?
                          DateTimeRange(
                            start:DateTime.now(),
                            end: DateTime.now().add(const Duration(days: 1))
                          ):DateTimeRange(
                              start: controller.dateTimeFormat(controller.checkInDate),
                              end: controller.dateTimeFormat(controller.checkOutDate)
                          ),
                        );
                      },
                      child: Container(
                        color: MyColor.colorWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(MyImages.calender,width: 12,height: 12,colorFilter: ColorFilter.mode(MyColor.titleTextColor.withOpacity(.7), BlendMode.srcIn)),
                                const SizedBox(width: 4),
                                Text(MyStrings.checkIN.tr,style: regularDefault.copyWith(color: MyColor.primaryTextColor,fontSize: 12),)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(controller.checkInDate.tr,style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15),),
                            const SizedBox(height: 4),

                            Text(controller.checkInDaysName.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor.withOpacity(.7)),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                        color: MyColor.colorWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(MyImages.calender,width: 12,height: 12,colorFilter: ColorFilter.mode(MyColor.titleTextColor.withOpacity(.7), BlendMode.srcIn)),
                                const SizedBox(width: 4),
                                Text(MyStrings.checkOUT.tr,style: regularDefault.copyWith(color: MyColor.primaryTextColor,fontSize: 12),)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(controller.checkOutDate.tr,style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15)),
                            const SizedBox(height: 4),
                            controller.checkOutDate == MyStrings.checkOutDate ? const Text('') :
                            Text(controller.checkOutDaysName.tr,style: regularSmall.copyWith(color: MyColor.titleTextColor.withOpacity(.7)),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const CustomDivider(space: 15),
              GestureDetector(
                onTap: () {
                  controller.changeExpandIndex(controller.numberOfRooms - 1,true);
                  CustomBottomSheet(
                      horizontalPadding: Dimensions.space20,
                      child: GetBuilder<HomeController>(
                        builder: (controller) => AddRoomsSection(controller: controller),
                      )
                  ).customBottomSheet(context);
                },
                child: Container(
                  color: MyColor.colorWhite,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(MyImages.person,width: 12,height: 12,colorFilter: ColorFilter.mode(MyColor.titleTextColor.withOpacity(.7), BlendMode.srcIn)),
                                const SizedBox(width: 4),
                                Text(MyStrings.guest.tr,style: regularDefault.copyWith(color: MyColor.primaryTextColor,fontSize: 12),)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text("${controller.numberOfGuests} ${MyStrings.guests.tr}",style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15),),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(MyImages.person,width: 12,height: 12,colorFilter: ColorFilter.mode(MyColor.titleTextColor.withOpacity(.7), BlendMode.srcIn)),
                                const SizedBox(width: 4),
                                Text(MyStrings.rooms.toUpperCase().tr,style: regularDefault.copyWith(color: MyColor.primaryTextColor,fontSize: 12),)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('${controller.numberOfRooms} ${MyStrings.rooms.tr}',style: semiBoldLarge.copyWith(color: MyColor.titleTextColor,fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .021,),
                  decoration: BoxDecoration(
                    color: MyColor.primaryColor,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Text(MyStrings.modifySearch.tr,style: boldLarge.copyWith(color: MyColor.colorWhite,fontSize: 15),),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}