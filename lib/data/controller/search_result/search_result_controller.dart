import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:booking_box/core/helper/date_converter.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/filter/filter_controller.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/model/search_result/search_result_response_model.dart';
import 'package:booking_box/data/repo/search_result/search_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class SearchResultController extends GetxController{

  SearchRepo searchRepo;
  SearchResultController({required this.searchRepo});

  HomeController homeController = Get.find();
  FilterController filterController = Get.find();

  PageController? pageController = PageController();

  bool isClickModifySearch = false;

  int currentRemark = 1;

  void changeCurrentRemark(int index){
    currentRemark = index;
    update();
  }

  bool isLoading = true;


  int pageViewCurrentIndex = 0;

  setPageViewCurrentIndex(int index){
    pageViewCurrentIndex = index;
    update();
  }


  Future<void> loadData({bool isFilter = false, bool isFromDestination = false}) async{

    isLoading = true;
    update();
    if(isFilter){
      await loadFilterSearchData();
    }
    else{
      await loadSearchResultData(isFromDestination: isFromDestination);
    }
    isLoading = false;
    update();

  }

  List<SearchResultData> searchResultList = [];
  String logoPath = '';


  Future<void> loadSearchResultData({bool isFromDestination = false}) async {

    searchResultList.clear();

    ResponseModel model = await searchRepo.getSearchResult(
        homeController.roomList,
        homeController.cityId,
        DateConverter.formattedDate(homeController.checkInDate),
        DateConverter.formattedDate(homeController.checkOutDate),
        page.toString(),
        isFromDestination: isFromDestination
    );

    if(model.statusCode == 200){

      SearchResultResponseModel searchResultModel = SearchResultResponseModel.fromJson(jsonDecode(model.responseJson));

      if(searchResultModel.status?.toLowerCase() == MyStrings.success.toLowerCase()){

        if(searchResultModel.mainData != null){
          logoPath = searchResultModel.mainData!.logoPath!;
        }

        if(searchResultModel.mainData?.hotels != null){
          nextPageUrl = searchResultModel.mainData!.hotels!.nextPageUrl??'';
        }

        if(searchResultModel.mainData?.hotels?.searchResultData !=  null && searchResultModel.mainData!.hotels!.searchResultData!.isNotEmpty){
          searchResultList.clear();
          searchResultList.addAll(searchResultModel.mainData!.hotels!.searchResultData!);
        }
      }
      else{
        CustomSnackBar.error(errorList: searchResultModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
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

  Future<void> fetchNewResultData({bool isFromDestination = false}) async {

    page = page + 1;

    ResponseModel model = await searchRepo.getSearchResult(
      homeController.roomList,
      homeController.cityId,
      DateConverter.formattedDate(homeController.checkInDate),
      DateConverter.formattedDate(homeController.checkOutDate),
      page.toString(),
      isFromDestination: isFromDestination
    );

    if(model.statusCode == 200){

      SearchResultResponseModel searchResultModel = SearchResultResponseModel.fromJson(jsonDecode(model.responseJson));

      if(searchResultModel.status?.toLowerCase() == MyStrings.success.toLowerCase()){

        if(searchResultModel.mainData != null){
          logoPath = searchResultModel.mainData!.logoPath!;
        }

        if(searchResultModel.mainData?.hotels != null){
          nextPageUrl = searchResultModel.mainData!.hotels!.nextPageUrl??'';
        }

        if(searchResultModel.mainData?.hotels?.searchResultData !=  null && searchResultModel.mainData!.hotels!.searchResultData!.isNotEmpty){
          // searchResultList.clear();
          searchResultList.addAll(searchResultModel.mainData!.hotels!.searchResultData!);
        }

        update();

      }
      else{
        CustomSnackBar.error(errorList: searchResultModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }


  Future<void> loadFilterSearchData() async {

    searchResultList.clear();

    ResponseModel model = await searchRepo.getFilterSearchData(
      homeController.roomList,
      homeController.cityId,
      DateConverter.formattedDate(homeController.checkInDate),
      DateConverter.formattedDate(homeController.checkOutDate),
      Converter.formatNumber(filterController.selectedMinPrice.toString(),precision: 0),
      Converter.formatNumber(filterController.selectedMaxPrice.toString(),precision: 0),
      filterController.selectedAmenitiesIdList,
      filterController.selectedFacilitiesIdList,
      filterController.selectedHotelClass == -1 ? '' :
      (filterController.selectedHotelClass + 1).toString()
    );

    if(model.statusCode == 200){

      SearchResultResponseModel searchResultModel = SearchResultResponseModel.fromJson(jsonDecode(model.responseJson));

      if(searchResultModel.status?.toLowerCase() == MyStrings.success.toLowerCase()){
        if(searchResultModel.mainData?.hotels?.searchResultData !=  null && searchResultModel.mainData!.hotels!.searchResultData!.isNotEmpty){
          searchResultList.clear();
          searchResultList.addAll(searchResultModel.mainData!.hotels!.searchResultData!);
        }
      }
      else{
        CustomSnackBar.error(errorList: searchResultModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }


  String selectedHotelId = '0';
  String ownerId = '-1';

  setHotelAndOwnerId(SearchResultData selectedHotel){
    selectedHotelId  = selectedHotel.id.toString();
    ownerId = selectedHotel.ownerId.toString();
    update();
  }

  String formatDateInDayMonth(String date){

    if(date == MyStrings.checkOutDate){
      return date;
    }else{
      DateTime parsedDate = DateFormat('MMM d, y').parse(date);
      String formattedDate = DateFormat('dd MMM').format(parsedDate);
      return formattedDate;
    }
  }

}