import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/filter/filter_controller.dart';
import 'package:booking_box/data/repo/filter_pram/filter_pram_repo.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/screens/filter/widget/rating_and_class_section.dart';

import '../../../data/controller/search_result/search_result_controller.dart';
import '../../../data/services/api_service.dart';
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FilterPramRepo(apiClient: Get.find()));
    final controller = Get.put(FilterController(filterPramRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(controller.isLoaded == false){
        controller.loadData();
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.colorWhite,
    ));

    return GetBuilder<FilterController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.bgColor2,
          appBar: CustomAppBar(
            title: MyStrings.filter.tr,
            isShowBackBtn: true,
            bgColor: MyColor.appBarColor2,
            statusBarColor: MyColor.colorWhite,
            actionTextPress: () {
              controller.resetFilter();
            },
          ),
          body: controller.isLoading ? const CustomLoader() : SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                   Container(
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       color: MyColor.colorWhite,
                       borderRadius: BorderRadius.circular(7)
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(MyStrings.price.tr,style: regularLarge,),
                             GestureDetector(
                               onTap:() {
                                 controller.onResetClick();
                               },
                               child: Text(MyStrings.reset.tr,style: regularLarge.copyWith(color: MyColor.primaryColor),)
                             ),
                           ],
                         ),
                         const SizedBox(height: Dimensions.space10),
                         RangeSlider(
                           activeColor: MyColor.getPrimaryColor(),
                           inactiveColor: MyColor.bodyTextColor,
                           values: controller.currentRangeValues!,
                           max: double.tryParse(controller.maxPrice)??500,
                           min: double.tryParse(controller.minPrice)??100,
                           divisions: 20,
                           onChanged: (RangeValues values) {
                             controller.updateCurrentRangeValue(values);
                           },
                         ),
                         const SizedBox(height: Dimensions.space3),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('${MyStrings.min.tr}: ${controller.filterPramRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}${controller.selectedMinPrice}',style: regularDefault.copyWith(color: MyColor.bodyTextColor)),
                             Text(
                               '${MyStrings.max.tr}: ${controller.filterPramRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}${controller.selectedMaxPrice}',
                               style: regularDefault.copyWith(color: MyColor.bodyTextColor),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                
                    RatingAndClassSection(controller: controller),
                
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: controller.isLoading ? const SizedBox.shrink() :  SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
              child: RoundedButton(
                verticalPadding: MediaQuery.of(context).size.height * .021,
                text: MyStrings.filter_.tr,
                press: () {
                  controller.storeAmenitiesFacilitiesId();
                  Get.back();
                  Get.find<SearchResultController>().loadData(isFilter: true);
                },
              ),
            ),
          ),
        )
    );
  }
}




