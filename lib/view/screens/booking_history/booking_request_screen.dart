import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_section/my_booking/request_history/booking_request_history_screen.dart';

import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/repo/my_booking_repo.dart';
import '../../../data/services/api_service.dart';

class BookingRequestScreen extends StatefulWidget {

  final bool isFromMenu;

  const BookingRequestScreen({super.key,this.isFromMenu = false});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MyBookingRepo(apiClient: Get.find()));
    final myBookingController = Get.put(MyBookingController(myBookingRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myBookingController.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookingController>(
      builder: (controller) {
        return WillPopWidget(
          isNeedToGoBottomNav: true,
          child: Scaffold(
            backgroundColor: MyColor.bgColor2,
            appBar: AppBar(
              title: Text(MyStrings.requestBookingHistory.tr,style: boldLarge.copyWith(color: MyColor.titleTextColor)),
              backgroundColor: MyColor.colorWhite,
              elevation: 0,
              leading: IconButton(
              onPressed: () {

                if(widget.isFromMenu){
                  Get.back();
                }else{
                  Get.offAllNamed(RouteHelper.bottomNavBar);
                }

              }, icon: const Icon(Icons.arrow_back_ios,color: MyColor.titleTextColor)),
            ),
            body:  const BookingRequestHistoryScreen(),
          ),
        );
      },
    );
  }
}
