
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:booking_box/view/screens/bottom_nav_section/my_booking/booking_history/booking_history_screen.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/url_container.dart';
import '../../../components/snack_bar/show_custom_snackbar.dart';


class MyWebViewWidget extends StatefulWidget {
  const MyWebViewWidget({Key? key,required this.url}) : super(key: key);

  final String url;

  @override
  State<MyWebViewWidget> createState() => _MyWebViewWidgetState();
}

class _MyWebViewWidgetState extends State<MyWebViewWidget> {

  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  String url = '';
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  bool isKycPending = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
       AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    return SafeArea(
      child: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: Uri.parse(url)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            initialOptions: options,
            onLoadStart: (controller, url) {
              if(url.toString()=='${UrlContainer.domainUrl}/register-your-hotel'){
                Get.off(const BookingHistoryScreen(isShowAppBar: true),);
                CustomSnackBar.success(successList: [MyStrings.paymentSuccess.tr]);
              } else if(url.toString() == '${UrlContainer.domainUrl}/'){
                Get.back();
                CustomSnackBar.error(errorList: [MyStrings.paymentFail.tr]);
              }
              setState(() {
                this.url = url.toString();
              });
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
      
              if (![ "http", "https", "file", "chrome",
                "data", "javascript", "about"].contains(uri.scheme)) {
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(
                    Uri.parse(url),
                  );
                  return NavigationActionPolicy.CANCEL;
                }
              }
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              setState(() {
                isLoading = false;
                this.url = url.toString();
              });
            },
            onLoadError: (controller, url, code, message) {},
            onProgressChanged: (controller, progress) {},
            onUpdateVisitedHistory: (controller, url, androidIsReload) {
              setState(() {
                this.url = url.toString();
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
            },
          )
        ],
      ),
    );
  }
}
