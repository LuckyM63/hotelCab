import 'dart:convert';

import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/model/profile/profile_response_model.dart';
import 'package:booking_box/data/model/user_post_model/user_post_model.dart';
import 'package:booking_box/data/repo/account/profile_repo.dart';
import 'package:booking_box/environment.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/country_model/country_model.dart';
import '../../model/global/response_model/response_model.dart';



class ProfileCompleteController extends GetxController {

  ProfileRepo profileRepo;
  ProfileCompleteController({required this.profileRepo});

  ProfileResponseModel model = ProfileResponseModel();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController  = TextEditingController();
  TextEditingController emailController     = TextEditingController();
  TextEditingController mobileNoController  = TextEditingController();
  TextEditingController addressController   = TextEditingController();
  TextEditingController stateController     = TextEditingController();
  TextEditingController zipCodeController   = TextEditingController();
  TextEditingController cityController      = TextEditingController();
  TextEditingController mobileController      = TextEditingController();
  TextEditingController searchController = TextEditingController();



  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode  = FocusNode();
  FocusNode emailFocusNode     = FocusNode();
  FocusNode mobileNoFocusNode  = FocusNode();
  FocusNode addressFocusNode   = FocusNode();
  FocusNode stateFocusNode     = FocusNode();
  FocusNode zipCodeFocusNode   = FocusNode();
  FocusNode cityFocusNode      = FocusNode();
  FocusNode countryFocusNode   = FocusNode();
  FocusNode mobileFocusNode    = FocusNode();


  bool isLoading     = true;
  bool submitLoading = false;

  void initData(bool googleSignIn) async {
    isLoading = true;
    update();

    if(googleSignIn){
      firstNameController.text = profileRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.firstName) ?? '';
      lastNameController.text = profileRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.lastName) ?? '';
    }

    if(googleSignIn){
      await getCountryData();
    }

    isLoading = false;
    update();
  }

  updateProfile(bool isGoogleSignIn)async{

    String firstName    = firstNameController.text;
    String lastName     = lastNameController.text.toString();
    String address      = addressController.text.toString();
    String city         = cityController.text.toString();
    String zip          = zipCodeController.text.toString();
    String state        = stateController.text.toString();

    String mobile       = mobileController.text.toString();
    String mobileCode_  = mobileCode ?? '';
    String countryCode_ = countryCode ?? '';
    String country      = countryName ?? '';


    if(firstName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.kFirstNameNullError]);
      return;
    }else if(lastName.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.kLastNameNullError]);
      return;
    }else if(mobile.isEmpty && isGoogleSignIn){
      CustomSnackBar.error(errorList: [MyStrings.enterYourPhoneNumber]);
      return;
    }


    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.firstName, firstName);
    profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.lastName, lastName);
    if(mobile.isNotEmpty && isGoogleSignIn){
      profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, mobile);
      profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userSelectedCountryCode, countryCode_);
    }

    submitLoading=true;
    update();

    UserPostModel model=UserPostModel(
        image: null, firstname: firstName, lastName: lastName,
        mobile: mobile, email: '', username: '', countryCode: countryCode_,
        country: country, mobileCode: mobileCode_, address: address,
        state: state, zip: zip, city: city
    );

    bool b= await profileRepo.updateProfile(model,false);

    if(b){
      if(isGoogleSignIn){
        profileRepo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
      }
      Get.offAllNamed(RouteHelper.bottomNavBar);
    }

    submitLoading=false;
    update();
  }



  ///------------------------


  String? countryName;
  String? countryCode;
  String? mobileCode;

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  bool countryLoading = true;
  List<Country> countryList = [];

  Future<dynamic> getCountryData() async {

    ResponseModel mainResponse = await profileRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Country>? tempList = model.data.countries;

      if (tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }

      var selectDefCountry = tempList.firstWhere(
            (country) => country.code?.toLowerCase() == Environment.defaultCountryCode.toLowerCase(),
        orElse: () => Country(),
      );
      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
        setCountryNameAndCode(selectDefCountry.name.toString(), selectDefCountry.code.toString(), selectDefCountry.dialCode.toString());
      }
      countryLoading = false;
      update();
      return;

    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
      countryLoading = false;
      update();
      return;
    }
  }

  Country selectedCountryData = Country();

  selectCountryData(Country value) {
    selectedCountryData = value;
    update();
  }

  String dialCode = Environment.dialCode;
  void updateMobilecode(String code) {
    dialCode = code;
    update();
  }

  List<Country> filteredCountries = [];

}
