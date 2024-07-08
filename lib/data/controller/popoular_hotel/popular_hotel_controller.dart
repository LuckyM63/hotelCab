
import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:booking_box/data/model/popular_hotel/popular_hotel_response_model.dart';
import 'package:booking_box/data/repo/popular_hotel/popular_hote_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class PopularHotelController extends GetxController{

  PopularHotelRepo popularHotelRepo;
  PopularHotelController({required this.popularHotelRepo});


  bool isLoading = true;

  Future<void> loadData() async{
    isLoading = true;
    update();

    await loadPopularHotelData();

    isLoading = false;
    update();
  }

  List<Datum> popularHotelList = [];

  Future<void> loadPopularHotelData() async {

    ResponseModel model = await popularHotelRepo.getData(page.toString());
    if(model.statusCode == 200){

      PopularHotelResponseModel popularHotelResponseModel = PopularHotelResponseModel.fromJson(jsonDecode(model.responseJson));

      nextPageUrl = popularHotelResponseModel.data?.owners?.nextPageUrl??'';

      if(popularHotelResponseModel.data?.owners?.data != null && popularHotelResponseModel.data!.owners!.data!.isNotEmpty){
        popularHotelList.clear();
        popularHotelList.addAll(popularHotelResponseModel.data!.owners!.data!);
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  Future<void> fetchPopularHotelData() async {

    page = page + 1;

    ResponseModel model = await popularHotelRepo.getData(page.toString());
    if(model.statusCode == 200){

      PopularHotelResponseModel popularHotelResponseModel = PopularHotelResponseModel.fromJson(jsonDecode(model.responseJson));

      nextPageUrl = popularHotelResponseModel.data?.owners?.nextPageUrl??'';

      if(popularHotelResponseModel.data?.owners?.data != null && popularHotelResponseModel.data!.owners!.data!.isNotEmpty){
        popularHotelList.addAll(popularHotelResponseModel.data!.owners!.data!);
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