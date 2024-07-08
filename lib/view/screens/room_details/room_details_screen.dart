import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/room_details/room_details_controller.dart';
import 'package:booking_box/view/components/custom_cash_image/custom_cash_network_image.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/divider/horizontal_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/room_details/widget/room_details_body_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_images.dart';
import '../../components/buttons/circular_back_button.dart';


class RoomDetailsScreen extends StatefulWidget {

  final int index;

  const RoomDetailsScreen({Key? key,required this.index}) : super(key: key);

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {

  @override
  void initState() {

    super.initState();
    final controller = Get.put(RoomDetailsController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadRoomDetailsData(widget.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: MyColor.transparentColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<RoomDetailsController>(
        builder: (controller) {

          return Scaffold(
              body: controller.roomList.isEmpty ? const CustomLoader() : Stack(
                children: [
                  SingleChildScrollView(
                    child: Stack(
                        children: [
                          SizedBox(
                            height: size.height * .25,
                            child: PageView.builder(
                              controller: controller.pageController,
                              itemCount: controller.roomList[widget.index].images?.length ?? 0,
                              itemBuilder: (context, index) {
                                return  GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.photoViewScreen,arguments: [controller.imageUrls,index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: MyColor.colorWhite,
                                        borderRadius: BorderRadius.circular(7)
                                    ),
                                    child: CustomCashNetworkImage(
                                      imageUrl: '${UrlContainer.domainUrl}/${controller.hotelDetailsScreenController.roomTypeImagePath}/${controller.roomList[widget.index].images?[index].image}',
                                    )
                                  ),
                                );
                              },
                              onPageChanged: (int page) {
                                controller.setCurrentPage(page);
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: size.height * .23),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: MyColor.bgColor2,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                            ),
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.roomList[widget.index].name?.tr ?? '',style: boldOverLarge.copyWith(color: MyColor.titleTextColor),),
                                  const SizedBox(height: 9),
                                  MarqueeWidget(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(MyImages.bed,width: 12,height: 12,),
                                        Text('  ${controller.roomSelectController.getBedInfo(widget.index).tr}',style: regularDefault.copyWith(color: MyColor.thinTextColor),),
                                        const HorizontalDivider(),
                                        SvgPicture.asset(MyImages.person,width: 12,height: 12,),
                                        Text('  ${controller.roomList[widget.index].totalAdult} ${MyStrings.adults.tr}',style: regularDefault.copyWith(color: MyColor.thinTextColor),),
                                        Text(' ${controller.roomList[widget.index].totalChild} ${MyStrings.children.tr}',style: regularDefault.copyWith(color: MyColor.thinTextColor),),
                                      ],
                                    ),
                                  ),

                                  const CustomDivider(),

                                  RoomDetailsBodySection(index: widget.index)
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            left: 30,
                            top: size.height * .21,
                            child: Center(
                              child: Row(
                                  children: List.generate(controller.roomList[widget.index].images?.length ?? 0, (index) => Container(
                                    width: 7,
                                    height: 7,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                        color: controller.roomList[widget.index].images!.length < 2 ? MyColor.transparentColor : controller.currentPage == index ? MyColor.primaryColor : MyColor.colorWhite.withOpacity(.8),
                                        shape: BoxShape.circle
                                    ),
                                  ),)
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),

                  Positioned(
                    top: 34,
                    left: MyUtils.isRtl(context) ? null : 10,
                    right: MyUtils.isRtl(context) ? 10 : null,
                    child: const CircularBackButton()
                  ),
                ],
              )
          );
        }
      ),
    );
  }
}