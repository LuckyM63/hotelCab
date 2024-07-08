import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/account/profile_controller.dart';
import 'package:booking_box/data/repo/account/profile_repo.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/custom_appbar.dart';
import 'package:booking_box/view/components/custom_loader/custom_loader.dart';
import 'package:booking_box/view/screens/edit_profile/widget/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(ProfileController(profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: MyColor.colorWhite,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<ProfileController>(
        builder: (controller) => Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: CustomAppBar(
            isShowBackBtn: true,
            bgColor: MyColor.getAppBarColor(),
            title: MyStrings.editProfile.tr,
            titleColor: MyColor.colorWhite,
            iconColor: MyColor.colorWhite,
          ),
          body: controller.isLoading ? const CustomLoader() : SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    color: MyColor.primaryColor,
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding:  EdgeInsets.only(left: Dimensions.space15, right: Dimensions.space15, top: Dimensions.space20, bottom: Dimensions.space20),
                    child: Column(
                      children:[
                        EditProfileForm()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
