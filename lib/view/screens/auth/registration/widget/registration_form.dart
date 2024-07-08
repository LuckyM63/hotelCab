import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/auth/auth/registration_controller.dart';
import 'package:booking_box/view/components/buttons/rounded_button.dart';
import 'package:booking_box/view/components/buttons/rounded_loading_button.dart';
import 'package:booking_box/view/components/text-form-field/custom_text_field.dart';
import 'package:booking_box/view/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:booking_box/view/screens/auth/registration/widget/validation_widget.dart';

import '../../../../../core/utils/url_container.dart';
import '../../../../components/buttons/gradient_rounded_button.dart';
import 'country_text_field.dart';
import 'my_image_widget.dart';

class RegistrationForm extends StatefulWidget {

  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final formKey = GlobalKey<FormState>();
  bool isNumberBlank = false;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller){
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                borderRadius: Dimensions.inputFieldBorderRadius,
                leadingIcon: MyImages.userSvg,
                fillColor: MyColor.textFieldColor,
                labelText: MyStrings.username.tr,
                controller: controller.userNameController,
                focusNode: controller.userNameFocusNode,
                textInputType: TextInputType.text,

                nextFocus: controller.emailFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterYourUsername.tr;
                  } else if(value.length<6){
                    return MyStrings.kShortUserNameError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                fillColor: MyColor.textFieldColor,
                labelText: MyStrings.email.tr,
                leadingIcon: MyImages.emailSvg,
                controller: controller.emailController,
                focusNode: controller.emailFocusNode,
                textInputType: TextInputType.emailAddress,
                borderRadius: Dimensions.inputFieldBorderRadius,
                inputAction: TextInputAction.next,
                validator: (value) {
                  if (value!=null && value.isEmpty) {
                    return MyStrings.enterYourEmailOrUsername.tr;
                  } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                    return MyStrings.invalidEmailMsg.tr;
                  }else{
                    return null;
                  }
                },
                onChanged: (value) {
                  return;
                },
              ),
              const SizedBox(height: Dimensions.space20),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: isNumberBlank ? MyColor.colorRed : MyColor.textFieldColor, width: .5),
                  borderRadius: BorderRadius.circular(7),
                  //boxShadow: MyUtils.getShadow2(blurRadius: 10),
                  color: MyColor.textFieldColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        CountryBottomSheet.bottomSheet(context, controller);
                      },
                      child: Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColor.transparentColor,
                          borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyImageWidget(
                              imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", controller.selectedCountryData.code.toString().toLowerCase()),
                              height: Dimensions.space25,
                              width: Dimensions.space40 + 2,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: Dimensions.space10),
                              child: Text(
                                "+${controller.dialCode.tr}",
                                style: regularMediumLarge,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: Dimensions.space10, top: 7),
                        child: TextFormField(
                          controller: controller.mobileController,
                          focusNode: controller.mobileFocusNode,
                          onFieldSubmitted: (text) => FocusScope.of(context).requestFocus(controller.passwordFocusNode),
                          onChanged: (value) {
                            controller.mobileController.text.isNotEmpty ? isNumberBlank = false : null;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(Dimensions.space15),
                              child: SvgPicture.asset(
                                MyImages.phoneSvg, width: 18,height: 18,colorFilter: const ColorFilter.mode(MyColor.lightGray, BlendMode.srcIn),
                              ),
                            ),
                            hintText: MyStrings.phoneHintText.tr,
                            border: InputBorder.none, // Remove border
                            filled: false, // Remove fill
                            contentPadding: const EdgeInsetsDirectional.only(top: 10, start: 0, end: 15, bottom: 0),
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
                              return ;
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
                child: Text(MyStrings.enterYourPhoneNumber, style: regularSmall.copyWith(color: MyColor.colorRed)),
              )
                  : const SizedBox.shrink(),

              const SizedBox(height: Dimensions.space20),
              Focus(
                onFocusChange: (hasFocus){
                  controller.changePasswordFocus(hasFocus);
                },
                child: CustomTextField(
                  animatedLabel: true,
                  needOutlineBorder: true,
                  isShowSuffixIcon: true,
                  isPassword: true,
                  leadingIcon: MyImages.passwordSvg,
                  borderRadius: Dimensions.inputFieldBorderRadius,
                  fillColor: MyColor.textFieldColor,
                  labelText: MyStrings.password.tr,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  nextFocus: controller.confirmPasswordFocusNode,
                  textInputType: TextInputType.text,
                  onChanged: (value) {
                    if(controller.checkPasswordStrength){
                      controller.updateValidationList(value);
                    }
                  },
                  validator: (value) {
                    return controller.validatePassword(value ?? '');
                  },
                )
              ),
              const SizedBox(height: Dimensions.textToTextSpace),
              Visibility(
                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                child: ValidationWidget(list: controller.passwordValidationRules,)
              ),
              const SizedBox(height: Dimensions.space20),
              // const SizedBox(height: Dimensions.space20),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.confirmPassword.tr,
                leadingIcon: MyImages.passwordSvg,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                inputAction: TextInputAction.done,
                isShowSuffixIcon: true,
                isPassword: true,
                onChanged: (value) {},
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: Dimensions.space25),
              Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child:   GestureDetector(
                          onTap:(){
                            Get.toNamed(RouteHelper.privacyScreen);
                          },
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: "${MyStrings.agreementPolicy.tr} ",
                                    style: regularDefault
                                ),
                                TextSpan(
                                    text: MyStrings.privacyPolicy.tr,
                                    style: regularDefault.copyWith(color: MyColor.primaryColor)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimensions.space3),
                    ],
                  ),
                )

              ],
                            ),
              const SizedBox(height: Dimensions.space30),

              GradientRoundedButton(
                showLoadingIcon: controller.submitLoading,
                text: MyStrings.signUp.tr,
                press: () {
                  if (formKey.currentState!.validate() && controller.submitLoading == false) {
                    controller.signUpUser();
                  }
                }
              ),
            ],
          ),
        );
      },
    );
  }
}