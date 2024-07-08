import 'package:booking_box/core/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/data/controller/search_result/search_result_controller.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/home/home_controller.dart';
import '../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../components/divider/horizontal_divider.dart';
import '../../../components/snack_bar/show_custom_snackbar.dart';
import 'modify_search_section.dart';
class TopSectionSearchResult extends StatelessWidget {

  final bool isFromDestination;
  final SearchResultController searchResultController;

  const TopSectionSearchResult({
    super.key,required this.isFromDestination,
    required this.searchResultController
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Container(
        color: MyColor.colorWhite,
        padding: const EdgeInsets.only(bottom: 17,top: 20),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 44),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(homeController.searchedPlaceName.tr,style: boldMediumLarge.copyWith(fontSize: 16),),
                  const SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${searchResultController.formatDateInDayMonth(homeController.checkInDate).tr} ${MyStrings.to.tr} ${searchResultController.formatDateInDayMonth(homeController.checkOutDate).tr}',style: regularSmall.copyWith(color: MyColor.bodyTextColor),),
                      const HorizontalDivider(),
                      SvgPicture.asset(MyImages.bed,width: 12,height: 12,),
                      Text('  ${homeController.numberOfRooms} ${MyStrings.rooms.tr}',style: regularSmall.copyWith(color: MyColor.bodyTextColor),),
                      const HorizontalDivider(),
                      SvgPicture.asset(MyImages.person,width: 12,height: 12,),
                      Text('  ${homeController.numberOfGuests} ${MyStrings.guests.tr}',style: regularSmall.copyWith(color: MyColor.bodyTextColor),),
                    ],),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left:MyUtils.isRtl(context) ? null :  4,
              right: MyUtils.isRtl(context) ? 4 :  null,
              child: IconButton(onPressed: (){
                Get.back();
              }, icon: const Icon(Icons.arrow_back_ios,size: 24,)),
            ),
            Positioned(
                top: 30,
                right: MyUtils.isRtl(context) ? null : 20,
                left: MyUtils.isRtl(context) ? 20 : null,
                child:GestureDetector(
                  onTap: () {
                    homeController.updateSearchData(setPresentDataIntoPrevious: true);
                    homeController.previousRoomList = List.from(homeController.roomList);
                    homeController.previousSearchPlaceName = homeController.searchedPlaceName;

                    CustomBottomSheet(
                        child: PopScope(
                          onPopInvoked: (didPop) {
                            if(searchResultController.isClickModifySearch == false){
                              homeController.roomList = List.from(homeController.previousRoomList);
                              homeController.countTotalGuest();
                              homeController.updateSearchData(setPreviousDataIntoPresent: true);
                              homeController.searchedPlaceName = homeController.previousSearchPlaceName;
                            }
                          },
                          child: ModifySearchSection(
                            isShowDestinationSearch: true,
                            onTap: () {
                              if(homeController.checkOutDate == MyStrings.checkOutDate){
                                CustomSnackBar.error(errorList: [MyStrings.selectCheckOut.tr]);
                              }else{
                                searchResultController.isClickModifySearch = true;
                                Get.back();
                                searchResultController.isClickModifySearch = false;
                                searchResultController.loadData();
                              }
                            },
                            onBackPress: () {

                              if(searchResultController.isClickModifySearch == false){
                                homeController.roomList = List.from(homeController.previousRoomList);
                                homeController.countTotalGuest();
                                homeController.updateSearchData(setPreviousDataIntoPresent: true);
                                homeController.searchedPlaceName = homeController.previousSearchPlaceName;
                              }
                              Get.back();
                            },
                          ),
                        )
                    ).filterBottomSheet(context);
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(MyImages.edit,width: 17,height: 17,colorFilter: const ColorFilter.mode(MyColor.primaryTextColor, BlendMode.srcIn),),
                    ],
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}