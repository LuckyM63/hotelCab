import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:booking_box/data/model/popular_destination/popular_destination_response_model.dart';
import 'package:booking_box/data/repo/popular_destination/popular_destination_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class PopularCityController extends GetxController{

  PopularCityRepo popularCityRepo;
  PopularCityController({required this.popularCityRepo});


  bool isLoading = true;

  Future<void> loadData() async{
    isLoading = true;
    update();

    await loadPopularCityData();

    isLoading = false;
    update();

  }

  List<Datum> popularCityList = [];

  Future<void> loadPopularCityData() async {

    ResponseModel model = await popularCityRepo.getData(page.toString());
    if(model.statusCode == 200){

      PopularCityResponseModel popularHotelResponseModel = PopularCityResponseModel.fromJson(jsonDecode(model.responseJson));

      if(popularHotelResponseModel.data?.popularCities.data != null && popularHotelResponseModel.data!.popularCities.data!.isNotEmpty){
        popularCityList.clear();
        popularCityList.addAll(popularHotelResponseModel.data!.popularCities.data!);
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }


  String? nextPageUrl='';
  int page = 1;
  bool hasNext(){
    if(nextPageUrl!=null && nextPageUrl!.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<void> fetchNewPopularCityData() async {

    page = page + 1;

    ResponseModel model = await popularCityRepo.getData(page.toString());
    if(model.statusCode == 200){

      PopularCityResponseModel popularHotelResponseModel = PopularCityResponseModel.fromJson(jsonDecode(model.responseJson));

      if(popularHotelResponseModel.data?.popularCities.data != null && popularHotelResponseModel.data!.popularCities.data!.isNotEmpty){
        popularCityList.addAll(popularHotelResponseModel.data!.popularCities.data!);
      }

      update();

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

}