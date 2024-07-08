import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/data/controller/review_booking/review_booking_controller.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/repo/review_booking/review_booking_repo.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_loader/image_loader.dart';
import 'package:booking_box/view/components/marquee_widget/marquee_widget.dart';
import 'package:booking_box/view/screens/review_booking/widget/booking_text_field.dart';
import 'package:booking_box/view/screens/review_booking/widget/country_bottom_sheet_review_booking.dart';
import 'package:booking_box/view/screens/review_booking/widget/room_review_section.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/url_container.dart';
import '../../../core/utils/util.dart';
import '../../../data/services/api_service.dart';
import '../auth/registration/widget/my_image_widget.dart';
import '../hotel_detials_screen/widget/custom_read_more.dart';
class ReviewBookingScreen extends StatefulWidget {
  const ReviewBookingScreen({super.key});

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReviewBookingRepo(apiClient: Get.find()));
    final controller = Get.put(ReviewBookingController(reviewBookingRepo: Get.find()),permanent: true);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  bool isNumberBlank = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewBookingController>(
      builder: (reviewBookingController) => GetBuilder<RoomSelectController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.bgColor,
          appBar: CustomAppBar(
            title: MyStrings.previewBooking.tr,
            isTitleCenter: true,
            isShowBackBtn: true,
            enableCustomBackPress: true,
            bgColor: MyColor.appBarColor2,
            statusBarColor: MyColor.colorWhite,
            onBackPress: () {
              reviewBookingController.clearTextField();
              Get.back();
            },
          ),
          body: reviewBookingController.countryLoading ? const CustomLoader() : SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  const RoomReviewSection(),
                  Get.find<HotelDetailsScreenController>().hotelSetting!.cancellationPolicy!.isEmpty? const SizedBox.shrink() :
                  const SizedBox(height: 23,),
                  Get.find<HotelDetailsScreenController>().hotelSetting!.cancellationPolicy!.isEmpty? const SizedBox.shrink() :
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: MyColor.colorRed,width: 1)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MyStrings.cancellationPolicy.tr,style: boldDefault.copyWith(fontSize: 16,color: MyColor.titleTextColor),),
                        const SizedBox(height: 18,),
                        // Text(Get.find<HotelDetailsScreenController>().hotelSetting?.cancellationPolicy?.tr ?? '',style: mediumLarge.copyWith(color: MyColor.bodyTextColor2),),
                        CustomReadMoreText(
                          Get.find<HotelDetailsScreenController>().hotelSetting?.cancellationPolicy?.tr ?? '',
                          trimLines: 7,
                          colorClickableText: MyColor.primaryColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: MyStrings.seeMore.tr,
                          trimExpandedText: MyStrings.seeLess.tr,
                          moreStyle:regularLarge.copyWith(color: MyColor.primaryColor,fontWeight: FontWeight.w600),
                          lessStyle: regularLarge.copyWith(color: MyColor.primaryColor,fontWeight: FontWeight.w600),
                          style: mediumLarge.copyWith(color: MyColor.bodyTextColor2)
                        ),
                        const SizedBox(height: 4,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 23,),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: MyColor.colorWhite,
                        borderRadius: BorderRadius.circular(7),
                    ),
                    child: Form(
                      key:  formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(MyStrings.contactDetails.tr,style: boldDefault.copyWith(fontSize: 16,color: MyColor.titleTextColor),),
                          const SizedBox(height: 10,),
                          Text(MyStrings.passportOrGovApproveID.tr, style: regularLarge.copyWith(color: MyColor.bodyTextColor2)),
                          const SizedBox(height: 15),
                          BookingTextField(
                            controller: reviewBookingController.nameController,
                            labelText: MyStrings.enterGuestName.tr,
                            focusNode: reviewBookingController.nameFocusNode,
                            nextFocus: reviewBookingController.phoneNumberFocusNode,
                            fillColor: MyColor.textFieldColor,
                            onChanged: (value){},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return MyStrings.enterYourName.tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 17),
            
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: isNumberBlank ? MyColor.colorRed : MyColor.textFieldColor, width: .5),
                              borderRadius: BorderRadius.circular(7),
                              color: MyColor.textFieldColor,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10,vertical: 1),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    CountryBottomSheetReviewBooking.bottomSheet(context, reviewBookingController);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: MyColor.transparentColor,
                                      borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        reviewBookingController.countryLoading ? const CustomImageLoader() :
                                        MyImageWidget(
                                          imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", reviewBookingController.selectedCountryData.code.toString().toLowerCase()),
                                          height: Dimensions.space25,
                                          width: Dimensions.space40 + 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(start: Dimensions.space10),
                                          child: Text(
                                            "+${reviewBookingController.selectedCountryDialCode.tr}",
                                            style: regularMediumLarge,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(start: Dimensions.space10, top: .5),
                                    child: TextFormField(
                                      controller: reviewBookingController.phoneNumberController,
                                      focusNode: reviewBookingController.phoneNumberFocusNode,
                                      onChanged: (value) {
                                        reviewBookingController.phoneNumberController.text.isNotEmpty ? isNumberBlank = false : null;
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(Dimensions.space15),
                                          child: SvgPicture.asset(
                                            MyImages.phoneSvg,
                                            width: 18,
                                            height: 18,
                                            colorFilter: const ColorFilter.mode(MyColor.lightGray, BlendMode.srcIn),
                                          ),
                                        ),
                                        hintText: MyStrings.phoneHintText.tr,
                                        border: InputBorder.none, // Remove border
                                        filled: false, // Remove fill
                                        contentPadding: const EdgeInsetsDirectional.only(top: 13, start: 0, end: 15, bottom: 0),
                                        hintStyle: regularMediumLarge.copyWith(color: MyColor.hintTextColor),
                                      ),
                                      keyboardType: TextInputType.phone, // Set keyboard type to phone
                                      style: regularMediumLarge,
                                      cursorColor: MyColor.primaryColor, // Set cursor color to red
                                      validator: (value) {

                                        if (value!.isEmpty) {
                                          setState(() {
                                            isNumberBlank = true;
                                          });
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
            
                          const SizedBox(height: Dimensions.space5),
                          isNumberBlank
                              ? Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(MyStrings.enterYourPhoneNumber.tr, style: regularSmall.copyWith(color: MyColor.colorRed)),
                          )
                              : const SizedBox.shrink(),
            
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space20,)
                ],
              ),
            ),
          ),
          bottomNavigationBar:  reviewBookingController.countryLoading ? const SizedBox.shrink() : SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: MyColor.primaryColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: MarqueeWidget(child: Text("${Converter.formatNumber(controller.totalPayableAmount.toString(),precision: 2)} ${Get.find<ApiClient>().getCurrencyOrUsername()}",style: mediumSemiLarge.copyWith(color: MyColor.colorWhite),))),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space8),
                        MarqueeWidget(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: '+${Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true)}${Converter.formatNumber(controller.taxAmount.toString())} ',
                                    style: regularDefault.copyWith(color: MyColor.colorWhite,fontWeight: FontWeight.w700)
                                ),
                                TextSpan(
                                    text: controller.hotelDetailsScreenController.hotelSetting?.taxName??'',
                                    style: regularSmall.copyWith(color: MyColor.colorWhite)
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space8),
                        Text('${MyStrings.forText.tr} ${controller.homeController.numberOfNights()} ${MyStrings.night.toTitleCase().tr}',style: regularSmall.copyWith(color: MyColor.colorWhite),)
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.space12),
                  GestureDetector(
                    onTap: () {
                      if(formKey.currentState!.validate() && !isNumberBlank){
                        reviewBookingController.requestBooking();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
                      decoration: BoxDecoration(
                          color: MyColor.colorYellow,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: reviewBookingController.submitLoading ? const SizedBox(height: 16 , width:  16,child: CircularProgressIndicator(color: MyColor.primaryTextColor,strokeWidth: 2,)) :
                      Text(MyStrings.requestBooking.tr,style: regularLarge.copyWith(color: MyColor.primaryTextColor,fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}


