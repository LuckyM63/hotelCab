import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/my_booking/my_booking_controller.dart';
import 'package:booking_box/view/components/custom_no_data_screen.dart';
import 'package:booking_box/view/components/divider/horizontal_divider.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_section/my_booking/request_history/widget/reequest_room_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../data/services/api_service.dart';
import '../../../../components/bottom-sheet/custom_bottom_sheet.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_loader/image_loader.dart';
import '../../../../components/divider/custom_divider.dart';
import '../../../../components/warning_aleart_dialog.dart';

class BookingRequestHistoryScreen extends StatefulWidget {
  const BookingRequestHistoryScreen({super.key});

  @override
  State<BookingRequestHistoryScreen> createState() =>
      _BookingRequestHistoryScreenState();
}

class _BookingRequestHistoryScreenState
    extends State<BookingRequestHistoryScreen> {
  final ScrollController scrollController = ScrollController();
  bool isHotelSelected = true; // State variable for selected booking type

  fetchData() {
    if (isHotelSelected) {
      Get.find<MyBookingController>().fetchNewBookingRequestData();
    } else {
      // Add fetching logic for Cab bookings here if necessary
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (isHotelSelected) {
        if (Get.find<MyBookingController>().hasNextRequestBooking()) {
          fetchData();
        }
      } else {
        // Handle pagination for Cab bookings here if necessary
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(_scrollListener);
      fetchData(); // Fetch initial data
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookingController>(
      builder: (controller) => Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: const EdgeInsets.only(left: 16, right: 16), // Updated margin
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Adjusted alignment
          children: [
            // Toggle buttons for Hotel and Cab bookings
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0), // Updated padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton(
                    context,
                    title: MyStrings.hotelBookings.tr,
                    isSelected: isHotelSelected,
                    onTap: () => setState(() {
                      isHotelSelected = true;
                      fetchData();
                    }),
                  ),
                  const SizedBox(width: 8),
                  _buildToggleButton(
                    context,
                    title: MyStrings.cabBookings.tr,
                    isSelected: !isHotelSelected,
                    onTap: () => setState(() {
                      isHotelSelected = false;
                      fetchData();
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.space8),
            isHotelSelected
                ? _buildHotelBookingList(controller)
                : _buildCabBookingsList(controller),
          ],
        ),
      ),
    );
  }

  // Build toggle button
  Widget _buildToggleButton(BuildContext context,
      {required String title,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.primaryColor : MyColor.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isSelected ? MyColor.primaryColor : MyColor.colorGrey,
              width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? MyColor.colorWhite : MyColor.colorBlack,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Build list for Hotel Bookings
  Widget _buildHotelBookingList(MyBookingController controller) {
    return controller.isRequestLoading
        ? const Center(child: CustomLoader())
        : controller.requestBookingList.isEmpty
            ? CustomNoDataScreen(
                title: MyStrings.noBookingRequestFound.tr,
              )
            : Expanded(
                child: SafeArea(
                  child: ListView.builder(
                    itemCount: controller.requestBookingList.length + 1,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      if (controller.requestBookingList.length == index) {
                        return controller.hasNext()
                            ? SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: CustomLoader(isPagination: true),
                                ),
                              )
                            : const SizedBox();
                      }

                      var bookingRequest = controller.requestBookingList[index];

                      return GestureDetector(
                        onTap: () {
                          CustomBottomSheet(
                              child: SafeArea(
                                  child: RequestRoomBottomSheet(
                            bookingRequest: bookingRequest,
                          ))).filterBottomSheet(context);
                        },
                        child: Container(
                          color: MyColor.bgColor2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            alignment: Alignment.center,
                                            height: 90,
                                            width: 80,
                                            fit: BoxFit.fitHeight,
                                            imageUrl: bookingRequest.owner
                                                    ?.hotelSetting?.imageUrl ??
                                                MyImages.defaultImageNetwork,
                                            placeholder: (context, url) =>
                                                const CustomImageLoader(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        const SizedBox(width: 11),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  bookingRequest
                                                          .owner
                                                          ?.hotelSetting
                                                          ?.name
                                                          ?.tr ??
                                                      '',
                                                  style: boldLarge.copyWith(
                                                      color: MyColor
                                                          .titleTextColor)),
                                              const SizedBox(
                                                  height: Dimensions.space6),
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: Converter
                                                            .formatNumber(
                                                                bookingRequest
                                                                        .totalAmount ??
                                                                    '0'),
                                                        style:
                                                            boldLarge.copyWith(
                                                                fontSize: 16)),
                                                    TextSpan(
                                                        text:
                                                            " ${Get.find<ApiClient>().getCurrencyOrUsername().tr}",
                                                        style:
                                                            boldLarge.copyWith(
                                                                fontSize: 10)),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space5),
                                              MarqueeWidget(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      MyImages.person,
                                                      width: Dimensions.space15,
                                                      height:
                                                          Dimensions.space15,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        '${bookingRequest.totalAdult} ${MyStrings.adults.tr}, ${bookingRequest.totalChild} ${MyStrings.children.tr}',
                                                        style: regularDefault
                                                            .copyWith(
                                                                color: MyColor
                                                                    .titleTextColor)),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions.space3),
                                              MarqueeWidget(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      DateConverter
                                                              .formatDateInEDayMonth(
                                                                  bookingRequest
                                                                          .checkIn ??
                                                                      '')
                                                          .tr,
                                                      style: regularDefault
                                                          .copyWith(
                                                              color: MyColor
                                                                  .titleTextColor),
                                                    ),
                                                    const HorizontalDivider(),
                                                    Text(
                                                      '${DateConverter.calculateNumberOfNights(bookingRequest.checkIn ?? '', bookingRequest.checkOut ?? '')} ${MyStrings.night.toTitleCase()}',
                                                      style: regularDefault
                                                          .copyWith(
                                                              color: MyColor
                                                                  .titleTextColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      const WarningAlertDialog()
                                          .warningAlertDialog(
                                              subtitleMessage: MyStrings
                                                  .deleteYourBooking.tr,
                                              context, () {
                                        Navigator.pop(context);
                                        controller.cancelBookingRequest(
                                            bookingRequest.id.toString());
                                        controller.setCurrentIndex(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: MyColor.titleTextColor
                                                  .withOpacity(.2),
                                              width: .5)),
                                      child: controller
                                                  .isBookingCancelLoading &&
                                              controller.currentIndex == index
                                          ? const SizedBox(
                                              height: 13,
                                              width: 13,
                                              child: CircularProgressIndicator(
                                                color: MyColor.colorRed,
                                                strokeWidth: 2.5,
                                              ))
                                          : Text(
                                              MyStrings.delete.tr,
                                              style: regularDefault.copyWith(
                                                  color: MyColor.colorRed,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                              controller.requestBookingList.length - 1 == index
                                  ? const SizedBox(
                                      height: Dimensions.space22,
                                    )
                                  : const CustomDivider(
                                      space: 18,
                                    )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
  }

  // Build list for Cab Bookings (similar structure to Hotel)
  Widget _buildCabBookingsList(MyBookingController controller) {
    return Center(
      child: Text("Cab bookings feature coming soon!",
          style: boldDefault.copyWith(color: MyColor.colorBlack)),
    );
  }
}
