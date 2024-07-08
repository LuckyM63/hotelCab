import 'package:booking_box/core/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/data/repo/my_booking_repo.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_section/my_booking/booking_history/booking_history_screen.dart';
import 'package:booking_box/view/screens/bottom_nav_section/my_booking/request_history/booking_request_history_screen.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../data/services/api_service.dart';
class MyBookingScreen extends StatefulWidget {

  final int bookingInitialTab;

  const MyBookingScreen({super.key,this.bookingInitialTab = 0});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with SingleTickerProviderStateMixin{

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MyBookingRepo(apiClient: Get.find()));
    final myBookingController = Get.put(MyBookingController(myBookingRepo: Get.find()));
    tabController = TabController(length: 2, vsync: this,initialIndex: 0,);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myBookingController.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyColor.colorWhite,
      statusBarBrightness: Brightness.light
    ));

    return GetBuilder<MyBookingController>(
      builder: (controller) => WillPopWidget(
        isNeedToGoBottomNav: true,
        child: Scaffold(
          backgroundColor: controller.isLoading?Colors.white : MyColor.bgColor2,
          body: controller.isLoading ? const CustomLoader() :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space15),
                height: Dimensions.space40 + 3,
                decoration: BoxDecoration(
                  color: MyColor.colorWhite,
                  borderRadius: BorderRadius.circular(Dimensions.space50),
                    boxShadow: const [
                      BoxShadow(color: Color.fromARGB(25, 0, 0, 0), offset: Offset(0, 1), blurRadius: 1),
                      BoxShadow(color: Color.fromARGB(25, 0, 0, 0), offset: Offset(0, 1), blurRadius: 1),
                    ]
                ),
                child: TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                    return states.contains(MaterialState.focused) ? null : Colors.transparent;
                  }),
                  controller: tabController,
                  unselectedLabelColor: MyColor.titleTextColor,
                  labelColor: MyColor.colorWhite,
                  labelStyle: regularMediumLarge.copyWith(),
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Make it rounded
                    color: MyColor.primaryColor.withOpacity(.7), // Change the color to green
                  ),
                  tabs: [
                    Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: MarqueeWidget(child: Text(MyStrings.myBookings.tr))),
                    ),
                    Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: MarqueeWidget(child: Text(MyStrings.bookingRequests.tr))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children:  const [
                    BookingHistoryScreen(),
                    BookingRequestHistoryScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
  }
}
