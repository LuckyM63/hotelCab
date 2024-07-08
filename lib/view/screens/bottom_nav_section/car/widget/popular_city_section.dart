import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../../core/route/route.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_strings.dart';
import '../../../../../core/utils/style.dart';
import '../../../../../data/controller/car/car_controller.dart';
import '../../../../../data/model/home/home_model.dart'
    as home; // Aliased import
import '../../../../components/snack_bar/show_custom_snackbar.dart';
import 'custom_header.dart';

class PopularCitySection extends StatelessWidget {
  const PopularCitySection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<CarController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomHeader(
            title: MyStrings.popularCity,
            isShowSeeMoreButton: controller.popularCityList.length <
                controller.totalPopularCities,
            actionPress: () {
              Get.toNamed(RouteHelper.popularCityScreen);
            },
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .8,
                  mainAxisExtent: size.height * .25),
              itemCount: controller.popularCityList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                home.PopularCity cityData =
                    controller.popularCityList[index]; // Using alias

                return GestureDetector(
                  onTap: () {
                    if (controller.checkOutDate == MyStrings.checkOutDate ||
                        controller.checkOutDate == MyStrings.startDate) {
                      CustomSnackBar.error(
                          errorList: [MyStrings.selectCheckOut.tr]);
                    } else {
                      controller.manageSearchTextForDestinationClick(
                          cityData.name ?? '',
                          cityData.country?.name ?? '',
                          cityData.id.toString());
                      Get.toNamed(RouteHelper.searchResultScreen,
                          arguments: true);
                    }
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCashNetworkImage(
                          imageHeight: size.height * .4,
                          imageWidth: double.maxFinite,
                          imageUrl: cityData.imageUrl.toString(),
                        ),
                      ),
                      Positioned(
                        bottom: 13,
                        left: 17,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(Dimensions.space4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: MyColor.primaryColor),
                              child: Text(
                                "${cityData.totalHotel.toString()} ${MyStrings.hotel.tr}",
                                style: mediumDefault.copyWith(
                                    color: MyColor.colorWhite),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space8),
                            Text(
                              cityData.name.toString().tr,
                              style: boldMediumLarge.copyWith(
                                  color: MyColor.colorWhite),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Color> getImageDominantColor(String imagePath) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imagePath),
      size: const Size(200, 200), // Adjust the size as needed
    );

    Color imageColor =
        paletteGenerator.dominantColor?.color ?? MyColor.colorWhite;

    return imageColor;
  }
}
