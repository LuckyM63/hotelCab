import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/messages.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/language/language_model.dart';
import '../../model/language/main_language_response_model.dart';
import '../../repo/auth/general_setting_repo.dart';
import '../localization/localization_controller.dart';

class MyLanguageController extends GetxController {
  GeneralSettingRepo repo;
  LocalizationController localizationController;
  MyLanguageController({required this.repo, required this.localizationController});

  bool isLoading = true;
  List<MyLanguageModel> langList = [];

  void loadLanguage() {
    langList.clear();
    isLoading = true;

    SharedPreferences pref = repo.apiClient.sharedPreferences;
    String languageString = pref.getString(SharedPreferenceHelper.languageListKey) ?? '';

    var language = jsonDecode(languageString);
    MainLanguageResponseModel model = MainLanguageResponseModel.fromJson(language);

    if (model.data?.languages != null && model.data!.languages!.isNotEmpty) {
      for (var listItem in model.data!.languages!) {
        MyLanguageModel model = MyLanguageModel(languageCode: listItem.code ?? '', countryCode: listItem.name ?? '', languageName: listItem.name ?? '');
        langList.add(model);
      }
    }

    String languageCode = pref.getString(SharedPreferenceHelper.languageCode) ?? 'en';

    if (kDebugMode) {
      print('current lang code: $languageCode');
    }

    if (langList.isNotEmpty) {
      int index = langList.indexWhere((element) => element.languageCode.toLowerCase() == languageCode.toLowerCase());

      changeSelectedIndex(index);
    }

    isLoading = false;
    update();
  }

  String selectedLangCode = 'en';

  bool isChangeLangLoading = false;
  void changeLanguage(int index, {bool isComeFromSplashScreen = false}) async {
    isChangeLangLoading = true;
    update();

    MyLanguageModel selectedLangModel = langList[index];
    String languageCode = selectedLangModel.languageCode;
    try {
      ResponseModel response = await repo.getLanguage(languageCode);

      if (response.statusCode == 200) {
        try {
          var resJson = jsonDecode(response.responseJson);
          await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, response.responseJson);

          var value = resJson['data']['file'].toString() == '[]' ? {} : jsonDecode(resJson['data']['file']) as Map<String, dynamic>;

          Map<String, String> json = {};

          value.forEach((key, value) {
            json[key] = value.toString();
          });

          Map<String, Map<String, String>> language = {};
          language['${selectedLangModel.languageCode}_${'US'}'] = json;

          Get.clearTranslations();
          Get.addTranslations(Messages(languages: language).keys);

          Locale local = Locale(selectedLangModel.languageCode, 'US');
          localizationController.setLanguage(local);

          if (isComeFromSplashScreen) {
            Get.offAndToNamed(
              RouteHelper.loginScreen,
            );
          } else {
            Get.back();
          }
        } catch (e) {
          CustomSnackBar.error(errorList: [e.toString()]);
        }
      } else {
        CustomSnackBar.error(errorList: [response.message]);
      }
    } catch (e) {
      print(e.toString());
    }

    isChangeLangLoading = false;
    update();
  }

  int selectedIndex = 0;
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }
}
