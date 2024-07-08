import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/messages.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/localization/localization_controller.dart';
import 'package:booking_box/push_notification_service.dart';
import 'core/di_service/di_services.dart' as di_service;
import 'core/utils/my_color.dart';
import 'firebase_options.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey, true);
}

Future<void> main() async{

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: MyColor.colorWhite, // status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await PushNotificationService().setupInteractedMessage();

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(languages: languages));

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatefulWidget {

  final Map<String, Map<String, String>> languages;
  const MyApp({Key? key,required this.languages}):super(key:key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(
      builder: (localizeController) => GetMaterialApp(
        title: MyStrings.appName,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: RouteHelper.splashScreen,
        navigatorKey: Get.key,
        theme: ThemeData(useMaterial3: false),
        getPages: RouteHelper().routes,
        locale: localizeController.locale,
        translations: Messages(languages: widget.languages),
        fallbackLocale: Locale(localizeController.locale.languageCode,
        localizeController.locale.countryCode),
      ),
    );
  }
}
