import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/app-bar/action_button_icon_widget.dart';
import 'package:booking_box/view/components/dialog/exit_dialog.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{

  final String title;
  final bool isShowBackBtn;
  final Color bgColor;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final dynamic actionIcon;
  final VoidCallback? actionPress;
  final bool isActionIconAlignEnd;
  final String? actionText;
  final bool isActionImage;
  final Color iconColor;
  final Color titleColor;
  final Color actionTextColor;
  final VoidCallback? actionTextPress;
  final bool enableCustomBackPress;
  final bool isShowElevation;
  final VoidCallback? onBackPress;
  final Color? statusBarColor;
  const CustomAppBar({Key? key,
    this.isProfileCompleted=false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor = MyColor.primaryColor,
    this.isShowBackBtn=true,
    required this.title,
    this.isShowActionBtn=false,
    this.actionText,
    this.actionIcon,
    this.actionPress,
    this.isActionIconAlignEnd = false,
    this.isActionImage = true,
    this.titleColor = MyColor.colorBlack,
    this.iconColor = MyColor.colorBlack,
    this.actionTextColor = MyColor.primaryColor,
    this.actionTextPress,
    this.enableCustomBackPress = false,
    this.onBackPress,
    this.isShowElevation = false,
    this.statusBarColor = MyColor.primaryColor

  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification =false;
  @override
  void initState() {
   Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn?PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 100),
      child: Container(
        decoration: widget.isShowElevation ? BoxDecoration(
          color: MyColor.colorWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ) : null,
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: widget.statusBarColor,
            statusBarBrightness:widget.statusBarColor == MyColor.primaryColor ?  Brightness.light : Brightness.dark,
            statusBarIconBrightness: widget.statusBarColor == MyColor.primaryColor ?  Brightness.light : Brightness.dark
        ),
          elevation: 0,
          titleSpacing: 0,
          scrolledUnderElevation: 0,
          leading:widget.isShowBackBtn? widget.enableCustomBackPress?IconButton(
              onPressed: widget.onBackPress,
              icon: Icon(Icons.arrow_back_ios,color: widget.iconColor, size: 20)
          )
            : IconButton(onPressed:  (){
            if(widget.fromAuth){
              Get.offAllNamed(RouteHelper.loginScreen);
            }else if(widget.isProfileCompleted){
              showExitDialog(Get.context!);
            }
            else{
              String previousRoute=Get.previousRoute;
              if(previousRoute=='/splash-screen'){
                Get.offAndToNamed(RouteHelper.bottomNavBar);
              }else{
                print("Execute this");
                Get.back();
              }
            }
          },icon: Icon(Icons.arrow_back_ios,color: widget.iconColor, size: 20)):const SizedBox.shrink(),
          backgroundColor: widget.bgColor,
          // title: Text(widget.title.tr,style: mediumExtraLarge.copyWith(color: widget.titleColor)),
          title: Text(widget.title.tr,style: appBarTextStyle.copyWith(color: widget.titleColor)),
          centerTitle: widget.isTitleCenter,
          actions: [
            widget.isShowActionBtn
                ? ActionButtonIconWidget(
              pressed: widget.actionPress!,
              isImage: widget.isActionImage,
              icon: widget.isActionImage?Icons.add:widget.actionIcon,  //just for demo purpose we put it here
              imageSrc: widget.isActionImage?widget.actionIcon:'',
            ) : widget.actionText != null? TextButton(
                onPressed: widget.actionTextPress,
                child: Text(widget.actionText??" ",style: mediumLarge.copyWith(color: widget.actionTextColor),)) : const SizedBox.shrink(),
            const SizedBox(width: 5)
          ],
        ),
      ),
    ):AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: MyColor.colorWhite,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
      ),
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: widget.bgColor,
      // title:Padding(
      //   padding: const EdgeInsets.only(left: 13),
      //   child: Text(widget.title.tr,style: mediumExtraLarge.copyWith(color: MyColor.titleColor)),
      // ),
      actions: [
        widget.isShowActionBtn?InkWell(onTap: (){Get.toNamed(RouteHelper.notificationScreen)?.then((value){
          setState(() {
            hasNotification=false;
          });
        });},child:const SizedBox.shrink()):const SizedBox()
       ],
      automaticallyImplyLeading: false,
    );
  }


}
