import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/featured_hotel/featured_hotel_controller.dart';
import 'package:booking_box/data/repo/featured_hotel/featured_hotel_repo.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/featured_car/featured_car_controller.dart';
import '../../../data/repo/featured_car/featured_car_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';

class FeaturedCarScreen extends StatefulWidget {
  const FeaturedCarScreen({super.key});

  @override
  State<FeaturedCarScreen> createState() => _FeaturedCarScreen();
}

class _FeaturedCarScreen extends State<FeaturedCarScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<FeaturedCarController>().fetchFeaturedCarData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<FeaturedCarController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FeaturedCarRepo(apiClient: Get.find()));
    final controller =
    Get.put(FeaturedCarController(featuredCarRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();

      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<FeaturedCarController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: CustomAppBar(
            title: MyStrings.featuredCar.tr,
            bgColor: MyColor.appBarColor2,
            statusBarColor: MyColor.colorWhite,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.featuredCarList.length + 1,
              shrinkWrap: true,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (controller.featuredCarList.length == index) {
                  return controller.hasNext()
                      ? SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CustomLoader(isPagination: true),
                    ),
                  )
                      : const SizedBox();
                }

                var carList = controller.featuredCarList[index].carSetting;

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.carDetailsScreen,
                        arguments: carList?.ownerId.toString() ?? '-1');
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                height: size.height * .22,
                                width: size.width,
                                fit: BoxFit.cover,
                                imageUrl: carList?.imageUrl ??
                                    MyImages.defaultImageNetwork,
                                placeholder: (context, url) =>
                                const CustomImageLoader(),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space16),
                        Text(carList?.name?.tr ?? '',
                            style: semiBoldLarge),
                        const SizedBox(height: Dimensions.space8),
                        Row(
                          children: [
                            SvgPicture.asset(MyImages.location,
                                colorFilter: const ColorFilter.mode(
                                    MyColor.bodyTextColor,
                                    BlendMode.srcIn)),
                            const SizedBox(width: Dimensions.space8),
                            Expanded(
                                child: Text(
                                  carList?.hotelAddress?.tr ?? '',
                                  style: regularDefault.copyWith(
                                      color: MyColor.primaryTextColor),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
