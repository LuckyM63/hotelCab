import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/data/controller/select_room/room_select_controller.dart';
import 'package:booking_box/data/model/hotel_details/hotel_details_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/url_container.dart';

class RoomDetailsController extends GetxController{

  final PageController pageController = PageController();
  HotelDetailsScreenController hotelDetailsScreenController = Get.find();

  final RoomSelectController roomSelectController = Get.find();

  HotelSetting? hotelSetting;

  List<RoomType> roomList = [];
  List<String> imageUrls = [];


  bool isLoading = true;

  loadRoomDetailsData(int roomIndex){

    isLoading = true;
    update();

    if(hotelDetailsScreenController.hotelSetting != null){
      hotelSetting = hotelDetailsScreenController.hotelSetting;
    }

    if(hotelDetailsScreenController.roomTypesList.isNotEmpty){
      roomList = hotelDetailsScreenController.roomTypesList;

      if(roomList[roomIndex].images != null && roomList[roomIndex].images!.isNotEmpty){
        for(int i = 0 ; i < roomList[roomIndex].images!.length; i++){
          imageUrls.add('${UrlContainer.domainUrl}/${hotelDetailsScreenController.roomTypeImagePath}/${roomList[roomIndex].images?[i].image}');
        }
      }
    }

    isLoading = false;
    update();
  }

  int currentPage = 0;

  void setCurrentPage(int value){
    currentPage = value;
    update();
  }


}