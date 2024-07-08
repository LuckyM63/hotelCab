import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/account/profile_controller.dart';
import 'package:booking_box/data/controller/localization/localization_controller.dart';
import 'package:booking_box/data/controller/menu/my_menu_controller.dart';
import 'package:booking_box/data/repo/account/profile_repo.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/data/repo/menu_repo/menu_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/divider/custom_divider.dart';
import 'package:booking_box/view/components/will_pop_widget.dart';
import 'package:booking_box/view/screens/bottom_nav_section/menu/widget/menu_item.dart';
import 'package:booking_box/view/screens/bottom_nav_section/my_booking/booking_history/booking_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../components/warning_aleart_dialog.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(ProfileController(profileRepo: Get.find()));
    final controller =
        Get.put(MyMenuController(menuRepo: Get.find(), repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: MyColor.colorWhite,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
      child: GetBuilder<LocalizationController>(
        builder: (localizationController) => GetBuilder<MyMenuController>(
          builder: (menuController) => WillPopWidget(
            // nextRoute: RouteHelper.bottomNavBar,
            isNeedToGoBottomNav: true,
            child: Scaffold(
              backgroundColor: MyColor.bgColor2,
              body: GetBuilder<MyMenuController>(
                builder: (controller) => Column(
                  children: [
                    Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.white, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstOut,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .23,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(MyImages.menuBg),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Positioned(
                          top: size.height * .05,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: size.height * .026,
                                left: 16,
                                right: 16,
                                bottom: 16),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      MyImages.profile,
                                      height: size.height * .065,
                                      width: size.height * .065,
                                      color: Colors.black.withOpacity(.6),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${controller.getFirstName().tr} ${controller.getLastName().tr}',
                                      style: regularLargeManrope.copyWith(
                                          color: MyColor.titleTextColor,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      Get.find<ApiClient>().getUserEmail().tr,
                                      style: regularMediumLarge.copyWith(
                                          color: MyColor.titleTextColor
                                              .withOpacity(.7),
                                          fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 16),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.space15,
                                  horizontal: Dimensions.space15),
                              decoration: BoxDecoration(
                                  color: MyColor.colorWhite,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                  boxShadow: const [
                                    BoxShadow(
                                      // color: Colors.grey.shade400.withOpacity(0.05),
                                      color: Colors.white,
                                      spreadRadius: 0,
                                      blurRadius: 100,
                                      offset: Offset(0, -10),
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  MenuItems(
                                      imageSrc: MyImages.person,
                                      label: MyStrings.profile.tr,
                                      iconOpacity: 1,
                                      onPressed: () => Get.toNamed(
                                          RouteHelper.editProfileScreen)),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.textFieldFillColor,
                                  ),
                                  MenuItems(
                                      imageSrc: MyImages.history,
                                      label: MyStrings.myBookings.tr,
                                      iconOpacity: 1,
                                      onPressed: () {
                                        Get.to(const BookingHistoryScreen(
                                            isShowAppBar: true));
                                      }),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.textFieldFillColor,
                                  ),
                                  MenuItems(
                                      imageSrc: MyImages.paymentLog,
                                      label: MyStrings.paymentHistory.tr,
                                      iconOpacity: 1,
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteHelper.paymentLogScreen);
                                      }),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.textFieldFillColor,
                                  ),
                                  MenuItems(
                                      imageSrc: MyImages.bell,
                                      label: MyStrings.notificationLog.tr,
                                      iconOpacity: 1,
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteHelper.notificationScreen);
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.space13),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.space15,
                                  horizontal: Dimensions.space15),
                              decoration: BoxDecoration(
                                  color: MyColor.colorWhite,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                  boxShadow: MyUtils.getCardShadow()),
                              child: Column(
                                children: [
                                  Visibility(
                                      visible: menuController.langSwitchEnable,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MenuItems(
                                            imageSrc: MyImages.language,
                                            label: MyStrings.language.tr,
                                            iconOpacity: 1,
                                            onPressed: () {
                                              Get.toNamed(
                                                  RouteHelper.languageScreen);
                                            },
                                          ),
                                        ],
                                      )),
                                  const CustomDivider(
                                      space: Dimensions.space10,
                                      color: MyColor.textFieldFillColor),
                                  MenuItems(
                                      imageSrc: MyImages.policy,
                                      label: MyStrings.policies_.tr,
                                      iconOpacity: 1,
                                      onPressed: () {
                                        Get.toNamed(RouteHelper.privacyScreen);
                                      }),
                                  controller.menuRepo.apiClient
                                                  .sharedPreferences
                                                  .getString(
                                                      SharedPreferenceHelper
                                                          .socialId) !=
                                              null &&
                                          controller.menuRepo.apiClient
                                              .sharedPreferences
                                              .getString(SharedPreferenceHelper
                                                  .socialId)!
                                              .isNotEmpty
                                      ? const SizedBox.shrink()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CustomDivider(
                                                space: Dimensions.space10,
                                                color:
                                                    MyColor.textFieldFillColor),
                                            MenuItems(
                                                imageSrc: MyImages.lock,
                                                iconOpacity: 1,
                                                label: MyStrings.changePassword,
                                                onPressed: () => Get.toNamed(
                                                    RouteHelper
                                                        .changePasswordScreen)),
                                          ],
                                        ),
                                  const CustomDivider(
                                    space: Dimensions.space10,
                                    color: MyColor.textFieldFillColor,
                                  ),
                                  MenuItems(
                                      imageSrc: MyImages.delete,
                                      label: MyStrings.deleteAccount.tr,
                                      color: MyColor.colorRed,
                                      titleColor: MyColor.colorRed,
                                      iconOpacity: 1,
                                      onPressed: () {
                                        const WarningAlertDialog()
                                            .warningAlertDialog(
                                                subtitleMessage: MyStrings
                                                    .youWantToDelete.tr,
                                                isDelete: true,
                                                context, () {
                                          Navigator.pop(context);
                                          controller.deleteAccount();
                                        });
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimensions.space13),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.space10,
                                  horizontal: Dimensions.space15),
                              decoration: BoxDecoration(
                                  color: MyColor.colorWhite,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius),
                                  boxShadow: MyUtils.getCardShadow()),
                              child: controller.logoutLoading
                                  ? const Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            color: MyColor.primaryColor,
                                            strokeWidth: 2.00),
                                      ),
                                    )
                                  : MenuItems(
                                      imageSrc: MyImages.logout,
                                      iconOpacity: 1,
                                      label: MyStrings.logout.tr,
                                      onPressed: () {
                                        const WarningAlertDialog()
                                            .warningAlertDialog(
                                                subtitleMessage: MyStrings
                                                    .youWantToLogout.tr,
                                                context, () {
                                          Navigator.pop(context);
                                          controller.logout();
                                        });
                                      }),
                            ),
                            const SizedBox(height: Dimensions.space60 + 30)
                          ],
                        ),
                      ),
                    )
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
