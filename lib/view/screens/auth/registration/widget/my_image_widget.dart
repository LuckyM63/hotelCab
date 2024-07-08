import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:booking_box/core/utils/my_images.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';

class MyImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double radius;
  final BoxFit boxFit;
  const MyImageWidget({
    super.key,
    required this.imageUrl,
    this.height = 80,
    this.width = 100,
    this.radius = 5,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(image: imageProvider, fit: boxFit),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Center(
              child: SpinKitFadingCube(
                color: MyColor.primaryColor.withOpacity(0.3),
                size: Dimensions.space20,
              ),
            )),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Center(
              child: Icon(
                Icons.image,
                color: MyColor.colorGrey.withOpacity(0.5),
              ),
            )),
      ),
    );
  }
}
