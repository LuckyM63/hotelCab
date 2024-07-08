import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/home/home_controller.dart';
import '../../../../components/snack_bar/show_custom_snackbar.dart';
import 'custom_header.dart';
class FeaturedHotelSection extends StatelessWidget {

  final HomeController controller;
  final bool isShowHeading;
  final int numberOfCardShowing;

  const FeaturedHotelSection({
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
              title: MyStrings.featuredHotel.tr,
              isShowSeeMoreButton: controller.featuredHotelList.length < controller.totalFeaturedOwner,
              actionPress: () {
                Get.toNamed(RouteHelper.featuredHotelScreen);
              },),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: List.generate(controller.featuredHotelList.length, (index){

                  var hotelSettings = controller.featuredHotelList[index].hotelSetting;

                  return GestureDetector(
                    onTap: () {

                      if(controller.checkOutDate == MyStrings.checkOutDate || controller.checkOutDate == MyStrings.startDate){
                        CustomSnackBar.error(errorList: [MyStrings.selectCheckOut.tr]);
                      }else{
                        Get.toNamed(RouteHelper.hotelDetailsScreen,arguments: hotelSettings?.ownerId.toString());
                      }
                    },
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 20),
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                          color: MyColor.colorWhite,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CustomCashNetworkImage(
                                    imageHeight: size.height * .14,
                                    imageWidth: 250,
                                    imageUrl: hotelSettings?.imageUrl ?? '',
                                  )
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.space16),
                          Text(hotelSettings?.name.toString().tr ?? '',style: semiBoldLarge),
                          const SizedBox(height: Dimensions.space8),
                          Row(
                            children: [
                              SvgPicture.asset(MyImages.location,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn),),
                              const SizedBox(width: Dimensions.space8),
                              Expanded(child: Text(hotelSettings?.hotelAddress.toString().tr ?? '',style: regularDefault.copyWith(color: MyColor.primaryTextColor),maxLines: 1,overflow: TextOverflow.ellipsis,))
                            ],
                          ),
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