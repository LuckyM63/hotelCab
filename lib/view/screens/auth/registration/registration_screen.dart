import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/auth/registration_controller.dart';
import 'package:booking_box/data/controller/auth/login_controller.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/data/repo/auth/signup_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/components/custom_no_data_found_class.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/auth/registration/widget/registration_form.dart';

import '../../../../data/repo/auth/login_repo.dart';
import '../../../components/buttons/signin_with_google_button.dart';


class RegistrationScreen extends StatefulWidget {

  final bool isFromOnboard;

  const RegistrationScreen({Key? key,this.isFromOnboard = false}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    Get.put(RegistrationRepo(apiClient: Get.find()));
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  initialLogin(){

  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: Scaffold(
          backgroundColor: MyColor.getScreenBgColor(),
          body: controller.noInternet ? NoDataOrInternetScreen(
            isNoInternet: true,
            onChanged: (value){
              controller.changeInternet(value);
            },
          ) : controller.isLoading ? const CustomLoader() : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space30, horizontal: Dimensions.space15),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*.05),
                        Text(controller.registrationRepo.apiClient.getSiteName(),style: semiBoldOverLargeManrope.copyWith(fontSize: 24,color: MyColor.titleTextColor),),
                        const SizedBox(height: 8),
                        Text(MyStrings.quickAndEasySignup.tr,style: regularLargeManrope.copyWith(color: MyColor.bodyTextGrey),),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.05),
                  const RegistrationForm() ,
                  const SizedBox(height: Dimensions.space30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: .5,
                          color: MyColor.lineColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(MyStrings.or.tr),
                      ),
                      Expanded(
                        child: Container(
                          height: .5,
                          color: MyColor.lineColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: Dimensions.space24),
                  SignInWithGoogleButton(
                    title: MyStrings.signUpWithGoogle,
                    onTap: () async {
                      await Get.find<LoginController>().signInWithGoogle();
                    },
                  ),
              
                  const SizedBox(height: Dimensions.space24),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(MyStrings.alreadyAccount.tr, style: regularLargeManrope.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500)),
                      const SizedBox(width: Dimensions.space3),
                      TextButton(
                        onPressed: (){
                          controller.clearAllData();
                          Get.offAndToNamed(RouteHelper.loginScreen);
                        },
                        child: Text(MyStrings.signIn.tr, style: regularLargeManrope.copyWith(color: MyColor.getPrimaryColor())),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
