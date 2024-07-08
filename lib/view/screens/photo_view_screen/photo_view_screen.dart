import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../core/utils/my_strings.dart';
import '../../components/app-bar/custom_appbar.dart';


class PhotoViewScreen extends StatefulWidget {

  final List<String> imageUrl;
  final int initialIndex;

  const PhotoViewScreen({super.key,required this.imageUrl,required this.initialIndex});

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  int currentIndex = 0; // Initialize the current index to 0

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        statusBarColor: MyColor.colorWhite,
        title: "${MyStrings.images.tr} (${widget.imageUrl.length})",
        bgColor: MyColor.colorWhite,
        titleColor: MyColor.colorBlack,
      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.imageUrl[index]),
            errorBuilder: (context, url, error) => Image.asset(MyImages.defaultImage,height: 100,width: 100,),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            // heroAttributes: PhotoViewHeroAttributes(tag: widget.initialIndex),
          );
        },
        itemCount: widget.imageUrl.length,
        backgroundDecoration: const BoxDecoration(
          color: MyColor.colorBlack,
        ),
        pageController: PageController(initialPage: widget.initialIndex),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index; // Update the currentIndex when the page changes
          });
        },
      ),
    );
  }
}
