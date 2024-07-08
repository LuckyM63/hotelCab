import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/home/home_controller.dart';
import '../../../../components/divider/horizontal_divider.dart';
import '../../../../components/snack_bar/show_custom_snackbar.dart';
import 'custom_header.dart';
class PopularHotelSection extends StatelessWidget {

  final HomeController controller;
  final bool isShowHeading;
  final int numberOfCardShowing;

  const PopularHotelSection({
    super.key,
    required this.controller,
    this.isShowHeading = true,
    this.numberOfCardShowing = 2
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(isShowHeading)
            CustomHeader(
              title: MyStrings.popularHotel,
              isShowSeeMoreButton: controller.popularHotelList.length < controller.totalPopularHotel,
              actionPress: () {
                Get.toNamed(RouteHelper.popularHotelScreen);
              },
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: List.generate(controller.popularHotelList.length, (index){

                  var hotelSettings = controller.popularHotelList[index].hotelSetting;

                  return GestureDetector(
                    onTap: () {
                      if(controller.checkOutDate == MyStrings.checkOutDate || controller.checkOutDate == MyStrings.startDate){
                        CustomSnackBar.error(errorList: [MyStrings.selectCheckOut.tr]);
                      }else{
                        Get.toNamed(RouteHelper.hotelDetailsScreen,arguments: hotelSettings?.ownerId.toString() ?? '');
                      }
                    },
                    child: Container(
                      width: 265,
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 12),
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                          color: MyColor.colorWhite,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CustomCashNetworkImage(
                                imageHeight: size.height * .14,
                                imageWidth: 250,
                                imageUrl:  hotelSettings?.imageUrl.toString() ?? '',
                              )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.space12),
                              Text(hotelSettings?.name.toString().tr ?? '',style: boldLarge),
                              const SizedBox(height: Dimensions.space8),
                              Row(
                                children: [
                                  SvgPicture.asset(MyImages.location,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                                  const SizedBox(width: Dimensions.space8),
                                  Expanded(child: MarqueeWidget(child: Text(hotelSettings?.hotelAddress.toString().tr ?? '',style: regularDefault.copyWith(color: MyColor.primaryTextColor),overflow: TextOverflow.ellipsis,)))
                                ],
                              ),
                              const SizedBox(height: Dimensions.space8),
                              Row(
                                children: [
                                  Text("${hotelSettings?.starRating ?? ''} ${MyStrings.starHotel.tr}",style: regularDefault,),
                                  const HorizontalDivider(height: 12,margin: 8),
                                  Expanded(
                                    child: MarqueeWidget(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: regularDefault,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: MyStrings.startFrom.tr,
                                              style: regularDefault,
                                            ),
                                            TextSpan(
                                                text: " ${controller.homeRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(controller.popularHotelList[index].minimumFare ?? '0',precision: 0)}",
                                                style: mediumDefault.copyWith(fontWeight: FontWeight.w600)
                                            ),
                                            TextSpan(
                                                text: "/${MyStrings.perNight.tr}",
                                                style: regularDefault.copyWith(color: MyColor.bodyTextColor)
                                            ),
                                            // You can add more TextSpan widgets for different styles
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}