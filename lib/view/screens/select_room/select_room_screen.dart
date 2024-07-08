import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/select_room/widget/add_room_section.dart';
import 'package:booking_box/view/screens/select_room/widget/edit_room_bottom_sheet.dart';
import 'package:booking_box/view/screens/select_room/widget/hotel_preview_section.dart';
import 'package:booking_box/view/screens/select_room/widget/select_room_header_section.dart';

import '../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../components/divider/custom_divider.dart';
class SelectRoomScreen extends StatefulWidget {
  const SelectRoomScreen({super.key});

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {


  @override
  void initState() {

    final controller = Get.put(RoomSelectController());
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadRoomList();
    });
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<RoomSelectController>(
      builder: (controller) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: MyColor.transparentColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark
          ),
          child: WillPopScope(
            onWillPop: () async {
              controller.clearTotalRoomCount();
              Get.back();
              return Future.value(false);
            },
            child: Scaffold(
              backgroundColor: MyColor.bgColor2,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const SelectRoomHeaderSection(),
                  Expanded(
                    child: SingleChildScrollView(

                      physics: const BouncingScrollPhysics(),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          children: List.generate(controller.roomList.length, (index) => Column(
                            children: [
                              const SizedBox(height: Dimensions.space8),
                              HotelPreviewSection(index: index),
                              const CustomDivider(color: MyColor.bodyTextColor,space: 5,),
                              AddRoomSectionSelectScreen(index: index),

                              controller.roomList.length-1 == index ? const SizedBox(height: 20,) :
                              const CustomDivider(color: MyColor.bodyTextColor,thickness: 2,space: 0),
                            ],
                          ),),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

              floatingActionButton: controller.selectedRoomList.isEmpty ? const SizedBox.shrink() : GestureDetector(
                onTap: () {
                  CustomBottomSheet(
                      child: const SafeArea(child: EditRoomBottomSheet())
                  ).filterBottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.tealColor
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${MyStrings.selectedRoom.tr} ${controller.selectedRoomList.length}",style: boldDefault.copyWith(color: MyColor.colorWhite),),
                      const SizedBox(width: 6),
                      SvgPicture.asset(MyImages.edit,width: 12,height: 12,colorFilter: const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn),)
                    ],
                  ),
                ),
              ),

              bottomNavigationBar: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: MyColor.primaryColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: MarqueeWidget(
                                    child: Text("${Converter.formatNumber(controller.totalPayableAmount.toString(),precision: 2)} ${Get.find<ApiClient>().getCurrencyOrUsername()}",style: mediumSemiLarge.copyWith(color: MyColor.colorWhite),))
                                ),
                              ],
                            ),

                            const SizedBox(height: 8,),

                            MarqueeWidget(
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '+${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(controller.taxAmount.toString())} ',
                                        style: regularDefault.copyWith(color: MyColor.colorWhite,fontWeight: FontWeight.w700)
                                    ),
                                    TextSpan(
                                        text: controller.hotelDetailsScreenController.hotelSetting?.taxName??'',
                                        style: regularSmall.copyWith(color: MyColor.colorWhite)
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // MarqueeWidget(child: Text('+${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(controller.taxAmount.toString())} ${controller.hotelDetailsScreenController.hotelSetting?.taxName??''}',style: regularSmall.copyWith(color: MyColor.colorWhite),)),

                            const SizedBox(height: 8,),
                            Text('${MyStrings.forText.tr} ${controller.homeController.numberOfNights()} ${MyStrings.night.toTitleCase().tr}',style: regularSmall.copyWith(color: MyColor.colorWhite),)
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      GestureDetector(
                        onTap: () {
                          if(controller.totalAssignedAdultOnRoom >= controller.homeController.numberOfAdults
                              && controller.totalAssignedChildrenOnRoom >= controller.homeController.numberOfChildren){
                            Get.toNamed(RouteHelper.reviewBookingScreen);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                          decoration: BoxDecoration(
                              color: controller.totalAssignedAdultOnRoom >= controller.homeController.numberOfAdults
                                      && controller.totalAssignedChildrenOnRoom >= controller.homeController.numberOfChildren
                                  ? MyColor.colorYellow : MyColor.colorYellow.withOpacity(.8),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Text(MyStrings.next.tr,style: regularMediumLarge.copyWith(
                              color: controller.totalAssignedAdultOnRoom >= controller.homeController.numberOfAdults
                                  && controller.totalAssignedChildrenOnRoom >= controller.homeController.numberOfChildren
                                  ? MyColor.primaryTextColor : MyColor.primaryColor.withOpacity(.6),fontWeight: FontWeight.w500)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




