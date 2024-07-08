import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/booking_details/booking_details_controller.dart';
import 'package:booking_box/data/repo/booking_details/booking_details_repo.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/screens/booking_details/widget/checkin_checkout_section.dart';
import 'package:booking_box/view/screens/booking_details/widget/hotel_info.dart';
import 'package:booking_box/view/screens/booking_details/widget/room_details_widget.dart';
import 'package:booking_box/view/screens/booking_details/widget/summary_section.dart';

import '../../../core/utils/util.dart';
import '../../../data/services/api_service.dart';
class BookingDetailsScreen extends StatefulWidget {

  final String id;
  const BookingDetailsScreen({super.key,required this.id});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BookingDetailsRepo(apiClient: Get.find()));
    var bookingDetailsController = Get.put(BookingDetailsController(bookingDetailsRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bookingDetailsController.loadBookingDetailsData(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<BookingDetailsController>(
      builder: (controller) =>  Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: CustomAppBar(
          title: MyStrings.bookingDetails.tr,
          bgColor: MyColor.colorWhite,
          statusBarColor: MyColor.colorWhite,
          isShowBackBtn: true,
        ),
        body: controller.isLoading ? const CustomLoader() : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MyStrings.hotelDetails.tr,style: boldOverLargeRajdhani),
              const CustomDivider(space: Dimensions.space10,),
              HotelInfo(controller: controller),
              const CustomDivider(space: Dimensions.space10,),
              CheckinCheckoutSection(controller: controller),
              const CustomDivider(space: Dimensions.space10,),
              const SizedBox(height: Dimensions.space6),
              GestureDetector(
                onTap: () {
                  controller.toggleRoomDetails();
                },
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(4),
                        topRight: const Radius.circular(4),
                        bottomLeft: controller.isRoomDetails? const Radius.circular(0.0) : Radius.circular(4),
                        bottomRight: controller.isRoomDetails? const Radius.circular(0.0) : Radius.circular(4),
                      ),
                      boxShadow: MyUtils.getShadow2()
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(MyStrings.roomDetails.tr,style: boldLarge.copyWith(fontSize: 16),),
                      Icon(controller.isRoomDetails? Icons.expand_less : Icons.expand_more,color: MyColor.colorBlack,)
                    ],
                  ),
                ),
              ),
              controller.isRoomDetails ?
              RoomDetailsWidget(controller: controller) : const SizedBox.shrink(),
              const SizedBox(height: Dimensions.space10),
              Text(MyStrings.paymentInformation.tr,style: boldOverLargeRajdhani),
              const SizedBox(height: 16),
              SummarySection(controller: controller),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}










