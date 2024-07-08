import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/repo/popular_car/popular_car_repo.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/popular_car/popular_car_controller.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';
import '../../components/divider/horizontal_divider.dart';

class PopularCarScreen extends StatefulWidget {
  const PopularCarScreen({super.key});

  @override
  State<PopularCarScreen> createState() => _PopularCarScreenState();
}

class _PopularCarScreenState extends State<PopularCarScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<PopularCarController>().fetchPopularCarData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<PopularCarController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PopularCarRepo(apiClient: Get.find()));
    final controller =
        Get.put(PopularCarController(popularCarRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();

      scrollController.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<PopularCarController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: CustomAppBar(
            title: MyStrings.popularCar.tr,
            bgColor: MyColor.appBarColor2,
            statusBarColor: MyColor.colorWhite,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : SafeArea(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.popularCarList.length + 1,
                    shrinkWrap: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (controller.popularCarList.length == index) {
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

                      var carList = controller.popularCarList[index].carSetting;

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.carDetailsScreen,
                              arguments: carList?.ownerId.toString() ?? '-1');
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 12),
                          margin: const EdgeInsets.only(bottom: 12),
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
                                      imageUrl: carList?.ImageUrl ?? '',
                                      placeholder: (context, url) =>
                                          const CustomImageLoader(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.space12),
                              Text(carList?.name?.tr ?? '', style: boldLarge),
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
                                    carList?.address?.tr ?? '',
                                    style: regularDefault.copyWith(
                                        color: MyColor.primaryTextColor),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.space8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${carList?.starRating ?? ''} ${MyStrings.starCar.tr}",
                                    style: regularDefault,
                                  ),
                                  const HorizontalDivider(
                                      height: 12, margin: 8),
                                  Flexible(
                                    child: MarqueeWidget(
                                      child: RichText(
                                        text: TextSpan(
                                          style: regularDefault,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: MyStrings.startFrom.tr,
                                              style: regularDefault,
                                            ),
                                            TextSpan(
                                                text:
                                                    " ${controller.popularCarRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(controller.popularCarList[index].minimumFare ?? '-1', precision: 0)}",
                                                style: semiBoldDefault),
                                            TextSpan(
                                                text:
                                                    '/${MyStrings.perNight.tr}',
                                                style: regularDefault.copyWith(
                                                    color:
                                                        MyColor.bodyTextColor,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                            // You can add more TextSpan widgets for different styles
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
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
