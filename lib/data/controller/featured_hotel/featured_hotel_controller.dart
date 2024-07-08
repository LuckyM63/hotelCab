
import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:booking_box/data/model/featured_hotel/featured_hotel_response_model.dart';
import 'package:booking_box/data/repo/featured_hotel/featured_hotel_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class FeaturedHotelController extends GetxController{

  FeaturedHotelRepo featuredHotelRepo;
  FeaturedHotelController({required this.featuredHotelRepo});


  bool isLoading = true;

  Future<void> loadData() async{
    isLoading = true;
    update();

    await loadFeaturedHotelData();

    isLoading = false;
    update();

  }

  List<Datum> featuredHotelList = [];

  Future<void> loadFeaturedHotelData() async {

    ResponseModel model = await featuredHotelRepo.getData(page.toString());
    if(model.statusCode == 200){

      FeaturedHotelResponseModel featureHotelResponseModel = FeaturedHotelResponseModel.fromJson(jsonDecode(model.responseJson));

      if(featureHotelResponseModel.data?.featuredHotels?.data != null && featureHotelResponseModel.data!.featuredHotels!.data!.isNotEmpty){
        nextPageUrl = featureHotelResponseModel.data?.featuredHotels?.nextPageUrl??'';
        featuredHotelList.clear();
        featuredHotelList.addAll(featureHotelResponseModel.data!.featuredHotels!.data!);
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  Future<void> fetchFeaturedHotelData() async {

    page = page + 1;

    ResponseModel model = await featuredHotelRepo.getData(page.toString());
    if(model.statusCode == 200){

      FeaturedHotelResponseModel featureHotelResponseModel = FeaturedHotelResponseModel.fromJson(jsonDecode(model.responseJson));

      nextPageUrl = featureHotelResponseModel.data?.featuredHotels?.nextPageUrl??'';

      if(featureHotelResponseModel.data?.featuredHotels?.data != null && featureHotelResponseModel.data!.featuredHotels!.data!.isNotEmpty){

        featuredHotelList.addAll(featureHotelResponseModel.data!.featuredHotels!.data!);

      }

      update();

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

}