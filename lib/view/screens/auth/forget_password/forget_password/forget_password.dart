import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:booking_box/data/repo/auth/login_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/buttons/rounded_loading_button.dart';
import 'package:booking_box/view/components/text-form-field/custom_text_field.dart';
import 'package:booking_box/view/components/text/default_text.dart';
import 'package:booking_box/view/components/text/header_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          fromAuth: true,
          isShowBackBtn: true,
          statusBarColor: MyColor.colorWhite,
          title: MyStrings.forgetPassword.tr,
          titleColor: MyColor.titleTextColor,
          bgColor: MyColor.getScreenBgColor(),
          iconColor: MyColor.titleTextColor,
        ),
        body: GetBuilder<ForgetPasswordController>(
          builder: (auth) => SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Center(
                   child: Column(
                     children: [
                       const SizedBox(height: Dimensions.space15),

                       SvgPicture.asset(MyImages.forgotPassword,width: size.height * .15,height: size.height * .15,),

                       const SizedBox(height: Dimensions.space24),

                       HeaderText(text: MyStrings.recoverAccount.tr),
                       const SizedBox(height: 15),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 30),
                         child: DefaultText(
                           text: MyStrings.forgetPasswordSubText.tr,
                           textStyle: regularLarge.copyWith(color: MyColor.thinTextColor.withOpacity(0.8),),textAlign: TextAlign.center,),
                       ),
                     ],
                   ),
                 ),
                  const SizedBox(height: Dimensions.space40),
                  CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.emailOrUsername.tr,
                    hintText: MyStrings.usernameOrEmailHint.tr,
                    fillColor: MyColor.textFieldColor,
                    textInputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.done,
                    controller: auth.emailOrUsernameController,
                    onSuffixTap: () {},
                    onChanged: (value) {
                      return;
                    },
                    validator: (value) {
                      if (auth.emailOrUsernameController.text.isEmpty) {
                        return MyStrings.enterEmailOrUserName.tr;
                      } else {
                        return null;
                      }
                    }
                  ),
                  const SizedBox(height: Dimensions.space25),
                  auth.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                  press: () {
                    if(_formKey.currentState!.validate()){
                        auth.submitForgetPassCode();
                      }
                    },
                    text: MyStrings.submit.tr,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
