import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/data/controller/onboarding/onboard_controller.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/screens/auth/registration/registration_screen.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../../../core/utils/util.dart';
import '../../components/buttons/custom_rounded_button.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {

  @override
  void initState() {
    MyUtils.splashScreen();
    Get.put(OnboardController());
    super.initState();
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GetBuilder<OnboardController>(
      builder: (controller) =>
          Scaffold(
            backgroundColor: MyColor.transparentColor,
                  body: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.darken,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      scrollBehavior: const CupertinoScrollBehavior(),
                      controller: controller.controller,
                      itemCount: 4,
                      onPageChanged: (int index) {
                        controller.setCurrentIndex(index);
                      },
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(controller.onboardImageList[controller.currentIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric( vertical: Dimensions.space50,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.onboardTitleList.length-1 == controller.currentIndex ?
                    Expanded(child: GestureDetector(
                      onTap: (){
                        Get.to(const RegistrationScreen(isFromOnboard: true,));
                        Get.find<ApiClient>().sharedPreferences.setBool(SharedPreferenceHelper.firstTimeAppOpeningStatus, false);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: Dimensions.space10 - 1),
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(width: 1,color: MyColor.colorWhite)
                        ),
                        child: Text(MyStrings.signUp.tr,style: semiBoldMediumLarge.copyWith(color: MyColor.colorWhite,fontSize: 15),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ),
                    )):

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(controller.onboardTitleList.length, (index) => Container(
                        height: controller.currentIndex == index ? 12 : 10,
                        width: controller.currentIndex == index ? 12 : 10,
                        margin: const EdgeInsets.only(right: Dimensions.space5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: controller.currentIndex == index ? MyColor.primaryColor : MyColor.thinTextColor,
                        ),
                      ),
                      ),
                    ),

                    controller.onboardTitleList.length-1 == controller.currentIndex ? const SizedBox(width: 10,) : const SizedBox.shrink(),

                    controller.onboardTitleList.length-1 == controller.currentIndex ?
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.loginScreen);
                          Get.find<ApiClient>().sharedPreferences.setBool(SharedPreferenceHelper.firstTimeAppOpeningStatus, false);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: Dimensions.space10 - 1),
                          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: MyColor.primaryColor
                          ),
                          child: Text(MyStrings.signIn.tr,style: semiBoldMediumLarge.copyWith(color: MyColor.colorWhite,fontSize: 16),textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ),
                      ),
                    ):
                    Row(
                      children: [
                        TextButton(onPressed: () {
                          controller.setCurrentIndex(controller.onboardTitleList.length-1);
                        }, child:controller.onboardTitleList.length - 1  == controller.currentIndex?
                        const SizedBox.shrink() :
                        Text(MyStrings.skip.tr,style: semiBoldMediumLarge.copyWith(color: MyColor.colorWhite,fontSize: 15),)),
                        const SizedBox(width: 16),
                        CustomRoundedButton(
                          verticalPadding: 10,
                            horizontalPadding: 15,
                            labelName:controller.onboardTitleList.length - 1 == controller.currentIndex ? MyStrings.signIn.tr : MyStrings.next.tr,
                            buttonColor: MyColor.getPrimaryColor(),
                            press: (){
                              if (controller.currentIndex < controller.onboardTitleList.length - 1) {
                                controller.controller?.nextPage(
                                  duration: const Duration(milliseconds: 1),
                                  curve: Curves.easeIn,
                                );
                              }
                            }
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .04),
                    Text(
                      controller.onboardTitleList[controller.currentIndex].tr,
                      textAlign: TextAlign.center,
                      style: boldOverLarge.copyWith(fontSize: 24,color: MyColor.colorWhite)
                    ),
                    SizedBox(height: size.height * .015),
                    Text(
                        controller.onboardSubTitleList[controller.currentIndex].tr.toCapitalized(),
                        style: regularDefault.copyWith(fontSize: 15,color: MyColor.colorWhite)
                    ),
                    SizedBox(height: size.height * .19,)
                  ],
                ),
              ),
            ),
          ],)),
    );
  }
}
