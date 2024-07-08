import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/repo/hotel_details/hotel_details_repo.dart';

import '../../../core/helper/date_converter.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/hotel_details/hotel_details_response_model.dart';
import '../search_result/search_result_controller.dart';

class HotelDetailsScreenController extends GetxController{

  HotelDetailsRepo hotelDetailsRepo;
  HotelDetailsScreenController({required this.hotelDetailsRepo});

  SearchResultController searchResultController = Get.find();
  HomeController homeController = Get.find();

  final PageController pageController = PageController();
  int currentPage = 0;

  bool moreOptionHotelDesc = false;

  bool isLoading = false;

  bool isClickModifySearch = false;

  String hotelId = '-1';

  bool modifiedFromDetails = false;

  String roomTypeImagePath = '';

  Future<void> loadData(String hotelId,{bool modifiedFromDetails = false}) async{

    this.hotelId = hotelId;
    this.modifiedFromDetails = modifiedFromDetails;

    isLoading = true;
    update();

    await loadHotelDetailsData();

    isLoading = false;
    update();

  }

  HotelSetting? hotelSetting;
  Hotel? hotel;
  double taxPercentage = 0.0;

  List<RoomType> roomTypesList = [];

  List<Ity> roomFacilitiesList = [];

  List<Ity> hotelFacilitiesList = [];
  List<Ity> hotelAmenitiesList = [];
  List<Ity> hotelAmenitiesAndFacilitiesList = [];

  List<Complement> hotelComplimentList = [];

  String totalFacilities = '0';

  int totalAvailableRoom = 0;
  int totalAdultCapacityOnHotel = 0;
  int totalChildCapacityOnHotel = 0;
  double minFare = 0;
  double minFareTexAmount = 0;

  bool isRoomAvailable = false;

  Future<void> loadHotelDetailsData() async {

    ResponseModel model = await hotelDetailsRepo.getData(
      hotelId,
      DateConverter.formattedDate(homeController.checkInDate),
      DateConverter.formattedDate(homeController.checkOutDate),
      homeController.roomList,
    );
    if(model.statusCode == 200){
      HotelDetailsResponseModel hotelDetailsResponseModel = HotelDetailsResponseModel.fromJson(jsonDecode(model.responseJson));

      if(hotelDetailsResponseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()){

        roomTypesList.clear();
        roomFacilitiesList.clear();
        hotelFacilitiesList.clear();
        hotelAmenitiesList.clear();
        hotelAmenitiesAndFacilitiesList.clear();
        hotelComplimentList.clear();
        roomFacilitiesList.clear();

        if(hotelDetailsResponseModel.data != null){
          roomTypeImagePath = hotelDetailsResponseModel.data!.roomTypeImageUrl!;
          totalFacilities = hotelDetailsResponseModel.data!.totalFacilities!;
          hotel = hotelDetailsResponseModel.data!.hotel;
          minFare = double.tryParse(hotel?.minFare ?? '0') ?? 0;


          if(hotelDetailsResponseModel.data!.hotel?.hotelSetting != null){
            hotelSetting = hotelDetailsResponseModel.data!.hotel!.hotelSetting;
            taxPercentage = double.tryParse(hotelDetailsResponseModel.data!.hotel!.hotelSetting!.taxPercentage!) ?? 0.0;
          }
        }

        if(hotelDetailsResponseModel.data?.hotel?.roomTypes != null && hotelDetailsResponseModel.data!.hotel!.roomTypes.isNotEmpty){

          roomTypesList.addAll(hotelDetailsResponseModel.data!.hotel!.roomTypes);



          if (roomTypesList.isNotEmpty) {

            totalAvailableRoom = 0;
            totalAdultCapacityOnHotel = 0;
            totalChildCapacityOnHotel = 0;

            for (int i = 0; i < roomTypesList.length; i++) {

              int? availableRooms = int.tryParse(roomTypesList[i].availableRooms ?? '');

              if (availableRooms != null) {
                totalAvailableRoom += availableRooms;
                totalAdultCapacityOnHotel += ((int.tryParse(roomTypesList[i].totalAdult ?? '0') ?? 0) * availableRooms);
                totalChildCapacityOnHotel += ((int.tryParse(roomTypesList[i].totalChild ?? '0') ?? 0) * availableRooms);
              }
            }

            if (totalAvailableRoom  > 0 && totalAdultCapacityOnHotel >= homeController.numberOfAdults
                && totalChildCapacityOnHotel >= homeController.numberOfChildren) {

              isRoomAvailable = true;
            }
            else {
              isRoomAvailable = false;
            }
          }


          if(roomTypesList.isNotEmpty){
            roomFacilitiesList.addAll( roomTypesList[0].facilities!);
          }
        }

        if(hotelDetailsResponseModel.data?.facilities != null && hotelDetailsResponseModel.data!.facilities!.isNotEmpty){
          hotelFacilitiesList.addAll(hotelDetailsResponseModel.data!.facilities!);
          hotelAmenitiesAndFacilitiesList.addAll(hotelDetailsResponseModel.data!.facilities!);
        }

        if(hotelDetailsResponseModel.data?.amenities != null && hotelDetailsResponseModel.data!.amenities!.isNotEmpty){
          hotelAmenitiesList.addAll(hotelDetailsResponseModel.data!.amenities!);
          hotelAmenitiesAndFacilitiesList.addAll(hotelDetailsResponseModel.data!.amenities!);
        }

      }else{
        CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong.tr]);
      }

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }


  setMoreOptionHotelDesc(){
    moreOptionHotelDesc = !moreOptionHotelDesc;
    update();
  }

  int hotelRoomCadLength = 5;

  void setCurrentPage(int value){
    currentPage = value;
    update();
  }

  bool seeMore = false;

  void toggleSeeMore(){
    seeMore = !seeMore;
    update();
  }

}