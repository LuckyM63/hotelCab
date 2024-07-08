import 'package:booking_box/view/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/url_container.dart';
import '../../../../core/utils/util.dart';
import '../../../../data/controller/account/profile_complete_controller.dart';
import '../../../../data/repo/account/profile_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app-bar/custom_appbar.dart';
import '../../../components/buttons/gradient_rounded_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/text-form-field/custom_text_field.dart';
import '../../../components/warning_aleart_dialog.dart';
import '../registration/widget/my_image_widget.dart';


class ProfileCompleteScreen extends StatefulWidget {

  final bool signInWithGoogle;

  const ProfileCompleteScreen({Key? key,this.signInWithGoogle = false}) : super(key: key,);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    var controller = Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData(widget.signInWithGoogle);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  bool isNumberBlank = false;

  @override
  Widget build(BuildContext context) {

    return PopScope(

      canPop: false,
      onPopInvoked: (didPop) async {
        const WarningAlertDialog().warningAlertDialog(
            context,
                () {
              Get.offAllNamed(RouteHelper.loginScreen);
            },
            titleMessage: MyStrings.areYourSure,
            subtitleMessage: MyStrings.youWantToDismiss
        );
      },

      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(
          title: MyStrings.profileComplete.tr,
          isShowBackBtn: true,
          enableCustomBackPress: true,
          onBackPress: () =>  Get.offAllNamed(RouteHelper.loginScreen),
          fromAuth: false,
          isProfileCompleted: true,
          bgColor: MyColor.primaryColor,
          iconColor: MyColor.colorWhite,
          titleColor: MyColor.colorWhite,
        ),

        body: GetBuilder<ProfileCompleteController>(
          builder: (controller) => SafeArea(
            child:controller.isLoading ? const CustomLoader() :  SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space15),
                    Text(MyStrings.pleaseCompleteYourProfile.tr,style: regularLargeManrope.copyWith(color: MyColor.titleTextColor),),
                    const SizedBox(height: Dimensions.space30),
                    CustomTextField(
                      animatedLabel: true,
                      needOutlineBorder: true,
                      fillColor: MyColor.textFieldColor,
                      leadingIcon: MyImages.userSvg,
                      labelText: MyStrings.firstName.tr,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.firstName.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.firstNameFocusNode,
                      controller: controller.firstNameController,
                      nextFocus: controller.lastNameFocusNode,
                      onChanged: (value){
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      animatedLabel: true,
                      needOutlineBorder: true,
                      fillColor: MyColor.textFieldColor,
                      leadingIcon: MyImages.userSvg,
                      labelText: MyStrings.lastName.tr,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.lastName.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.lastNameFocusNode,
                      controller: controller.lastNameController,
                      nextFocus: controller.addressFocusNode,
                      onChanged: (value){
                        return;
                      },
                    ),

                    widget.signInWithGoogle ?
                    const SizedBox(height: Dimensions.space25) : const SizedBox.shrink(),

                    widget.signInWithGoogle ?

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: isNumberBlank ? MyColor.colorRed : MyColor.textFieldColor, width: .5),
                        borderRadius: BorderRadius.circular(7),
                        color: MyColor.textFieldColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              CountryBottomSheet.bottomSheetProfile(context, controller);
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
                                onFieldSubmitted: (text) => FocusScope.of(context).requestFocus(controller.addressFocusNode),
                                onChanged: (value) {
                                  controller.mobileController.text.isNotEmpty ? isNumberBlank = false : null;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(Dimensions.space15),
                                    child: SvgPicture.asset(
                                      MyImages.phoneSvg,
                                      width: 18,
                                      height: 18,
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
                    ) : const SizedBox.shrink(),

                    const SizedBox(height: Dimensions.space5),
                    isNumberBlank
                        ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(MyStrings.enterYourPhoneNumber, style: regularSmall.copyWith(color: MyColor.colorRed)),
                    )
                        : const SizedBox.shrink(),

                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.address,
                      fillColor: MyColor.textFieldColor,
                      leadingIcon: MyImages.addressSvg,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.address.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.addressFocusNode,
                      controller: controller.addressController,
                      nextFocus: controller.stateFocusNode,
                      onChanged: (value){
                        return;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.state,
                      fillColor: MyColor.textFieldColor,
                      leadingIcon: MyImages.stateSvg,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.state.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.stateFocusNode,
                      controller: controller.stateController,
                      nextFocus: controller.cityFocusNode,
                      onChanged: (value){
                        return ;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.city.tr,
                      fillColor: MyColor.textFieldColor,
                      leadingIcon: MyImages.citySvg,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.city.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      focusNode: controller.cityFocusNode,
                      controller: controller.cityController,
                      nextFocus: controller.zipCodeFocusNode,
                      onChanged: (value){
                        return ;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),

                    CustomTextField(
                      animatedLabel: true,
                      needOutlineBorder: true,
                      labelText: MyStrings.zipCode.tr,
                      fillColor: MyColor.textFieldColor,
                      leadingIcon: MyImages.zipCode,
                      hintText: "${MyStrings.enterYour.tr} ${MyStrings.zipCode.toLowerCase().tr}",
                      textInputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      focusNode: controller.zipCodeFocusNode,
                      controller: controller.zipCodeController,
                      onChanged: (value){
                        return;
                      },
                    ),

                    const SizedBox(height: Dimensions.space35),

                    GradientRoundedButton(
                      showLoadingIcon: controller.submitLoading,
                      text:MyStrings.completeProfile.tr,
                      press: (){
                        controller.updateProfile(widget.signInWithGoogle);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
