import 'dart:convert';

import 'package:get/get.dart';
import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/account/profile_controller.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/model/profile/profile_response_model.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/data/repo/menu_repo/menu_repo.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';

import '../../model/authorization/authorization_response_model.dart';

class MyMenuController extends GetxController{

  MenuRepo menuRepo;
  GeneralSettingRepo repo;
  MyMenuController({required this.menuRepo, required this.repo});
  
  var profileController = Get.find<ProfileController>();

  bool logoutLoading = false;
  bool isLoading     = true;
  bool noInternet    = false;

  bool balTransferEnable = true;
  bool langSwitchEnable  = true;

  void loadData()async{

    isLoading = true;
    update();

    // await configureMenuItem();

    await getSocialId();
    
    isLoading = false;
    update();

  }

  String? socialId;

  getSocialId()async{

     ResponseModel responseModel = await profileController.profileRepo.loadProfileInfo();

     if(responseModel.statusCode == 200){
       ProfileResponseModel profileResponseModel = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));

       if(profileResponseModel.data!=null && profileResponseModel.status?.toLowerCase()==MyStrings.success.toLowerCase()){
         socialId = profileResponseModel.data?.user?.socialId ?? '';

       }

     }else {
       CustomSnackBar.error(errorList: [responseModel.message]);
     }

  }

  Future<void>deleteAccount()async{
    isLoading = true;
    update();

    ResponseModel responseModel = await menuRepo.deleteAccount();

    if(responseModel.statusCode == 200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.status.toString() == MyStrings.success){
        await menuRepo.clearSharedPrefData();

        Get.offAllNamed(RouteHelper.loginScreen);

        CustomSnackBar.success(successList: [MyStrings.deleteAccountSuccessMsg]);
      }else{
        CustomSnackBar.error(errorList: model.message?.success ?? [MyStrings.somethingWentWrong]);
      }

    }else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  Future<void>logout()async{
    logoutLoading = true;
    update();

    await menuRepo.logout();
    CustomSnackBar.success(successList: [MyStrings.logoutSuccessMsg]);

    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);

  }



  bool isTransferEnable = true;
  bool isWithdrawEnable = true;
  bool isInvoiceEnable  = true;

  String getFirstName(){
    return repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.firstName) ?? "User";
  }

  String getLastName(){
    return repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.lastName) ?? "";
  }

}