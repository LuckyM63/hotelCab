import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/view/components/warning_aleart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WillPopWidget extends StatelessWidget {

  final Widget child;
  final String nextRoute;
  final VoidCallback? actionPerform;
  final bool isNeedToGoBottomNav;

  const WillPopWidget({Key? key,
    required this.child,
    this.nextRoute = '',
    this.actionPerform,
    this.isNeedToGoBottomNav = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(isNeedToGoBottomNav){
          Get.offAllNamed(RouteHelper.bottomNavBar);
          return Future.value(false);
        }
        else if(nextRoute.isEmpty){
          const WarningAlertDialog().warningAlertDialog(context, () { SystemNavigator.pop();});
          return Future.value(false);
        } else{
          Get.offAndToNamed(nextRoute);
          return Future.value(false);
        }
      },
      child: child
    );
  }
}
