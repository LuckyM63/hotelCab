import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/view/components/buttons/custom_round_border_shape.dart';
import '../../core/utils/dimensions.dart';
import 'image/custom_svg_picture.dart';


class CustomNoDataScreen extends StatelessWidget {

  final String title;
  final String subtitle;

  const CustomNoDataScreen({
    Key? key,
    this.title = MyStrings.noDataFound,
    this.subtitle = ''

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(MyImages.noData,width: size.height * .17,height:size.height * .17,),
            const SizedBox(height: 20),
            Text(title.tr, style: semiBoldExtraLarge,textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(subtitle.tr,style: semiBoldLarge),
            // SizedBox(height: context.height* .2,)
          ],
        ),
      ),
    );
  }
}
