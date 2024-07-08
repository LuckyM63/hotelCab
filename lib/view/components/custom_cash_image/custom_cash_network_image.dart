import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:booking_box/core/utils/my_color.dart';


import '../custom_loader/image_loader.dart';

class CustomCashNetworkImage extends StatelessWidget {

  final double? imageHeight;
  final double? imageWidth;
  final String imageUrl;
  final Widget? imageBuilder;
  final double borderRadius;
  final String? loaderImage;

  const CustomCashNetworkImage({
    super.key,
    this.imageHeight,
    this.imageWidth,
    required this.imageUrl,
    this.borderRadius = 0,
    this.imageBuilder,
    this.loaderImage
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: imageHeight,
        width: imageWidth,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) {
          if(loaderImage !=  null){
            return Image.asset(loaderImage!);
          }else{
            return const CustomImageLoader();
          }
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}


