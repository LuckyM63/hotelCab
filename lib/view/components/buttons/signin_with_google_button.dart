import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/my_strings.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/auth/login_controller.dart';

class SignInWithGoogleButton extends StatelessWidget {

  final VoidCallback onTap;
  final String title;

  const SignInWithGoogleButton({
    super.key,
    required this.onTap,
    this.title = MyStrings.signInWithGoogle
  });

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return GetBuilder<LoginController>(
      builder: (controller) => SizedBox(
        width: size.width,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            color: MyColor.colorWhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.isSocialSubmitLoading ?
                  const SizedBox(
                      height:15,
                      width: 15 ,
                      child: CircularProgressIndicator(color: MyColor.colorBlack,strokeWidth: 2,)
                  ):

                  Row(
                    children: [
                      SvgPicture.asset(MyImages.google,width: 18,height: 18,),
                      const SizedBox(width: Dimensions.space16,),
                      Text(title.tr,style: semiBoldOverLargeManrope.copyWith(fontSize: 14),),
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