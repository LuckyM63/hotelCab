import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/route/route.dart';
import 'package:booking_box/core/utils/dimensions.dart';
import 'package:booking_box/core/utils/messages.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/style.dart';
import 'package:booking_box/data/controller/localization/localization_controller.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/model/language/language_model.dart';
import 'package:booking_box/data/repo/auth/general_setting_repo.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';

class LanguageDialogBody extends StatefulWidget {

  final List<MyLanguageModel>langList ;
  final bool fromSplashScreen;
  final String currentLangCode;

  const LanguageDialogBody({Key? key,required this.currentLangCode,required this.langList,this.fromSplashScreen = false}) : super(key: key);

  @override
  State<LanguageDialogBody> createState() => _LanguageDialogBodyState();
}

class _LanguageDialogBodyState extends State<LanguageDialogBody> {

  int pressIndex = -1;


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(MyStrings.selectALanguage, style: regularDefault.copyWith(color:MyColor.getTextColor(),fontSize: Dimensions.fontLarge),),),
          const SizedBox(height: Dimensions.space15,),
          Flexible(child: ListView.builder(
            shrinkWrap: true,
            itemCount:  widget.langList.length,
            itemBuilder: (context,index){
              return GestureDetector(

                onTap: ()async{
                  setState(() {
                    pressIndex = index;
                  });
                  String languageCode = widget.langList[index].languageCode;
                  final repo = Get.put(GeneralSettingRepo(apiClient: Get.find()));
                  final localizationController = Get.put(LocalizationController(sharedPreferences: Get.find()));
                  ResponseModel response = await repo.getLanguage(languageCode);
                  if(response.statusCode == 200){
                    try{
                      Map<String,Map<String,String>> language = {};
                      var resJson = jsonDecode(response.responseJson);
                      await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, response.responseJson);

                      var fileData = resJson['data']['file'].toString();

                      var value = (fileData == '[]' || fileData.isEmpty)
                          ? {}
                          : jsonDecode(fileData) as Map<String, dynamic>;

                      Map<String,String> json = {};

                      value.forEach((key, value) {
                        json[key] = value.toString();
                      });


                      language['${widget.langList[index].languageCode}_${'US'}'] = json;

                      Get.clearTranslations();
                      Get.addTranslations(Messages(languages: language).keys);

                      Locale local = Locale(widget.langList[index].languageCode,'US');
                      localizationController.setLanguage(local);
                      if(widget.fromSplashScreen){
                        Get.offAndToNamed(RouteHelper.loginScreen,);
                      }else{
                        Get.back();
                      }
                    }
                    catch(e){
                      print(e);
                      CustomSnackBar.error(errorList: [e.toString()]);
                    }
                  } else{
                    CustomSnackBar.error(errorList: [response.message]);
                  }
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                  decoration: BoxDecoration(color: widget.currentLangCode == widget.langList[index].languageCode ? MyColor.getPrimaryColor().withOpacity(.2) : MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  child: pressIndex == index
                      ? const Center(
                    child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: MyColor.primaryColor)),
                  )
                      : Text(
                    (widget.langList[index].languageName).tr,
                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                  ),
                ),
              );
            })
          ),
        ],
      ),
    );
  }
}
