import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/view/screens/bottom_nav_section/home/home_screen.dart';
import 'package:booking_box/view/screens/bottom_nav_section/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/bottom_nav_section/car/car_screen.dart';
import '../../screens/bottom_nav_section/my_booking/my_booking_screen.dart';
import 'nav_bar_item_widget.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    const HomeScreen(),
    const CarScreen(),
    const MyBookingScreen(),
    const MenuScreen()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          // backgroundColor: MyColor.bgColor2,
          body: screens[currentIndex],
          bottomNavigationBar: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.space8, horizontal: 9),
              margin: const EdgeInsets.only(bottom: 17, left: 10, right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: MyColor.colorWhite,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(25, 0, 0, 0),
                        offset: Offset(0, -3),
                        blurRadius: 1),
                    BoxShadow(
                        color: Color.fromARGB(25, 0, 0, 0),
                        offset: Offset(0, 3),
                        blurRadius: 1),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarItem(
                      label: MyStrings.hotel,
                      imagePath: MyImages.hotelSvg,
                      index: 0,
                      isSelected: currentIndex == 0,
                      press: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      }),
                  const SizedBox(width: Dimensions.navBarWidth),
                  NavBarItem(
                      label: MyStrings.car,
                      imagePath: MyImages.cab,
                      index: 1,
                      isSelected: currentIndex == 1,
                      press: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      }),
                  const SizedBox(width: Dimensions.navBarWidth),
                  NavBarItem(
                      label: MyStrings.booking.tr,
                      imagePath: MyImages.bottomNavBooking,
                      index: 2,
                      isSelected: currentIndex == 2,
                      press: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      }),
                  const SizedBox(width: Dimensions.navBarWidth),
                  NavBarItem(
                      label: MyStrings.menu,
                      imagePath: MyImages.category,
                      index: 4,
                      isSelected: currentIndex == 3,
                      press: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
