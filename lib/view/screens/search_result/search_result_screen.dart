import 'package:booking_box/data/controller/filter/filter_controller.dart';
import 'package:booking_box/data/repo/filter_pram/filter_pram_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/controller/search_result/search_result_controller.dart';
import 'package:booking_box/data/repo/search_result/search_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_no_data_screen.dart';
import 'package:booking_box/view/screens/search_result/widget/top_section.dart';

import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../../components/divider/horizontal_divider.dart';


class SearchResultScreen extends StatefulWidget {

  final bool isFromDestination;

  const SearchResultScreen({Key? key, this.isFromDestination = false}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<SearchResultController>().fetchNewResultData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {

      if(Get.find<SearchResultController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SearchRepo(apiClient: Get.find()));
    Get.put(FilterPramRepo(apiClient: Get.find()));
    Get.put(FilterController(filterPramRepo: Get.find()));

    final searchResultController = Get.put(SearchResultController(searchRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchResultController.loadData(isFromDestination: widget.isFromDestination);

      scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      builder: (homeController) => GetBuilder<SearchResultController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.bgColor,
          body: controller.isLoading ? const CustomLoader() : Column(
            children: [

              TopSectionSearchResult(isFromDestination: widget.isFromDestination,searchResultController: controller),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                  child: controller.searchResultList.isEmpty ? CustomNoDataScreen(
                    title: MyStrings.noHotelFound.tr,
                  ) :
                  SafeArea(
                    top: false,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.searchResultList.length + 1,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if(controller.searchResultList.length == index){
                          return controller.hasNext() ? SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: CustomLoader(isPagination: true),
                            ),
                          ) : const SizedBox();
                        }
                        var hotelResult = controller.searchResultList[index];
                        return  GestureDetector(
                          onTap: () {
                            controller.setHotelAndOwnerId(hotelResult);
                            Get.toNamed(RouteHelper.hotelDetailsScreen,arguments: hotelResult.ownerId.toString());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 12),
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
                                          imageUrl: "${controller.logoPath}/${hotelResult.logo}",
                                          imageHeight: size.height * .19,
                                          imageWidth: size.width,
                                        )
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.space12),
                                Text(hotelResult.name?.tr ??'',style: semiBoldLarge,maxLines: 2,overflow: TextOverflow.ellipsis),
                                const SizedBox(height: Dimensions.space8),
                                Row(
                                  children: [
                                    SvgPicture.asset(MyImages.location,colorFilter: const ColorFilter.mode(MyColor.bodyTextColor, BlendMode.srcIn)),
                                    const SizedBox(width: Dimensions.space8),
                                    Expanded(child: Text(hotelResult.hotelAddress?.tr ?? '',style: regularDefault.copyWith(color: MyColor.primaryTextColor),maxLines: 2,overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                                const SizedBox(height: Dimensions.space8,),
                                Row(
                                  children: [
                                    Text("${hotelResult.starRating} ${MyStrings.starHotel.tr}",style: regularDefault,),
                                    const HorizontalDivider(height: 12,margin: 8),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          style: regularDefault,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: MyStrings.startFrom.tr,
                                              style: regularDefault,
                                            ),
                                            TextSpan(
                                                text: " ${controller.searchRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(controller.searchResultList[index].minimumFare ?? '0',precision: 0)}",
                                                style: semiBoldDefault
                                            ),
                                            TextSpan(
                                                text: '/${MyStrings.perNight.tr}',
                                                style: regularDefault.copyWith(color: MyColor.bodyTextColor)
                                            ),
                                            // You can add more TextSpan widgets for different styles
                                          ],
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
                ),
              ),
            ],
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: controller.isLoading || controller.searchResultList.isEmpty ? const SizedBox.shrink() : GestureDetector(
            onTap : (){
              Get.toNamed(RouteHelper.filterScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: size.height * .011),
              decoration: BoxDecoration(
                color: MyColor.primaryColor,
                borderRadius: BorderRadius.circular(7)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(MyImages.filter,colorFilter: const ColorFilter.mode(MyColor.colorWhite, BlendMode.srcIn),),
                  const SizedBox(width: Dimensions.space8),
                  Text(MyStrings.filter.tr,style: mediumLarge.copyWith(color: MyColor.colorWhite),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
















