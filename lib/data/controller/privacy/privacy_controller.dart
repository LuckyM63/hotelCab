import 'dart:convert';
import 'package:get/get.dart';
import 'package:booking_box/data/model/about/privacy_response_model.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/repo/privacy_repo/privacy_repo.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';


class PrivacyController extends GetxController{

  PrivacyRepo repo;
  PrivacyController({required this.repo});

  int selectedIndex = 1;
  bool isLoading    = true;

  List<Policy>list = [];
  late var selectedHtml = '';


  void loadData()async{

    ResponseModel model=await repo.loadAboutData();
    if(model.statusCode==200){

      print("-----list--------${list}");

      PrivacyResponseModel responseModel = PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      if(responseModel.data.policies.isNotEmpty){
        list.clear();
        list.addAll(responseModel.data.policies);
        print("-----list--------${list}");
        changeIndex(0);
        updateLoading(false);
      }
    }
    else{
      CustomSnackBar.error(errorList: [model.message]);
      updateLoading(false);
    }
  }


  void changeIndex(int index){

    selectedIndex = index;
    selectedHtml  = list[index].dataValues.details;
    update();
  }

  updateLoading(bool status){
    isLoading=status;
    update();
  }
}