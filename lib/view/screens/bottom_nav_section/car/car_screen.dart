import 'package:booking_box/view/screens/bottom_nav_section/car/widget/featured_car_section.dart';
import 'package:booking_box/view/screens/bottom_nav_section/car/widget/popular_car_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helper/shared_preference_helper.dart';
import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/car/car_controller.dart';
import '../../../../data/controller/filter/filter_controller.dart';
import '../../../../data/controller/search_result/search_result_controller.dart';
import '../../../../data/repo/car/car_repo.dart';
import '../../../../data/repo/filter_pram/filter_pram_repo.dart';
import '../../../../data/repo/search_result/search_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/custom_cash_image/custom_cash_network_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/snack_bar/show_custom_snackbar.dart';
import '../../../components/will_pop_widget.dart';
import '../car/widget/filter_search_section.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  void initState() {
    MyUtils.allScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CarRepo(apiClient: Get.find()));
    final controller =
        Get.put(CarController(carRepo: Get.find()), permanent: true);
    Get.put(SearchRepo(apiClient: Get.find()));
    Get.put(FilterPramRepo(apiClient: Get.find()));
    Get.put(FilterController(filterPramRepo: Get.find()));
    Get.put(SearchResultController(searchRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<CarController>(builder: (controller) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: MyColor.colorWhite,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
        child: WillPopWidget(
          nextRoute: "",
          child: Scaffold(
            extendBody: true,
            backgroundColor: MyColor.bgColor2,
            body: controller.isLoading
                ? const CustomLoader()
                : SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 16, right: 16, bottom: 16),
                          color: MyColor.bgColor2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.editProfileScreen);
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    MyImages.profile),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Text(
                                      '${MyStrings.hello.tr} ${controller.carRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.firstName)?.tr ?? MyStrings.username}',
                                      style: semiBoldOverLargeManrope.copyWith(
                                          color: MyColor.titleTextColor,
                                          fontWeight: FontWeight.w700,
                                          overflow: TextOverflow.ellipsis),
                                    ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.notificationScreen);
                                  },
                                  child: SvgPicture.asset(MyImages.bell,
                                      width: 24, height: 24),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            color: MyColor.primaryColor,
                            onRefresh: () async {
                              controller.loadData(isPullRefresh: true);
                            },
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Stack(
                                children: [
                                  FilterSearchSection(controller: controller),
                                  Container(
                                    margin: const EdgeInsets.only(top: 310),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        controller.adsList.isEmpty
                                            ? const SizedBox.shrink()
                                            : Column(
                                                children: [
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space12),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: List.generate(
                                                          controller
                                                              .adsList.length,
                                                          (index) =>
                                                              GestureDetector(
                                                                onTap: () {
                                                                  int? ownerId =
                                                                      int.tryParse(controller
                                                                              .adsList[index]
                                                                              .ownerId ??
                                                                          '-1');
                                                                  if (ownerId! >
                                                                      0) {
                                                                    if (controller.checkOutDate ==
                                                                            MyStrings
                                                                                .checkOutDate ||
                                                                        controller.checkOutDate ==
                                                                            MyStrings.startDate) {
                                                                      CustomSnackBar
                                                                          .error(
                                                                              errorList: [
                                                                            MyStrings.selectCheckOut.tr
                                                                          ]);
                                                                    } else {
                                                                      Get.toNamed(
                                                                          RouteHelper
                                                                              .carDetailsScreen,
                                                                          arguments: controller
                                                                              .adsList[index]
                                                                              .ownerId);
                                                                    }
                                                                  } else if (controller
                                                                              .adsList[
                                                                                  index]
                                                                              .url !=
                                                                          null &&
                                                                      controller
                                                                          .adsList[
                                                                              index]
                                                                          .url!
                                                                          .isNotEmpty) {
                                                                    controller.addLaunchUrl(
                                                                        controller.adsList[index].url ??
                                                                            '');
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              16),
                                                                  child: ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      child: CustomCashNetworkImage(
                                                                          imageHeight: size.height *
                                                                              .16,
                                                                          imageWidth: size.width *
                                                                              .7,
                                                                          imageUrl: controller
                                                                              .adsList[index]
                                                                              .imageUrl
                                                                              .toString())),
                                                                ),
                                                              )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Dimensions.space12),
                                                ],
                                              ),
                                        controller.popularCarList.isEmpty
                                            ? const SizedBox.shrink()
                                            : PopularCarSection(
                                                controller: controller),
                                        FeaturedCarSection(
                                            controller: controller),
                                        SizedBox(height: size.height * .02)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
