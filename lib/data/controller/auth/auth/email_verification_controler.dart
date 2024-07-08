import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/model/authorization/authorization_response_model.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/repo/auth/sms_email_verification_repo.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';

class EmailVerificationController extends GetxController {


  SmsEmailVerificationRepo repo;
  EmailVerificationController({required this.repo});


  bool needSmsVerification     = false;
  bool isProfileCompleteEnable = false;

  String currentText = "";
  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading     = true;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();
    ResponseModel responseModel = await repo.sendAuthorizationRequest();

    if (responseModel.statusCode == 200) {

      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status == 'error') {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
      }

    } else {
      CustomSnackBar.error(errorList:[responseModel.message]);
    }

    isLoading = false;
    update();
  }


  Future<void> verifyEmail(String text) async {

    if (text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading=true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if (model.status == MyStrings.success) {
          CustomSnackBar.success(successList: model.message?.success??[(MyStrings.emailVerificationSuccess)]);
          if(needSmsVerification){
            Get.offAndToNamed(RouteHelper.smsVerificationScreen, arguments: [isProfileCompleteEnable,needTwoFactor]);
          } else if(needTwoFactor){
            Get.offAndToNamed( RouteHelper.twoFactorScreen,arguments: isProfileCompleteEnable);
          }
          else{
            Get.offAndToNamed(isProfileCompleteEnable?
            RouteHelper.profileCompleteScreen : RouteHelper.bottomNavBar);
          }

      } else {
        CustomSnackBar.error(errorList: model.message?.error??[(MyStrings.emailVerificationFailed)]);
      }
    }
    else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    submitLoading=false;
    update();
  }

  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: true);
    resendLoading = false;
    update();
  }

}
