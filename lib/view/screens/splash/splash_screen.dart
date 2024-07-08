import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/util.dart';
import 'package:booking_box/data/controller/localization/localization_controller.dart';
import 'package:booking_box/data/controller/splash/splash_controller.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/data/services/api_service.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    MyUtils.splashScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(SplashController(repo: Get.find(),localizationController: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
        backgroundColor: controller.noInternet ? MyColor.colorWhite : MyColor.primaryColor,
        body: Stack(
          children: [
            ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.darken,
                child: Image.asset(MyImages.splashBgImage,fit: BoxFit.cover,width: double.maxFinite,height: double.maxFinite,)
            ),

            Align(
                alignment: Alignment.center,
                child: Image.asset(MyImages.splashLogo,width: size.width * .65)
            ),
          ],
        ),
      ),
    );
  }
}
