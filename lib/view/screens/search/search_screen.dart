import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_no_data_screen.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/search/widget/search_text_field.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/controller/home/home_controller.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<HomeController>().fetchNewSearchList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if(Get.find<HomeController>().hasNext()){
        fetchData();
      }
    }
  }

  @override
  void initState() {

    final controller = Get.find<HomeController>();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.searchController.clear();
      controller.loadSearchDestinationData();
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
    return GetBuilder<HomeController>(
      builder: (controller) => PopScope(

        onPopInvoked: (didPop) {
          controller.setPageNumberAndKeyword(1, '');
          controller.isSearchListLoading = true;
        },

        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColor.colorWhite,
          appBar: CustomAppBar(
            title: MyStrings.selectDestination.tr,
            bgColor: MyColor.colorWhite,
            statusBarColor: MyColor.colorWhite,
            enableCustomBackPress: true,
            onBackPress: () {
              controller.setPageNumberAndKeyword(1, '');
              controller.isSearchListLoading = true;
              Get.back();
            },
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45,
                    child: CustomSearchTextField(
                      onSuffixTap: () {
                        controller.setPageNumberAndKeyword(0, controller.searchController.text);
                        controller.fetchNewSearchList();
                      },
                      controller: controller.searchController,
                      labelText: MyStrings.searchDestination.tr,
                      focusNode: controller.searchFocusNode,
                      fillColor: MyColor.backgroundColor,
                      inputAction: TextInputAction.search,
                      onEditCompleted: () {
                        controller.setPageNumberAndKeyword(0, controller.searchController.text);
                        controller.fetchNewSearchList();

                        if(controller.searchController.text.isNotEmpty){
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return MyStrings.searchSomething.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),

                  controller.isSearchListLoading == true ? Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .25,),
                      const CustomLoader(),
                    ],
                  ) :

                  controller.searchDataList.isEmpty ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .18,),
                        CustomNoDataScreen(
                          title: MyStrings.noSearchResultFound.tr,
                        ),
                      ],
                    ),
                  ) :

                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: controller.searchDataList.length + 1,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {

                      if(controller.searchDataList.length == index){
                        return controller.hasNext() ? SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CustomLoader(isPagination: true),
                          ),
                        ) : const SizedBox();
                      }

                      return GestureDetector(
                        onTap: () {
                          controller.setUserSearchText(controller.searchDataList[index]);
                          controller.setPageNumberAndKeyword(1, '');
                          Get.back();
                        },
                        child: Column(
                          children: [
                            Container(
                              color: MyColor.colorWhite,
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CustomCashNetworkImage(
                                          imageUrl: controller.searchDataList[index].imageUrl ?? MyImages.defaultImageNetwork,
                                          imageWidth: 35,
                                          imageHeight: 35,
                                          borderRadius: 2,
                                        ),
                                        const SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MarqueeWidget(child: Text(controller.searchDataList[index].name?.tr ?? '',style: semiBoldLarge,)),
                                              Text(MyStrings.city.tr,style: mediumDefault.copyWith(color: MyColor.naturalDark),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(controller.searchDataList[index].country?.name.toString().tr ?? '',style: regularLarge.copyWith(color: MyColor.naturalDark),)
                                ],
                              ),
                            ),
                            controller.searchDataList.length - 1 == index ? const SizedBox.square() :
                            const CustomDivider(space: 3,color:MyColor.colorWhite,)
                          ],
                        ),
                      );
                    },),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
