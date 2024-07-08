import 'package:booking_box/core/route/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/popular_city/popular_city_controller.dart';
import '../../../data/repo/popular_destination/popular_destination_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';
import '../search_result/search_result_screen.dart';
class PopularCityScreen extends StatefulWidget {
  const PopularCityScreen({super.key});

  @override
  State<PopularCityScreen> createState() => _PopularCityScreenState();
}

class _PopularCityScreenState extends State<PopularCityScreen> {

  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<PopularCityController>().fetchNewPopularCityData();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<PopularCityController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PopularCityRepo(apiClient: Get.find()));
    final controller = Get.put(PopularCityController(popularCityRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
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
    return GetBuilder<PopularCityController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: CustomAppBar(
            title: MyStrings.popularCity.tr,
            bgColor: MyColor.appBarColor2,
            statusBarColor: MyColor.colorWhite,
          ),
          body: controller.isLoading ? const CustomLoader() : SafeArea(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: size.width * .03,mainAxisSpacing: size.width * .03,childAspectRatio: .8,mainAxisExtent: size.height*.3),
              itemCount: controller.popularCityList.length + 1,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              itemBuilder: (context, index) {
            
                if(controller.popularCityList.length == index){
                  return controller.hasNext() ? SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CustomLoader(isPagination: true,),
                    ),
                  ) : const SizedBox();
                }
            
                var cityData = controller.popularCityList[index];
            
                return  GestureDetector(
                  onTap: () {
                    Get.find<HomeController>().manageSearchTextForDestinationClick(
                      cityData.name ?? '',  cityData.country?.name ?? '', cityData.id.toString()
                    );
                    Get.toNamed(RouteHelper.searchResultScreen,arguments: true);
                    // Get.to(const SearchResultScreen(isFromDestination: true));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // child: Image.asset(controller.cityImageList[index],fit: BoxFit.cover,height: 300,),
                          child: CustomCashNetworkImage(
                            imageHeight: size.height * .4,
                            imageWidth: size.width,
                            imageUrl: cityData.imageUrl.toString(),
                          )
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
                                    color: MyColor.primaryColor
                                ),
                                child: Text("${cityData.totalHotel.toString()} ${MyStrings.hotel.tr}",style: mediumDefault.copyWith(color: MyColor.colorWhite),),
                              ),
                              const SizedBox(height: Dimensions.space8),
                              Text(cityData.name.toString().tr,style: boldMediumLarge.copyWith(color: MyColor.colorWhite),)
                            ],
                          ),
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
