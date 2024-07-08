

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/core/utils/my_color.dart';
import 'package:booking_box/data/model/filter_pram/filter_pram_response_model.dart';
import 'package:booking_box/data/repo/filter_pram/filter_pram_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class FilterController extends GetxController{

  FilterPramRepo filterPramRepo;
  FilterController({required this.filterPramRepo});

  RangeValues? currentRangeValues;

  double selectedMaxPrice = 879;
  double selectedMinPrice = 100;

  double previousSelectedMaxPrice = 879;
  double previousSelectedMinPrice = 100;

  String minPrice = "100"; //fixed
  String maxPrice = "879";

  String previousMinPrice = '100';
  String previousMaxPrice = '500';

  String curSymbol = "\$";


  int selectedHotelClass = -1;
  int selectedRating= -1;
  int selectedPropertyType = 0;

  bool isLoading = true;

  bool isLoaded = false;

  Future<void> loadData() async{
    isLoading = true;
    update();

    await loadFilterPramData();

    isLoading = false;
    isLoaded = true;
    update();

  }

  List<Amenities> amenitiesList = [];
  List<Facilities> facilitiesList = [];

  int maxStarRating = 2;

  Future<void> loadFilterPramData() async {

    ResponseModel model = await filterPramRepo.getData();
    if(model.statusCode == 200){

       FilterPramResponseModel filterPramResponseModel = FilterPramResponseModel.fromJson(jsonDecode(model.responseJson));

      if(filterPramResponseModel.data !=  null){

        minPrice = filterPramResponseModel.data!.minFare.toString();
        maxPrice = filterPramResponseModel.data!.maxFare.toString();

        previousMinPrice = filterPramResponseModel.data!.minFare.toString();
        previousMaxPrice = filterPramResponseModel.data!.maxFare.toString();

        maxStarRating = int.parse(filterPramResponseModel.data!.maxStarRating ?? '7');

        selectedMinPrice = double.parse(filterPramResponseModel.data!.minFare.toString());
        selectedMaxPrice = double.parse(filterPramResponseModel.data!.maxFare.toString());

        previousSelectedMinPrice = double.parse(filterPramResponseModel.data!.minFare.toString());
        previousSelectedMaxPrice = double.parse(filterPramResponseModel.data!.maxFare.toString());

        currentRangeValues = RangeValues(selectedMinPrice, (selectedMaxPrice - selectedMinPrice)/2); //todo: important

        if(filterPramResponseModel.data?.amenities != null && filterPramResponseModel.data!.amenities!.isNotEmpty){
          amenitiesList.addAll(filterPramResponseModel.data!.amenities!);
        }

        if(filterPramResponseModel.data?.facilities != null && filterPramResponseModel.data!.facilities!.isNotEmpty){
          facilitiesList.addAll(filterPramResponseModel.data!.facilities!);
        }
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  onResetClick(){
    minPrice = previousMinPrice;
    maxPrice = previousMaxPrice;
    selectedMinPrice = previousSelectedMinPrice;
    selectedMaxPrice = previousSelectedMaxPrice;
    currentRangeValues = RangeValues(previousSelectedMinPrice, (previousSelectedMaxPrice - previousSelectedMinPrice)/2);
    update();
  }

  bool facilities = false;
  bool amenities = false;

  toggleFacilities(){
    facilities = !facilities;
    update();
  }

  toggleAmenities(){
    amenities = !amenities;
    update();
  }

  void updateCurrentRangeValue(RangeValues rangeValues){
    currentRangeValues = rangeValues;
    selectedMaxPrice = double.tryParse(Converter.twoDecimalPlaceFixedWithoutRounding(rangeValues.end.toString()))??1000;
    selectedMinPrice = double.tryParse(Converter.twoDecimalPlaceFixedWithoutRounding(rangeValues.start.toString()))??1;
    update();
  }

  void setSelectedHotelClass(int index){
    selectedHotelClass = index;
    update();
  }

  void setSelectedFacilities(int index){
    facilitiesList[index].changeSelectedValue();
    update();
  }

  List<String>  selectedAmenitiesIdList = [];
  List<String>  selectedFacilitiesIdList = [];

  storeAmenitiesFacilitiesId(){

    selectedAmenitiesIdList.clear();
    selectedFacilitiesIdList.clear();

    for (var element in amenitiesList) {
      if(element.isSelect){
        selectedAmenitiesIdList.add(element.id.toString());
      }
    }

    for (var element in facilitiesList) {
      if(element.isSelect){
        selectedFacilitiesIdList.add(element.id.toString());
      }
    }
    update();
  }

  void setSelectedAmenities(int index){
    amenitiesList[index].changeSelectedValue();
    amenitiesList[index].isSelect;
    update();
  }

  void setPropertyType(int index){
    selectedPropertyType = index;
    update();
  }

  void resetFilter(){
    selectedHotelClass = -1;
    currentRangeValues = const RangeValues(100, 500);
    update();
  }
}