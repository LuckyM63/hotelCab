

import 'dart:convert';

import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/environment.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/model/booking_request/booking_request_response_model.dart';
import 'package:booking_box/data/model/review_booking/booking_request_model.dart';
import 'package:booking_box/data/repo/review_booking/review_booking_repo.dart';

import '../../../core/helper/date_converter.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/url_container.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../../view/screens/booking_history/booking_request_screen.dart';
import '../../model/country_model/country_model.dart';
import '../../model/global/response_model/response_model.dart';

class ReviewBookingController extends GetxController{

  ReviewBookingRepo reviewBookingRepo;
  ReviewBookingController({required this.reviewBookingRepo});

  final FocusNode nameFocusNode       = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  String initialGuestName = '';

  TextEditingController nameController       = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController searchController = TextEditingController();



  List<Country> countryList = [];

  String selectedCountryDialCode = Environment.dialCode;

  bool countryLoading = false;

  Future<void> loadData() async{

    String userCountryCode = reviewBookingRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userSelectedCountryCode) ?? '';

    await getCountryData(userCountryCode);

    String userPhoneNumber  = reviewBookingRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userPhoneNumberKey) ?? '';
    String userDialCode = selectedCountryDialCode;
    String formattedUserPhoneNumber  = Converter.removeCountryCode(userPhoneNumber,userDialCode); // bcz we need remove user country code from phone number

    selectedCountryData.code = userCountryCode;
    phoneNumberController.text = formattedUserPhoneNumber;
    String firstName = reviewBookingRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.firstName) ?? '';
    String lastName = reviewBookingRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.lastName) ?? '';

    nameController.text =  firstName + lastName;

    if(countryList.isEmpty){
      countryLoading = true;
      update();
    }

    countryLoading = false;
    update();
  }

  bool submitLoading = false;

  requestBooking() async {

    submitLoading=true;
    update();

    BookingRequestModel model = getBookingRequestData();

    ResponseModel responseModel = await reviewBookingRepo.requestBooking(model,Get.find<RoomSelectController>().selectedRoomList);

    if(responseModel.statusCode == 200){
      BookingRequestResponseModel model = BookingRequestResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: model.message?.success ??[MyStrings.success.tr]);
        Get.toNamed(RouteHelper.bookingRequestScreen,arguments: false);
        nameController.clear();
        phoneNumberController.clear();
      } else {
        CustomSnackBar.error(errorList:model.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }
    } else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading=false;
    update();
  }

  void clearTextField(){
    nameController.clear();
    phoneNumberController.clear();
    update();
  }

  BookingRequestModel getBookingRequestData() {
    var homeController = Get.find<HomeController>();
    BookingRequestModel model = BookingRequestModel(
        checkIn: DateConverter.formattedDate(homeController.checkInDate),
        checkOut:  DateConverter.formattedDate(homeController.checkOutDate),
        ownerId: Get.find<HotelDetailsScreenController>().hotelSetting?.ownerId??'',
        contactName: nameController.text,
        contactNumber: '$selectedCountryDialCode${phoneNumberController.text}',
        totalAdults: Get.find<HomeController>().numberOfAdults.toString(),
        totalChildren: Get.find<HomeController>().numberOfChildren.toString()
    );
    return model;
  }


  setSelectedCountryDialCode(String dialCode){
    selectedCountryDialCode = '+$dialCode';
    update();
  }

  String? countryName;
  String? countryCode;


  Country selectedCountryData = Country(
      code: Environment.defaultCountryCode,
      dialCode: Environment.dialCode,
      name: Environment.countryName
  );

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;

    selectedCountryDialCode = mobileCode;
    update();
  }

  var countryFlag = MyImages.defaultImageNetwork;

  Future<dynamic> getCountryData(String countryCode) async {

    ResponseModel mainResponse = await reviewBookingRepo.getCountryData();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Country>? tempList = model.data.countries;

      if (tempList.isNotEmpty) {
        countryList.clear();
        countryList.addAll(tempList);
      }

      var selectDefCountry = tempList.firstWhere(
            (country) => country.code!.toLowerCase() == countryCode.toLowerCase(),
        orElse: () => Country(
          code: Environment.defaultCountryCode,
          dialCode: Environment.dialCode,
          name: Environment.countryName
        ),
      );



      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
      }
      countryFlag = UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", selectedCountryData.code.toString().toLowerCase());
      return;

    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
      countryLoading = false;
      update();
      return;
    }
  }



  selectCountryData(Country country) {
    selectedCountryData = country;
    setCountryNameAndCode(country.name ?? '', country.code ?? '', country.dialCode??'');
    update();
  }


  /*void updateMobileCode(String code) {
    selectedCountryDialCode = code;
    update();
  }*/

  List<Country> filteredCountries = [];


}

