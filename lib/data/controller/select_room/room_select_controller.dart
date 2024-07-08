
import 'package:get/get.dart';
import 'package:booking_box/core/helper/string_format_helper.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/controller/hotel_details/hotel_details_screen_controller.dart';
import 'package:booking_box/data/model/hotel_details/hotel_details_response_model.dart';


class RoomSelectController extends GetxController{


  HotelDetailsScreenController hotelDetailsScreenController = Get.find();

  HomeController homeController = Get.find();

  List<RoomType> roomList = [];

  int totalAssignedAdultOnRoom = 0;
  int totalAssignedChildrenOnRoom = 0;

  loadRoomList(){
    roomList.clear();
    if(hotelDetailsScreenController.roomTypesList.isNotEmpty){
      roomList = hotelDetailsScreenController.roomTypesList;
      update();
    }
  }

  Map<String, int> counts = {};
  String getBedInfo(int index){

    String bedInfoText = '';
    if(roomList[index].beds != null && roomList[index].beds!.isNotEmpty){
      bedCount(roomList[index].beds!);
      counts.forEach((roomType, count) {
        bedInfoText = '$bedInfoText  $count $roomType';
      });
    }
    roomList[index].setBedInfo(bedInfoText);
    counts.clear();
    return bedInfoText;
  }

  bedCount(List<String> bedList) {
      for (String bedType in bedList) {
        if (counts.containsKey(bedType)) {
          counts[bedType] = (counts[bedType] ?? 0) + 1;
        } else {
          counts[bedType] = 1;
        }
      }
    }


    String getDiscountedRoomFare(String discountedRoomFare){
      double roomPrice =  double.parse(discountedRoomFare);
      double totalRoomFare = roomPrice * homeController.numberOfNights().toDouble();
      return Converter.formatNumber(totalRoomFare.toString(),precision: 2);
    }

  String getActualRoomFare(int index){
    double roomPrice =  double.parse(roomList[index].fare.toString());
    double totalRoomFare = roomPrice * homeController.numberOfNights().toDouble();
    return Converter.formatNumber(totalRoomFare.toString(),precision: 2);
  }

    List<RoomType> selectedRoomList = [];

    addSelectedRoomList(RoomType roomType){
      selectedRoomList.add(roomType);
      roomType.increaseTotalRoomCount();
      update();
    }

    clearTotalRoomCount(){
      for(var i in selectedRoomList){
        i.totalRoomCount = 0;
      }
      update();
    }

    removeSelectedRoomListItem(RoomType roomType,int index){
      // selectedRoomList.removeWhere((element) => element.id.toString() == roomType.id.toString());
      selectedRoomList.removeAt(index);
      roomType.decreaseTotalRoomCount();
      update();
    }

    double totalPayableAmount = 0;
    double taxAmount = 0.0;
    void setTotalPayableAmount(double amount){
      totalPayableAmount += (amount * homeController.numberOfNights().toDouble());
      taxAmount += ((amount * hotelDetailsScreenController.taxPercentage) / 100) * homeController.numberOfNights().toDouble();
      update();
    }

    void deductFromPayableAmount(double amount){
      totalPayableAmount -= (amount * homeController.numberOfNights().toDouble());
      taxAmount -= ((amount * hotelDetailsScreenController.taxPercentage) / 100) * homeController.numberOfNights().toDouble();
      update();
    }

    void assignGuestOnRoom(RoomType roomType){
      totalAssignedAdultOnRoom += int.parse(roomType.totalAdult!);
      totalAssignedChildrenOnRoom += int.parse(roomType.totalChild!);
      update();
    }

    void deductGuestFromRoom(RoomType roomType){
      totalAssignedAdultOnRoom -= int.parse(roomType.totalAdult!);
      totalAssignedChildrenOnRoom -= int.parse(roomType.totalChild!);
      update();
    }

  }