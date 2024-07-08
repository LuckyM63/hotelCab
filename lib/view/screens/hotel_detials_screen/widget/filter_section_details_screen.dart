import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../../core/utils/my_images.dart';
import '../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../components/dot_widget.dart';
import '../../search_result/widget/modify_search_section.dart';

class FilterSectionDetailsScreen extends StatelessWidget {

  final String hotelId;
  final HotelDetailsScreenController controller;

  const FilterSectionDetailsScreen({
    super.key,
    required this.hotelId,
    required this.controller
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (homeController) => Column(
          children: [
            const CustomDivider(space: 6),
            const SizedBox(height: Dimensions.space8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: MarqueeWidget(
                    direction: Axis.horizontal,
                    child: MarqueeWidget(
                      direction: Axis.horizontal,
                      child: Row(
                        children: [
                          SvgPicture.asset(MyImages.detailsCalender,width: 12,height: 12,),
                          const SizedBox(width: 3,),
                          Text(
                            '${DateConverter.formatDateInDayMonth(homeController.checkInDate)} '

                            '${MyStrings.to.toLowerCase().tr} '

                              '${homeController.checkOutDate == MyStrings.checkOutDate  ? '' : DateConverter.formatDateInDayMonth(homeController.checkOutDate)}',
                            style: mediumDefault.copyWith(color: MyColor.titleTextColor),
                          ),
                          const DotWidget(),
                          Text('${homeController.numberOfRooms} ${MyStrings.room.tr}',style: mediumDefault.copyWith(color: MyColor.titleTextColor),),
                          const DotWidget(),
                          Text('${homeController.numberOfGuests} ${MyStrings.guests.tr}',style: mediumDefault.copyWith(color: MyColor.titleTextColor)),
                          const SizedBox(width: 5),

                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {

                    homeController.updateSearchData(setPresentDataIntoPrevious: true);
                    homeController.previousRoomList = List.from(homeController.roomList);

                    CustomBottomSheet(
                        child: SafeArea(
                          child: PopScope(
                            onPopInvoked: (didPop) {
                              if(controller.isClickModifySearch == false){
                                homeController.roomList = List.from(homeController.previousRoomList);
                                homeController.countTotalGuest();
                                homeController.updateSearchData(setPreviousDataIntoPresent: true);
                              }
                            },
                            child: ModifySearchSection(
                              isShowDestinationSearch: false,
                              onTap: () {

                                if(homeController.checkOutDate == MyStrings.checkOutDate){
                                  CustomSnackBar.error(errorList: [MyStrings.selectCheckOut.tr]);
                                }else{
                                  controller.isClickModifySearch = true;
                                  Get.back();
                                  controller.isClickModifySearch = false;
                                  controller.loadData(hotelId,modifiedFromDetails: true);
                                }
                              },
                              onBackPress: () {
                                if(controller.isClickModifySearch == false){
                                  homeController.roomList = List.from(homeController.previousRoomList);
                                  homeController.countTotalGuest();
                                  homeController.updateSearchData(setPreviousDataIntoPresent: true);
                                }
                                Get.back();
                              },
                            ),
                          ),
                        )
                    ).filterBottomSheet(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: MyColor.primaryColor
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(MyImages.editIcon),
                        const SizedBox(width: 5,),
                        Text(MyStrings.modify.tr,style: mediumSmall.copyWith(color: MyColor.colorWhite.withOpacity(.8)),),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const CustomDivider(space: 14,),
            MarqueeWidget(
              direction: Axis.horizontal,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "${MyStrings.checkIn.tr}: ",
                          style: regularLarge
                        ),
                        TextSpan(
                            text: DateConverter.convertTimeToTime(controller.hotelSetting?.checkinTime ?? '00:00:00'),
                            style: boldLarge
                        ),
                      ],
                    ),
                  ),
                  const DotWidget(),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "${MyStrings.checkOut.tr}: ",
                            style: regularLarge
                        ),
                        TextSpan(
                            text: DateConverter.convertTimeToTime(controller.hotelSetting?.checkoutTime ?? '00:00:00'),
                            style: boldLarge
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const CustomDivider(space: 15,),
          ],
        ),
      );
  }
}