import 'dart:async';
import 'dart:convert';

import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/model/car_details/car_details_response_model.dart'
    as details;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/helper/date_converter.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/car_details/car_details_repo.dart';
import '../car/car_controller.dart';
import '../search_result/search_result_controller.dart';

class CarDetailsScreenController extends GetxController {
  CarDetailsRepo carDetailsRepo;
  CarDetailsScreenController({required this.carDetailsRepo});

  SearchResultController searchResultController = Get.find();
  CarController carController = Get.find();

  final PageController pageController = PageController();
  int currentPage = 0;

  bool moreOptionHotelDesc = false;

  bool isLoading = false;

  bool isClickModifySearch = false;

  String hotelId = '-1';

  bool modifiedFromDetails = false;

  String roomTypeImagePath = '';

  Future<void> loadData(String hotelId,
      {bool modifiedFromDetails = false}) async {
    this.hotelId = hotelId;
    this.modifiedFromDetails = modifiedFromDetails;

    isLoading = true;
    update();

    await loadCarDetailsData();

    isLoading = false;
    update();
  }

  details.CarSetting? carSetting;
  details.Car? car;
  double taxPercentage = 0.0;

  List<details.RoomType> roomTypesList = [];

  List<details.Ity> roomFacilitiesList = [];

  List<details.Ity> hotelFacilitiesList = [];
  List<details.Ity> hotelAmenitiesList = [];
  List<details.Ity> hotelAmenitiesAndFacilitiesList = [];

  List<details.Complement> hotelComplimentList = [];

  String totalFacilities = '0';

  int totalAvailableRoom = 0;
  int totalAdultCapacityOnHotel = 0;
  int totalChildCapacityOnHotel = 0;
  double minFare = 0;
  double minFareTexAmount = 0;

  bool isRoomAvailable = false;

  Future<void> loadCarDetailsData() async {
    ResponseModel model = await carDetailsRepo.getData(
      hotelId,
      DateConverter.formattedDate(carController.checkInDate),
      DateConverter.formattedDate(carController.checkOutDate),
      carController.roomList,
    );
    if (model.statusCode == 200) {
      details.CarDetailsResponseModel carDetailsResponseModel =
          details.CarDetailsResponseModel.fromJson(
              jsonDecode(model.responseJson));

      if (carDetailsResponseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        roomTypesList.clear();
        roomFacilitiesList.clear();
        hotelFacilitiesList.clear();
        hotelAmenitiesList.clear();
        hotelAmenitiesAndFacilitiesList.clear();
        hotelComplimentList.clear();
        roomFacilitiesList.clear();

        if (carDetailsResponseModel.data != null) {
          roomTypeImagePath = carDetailsResponseModel.data!.roomTypeImageUrl!;
          totalFacilities = carDetailsResponseModel.data!.totalFacilities!;
          car = carDetailsResponseModel.data!.car;
          minFare = double.tryParse(car?.minFare ?? '0') ?? 0;

          if (carDetailsResponseModel.data!.car?.carSetting != null) {
            carSetting = carDetailsResponseModel.data!.car!.carSetting;
            taxPercentage = double.tryParse(carDetailsResponseModel
                    .data!.car!.carSetting!.taxPercentage!) ??
                0.0;
          }
        }

        if (carDetailsResponseModel.data?.car?.roomTypes != null &&
            carDetailsResponseModel.data!.car!.roomTypes.isNotEmpty) {
          roomTypesList.addAll(carDetailsResponseModel.data!.car!.roomTypes);

          if (roomTypesList.isNotEmpty) {
            totalAvailableRoom = 0;
            totalAdultCapacityOnHotel = 0;
            totalChildCapacityOnHotel = 0;

            for (int i = 0; i < roomTypesList.length; i++) {
              int? availableRooms =
                  int.tryParse(roomTypesList[i].availableRooms ?? '');

              if (availableRooms != null) {
                totalAvailableRoom += availableRooms;
                totalAdultCapacityOnHotel +=
                    ((int.tryParse(roomTypesList[i].totalAdult ?? '0') ?? 0) *
                        availableRooms);
                totalChildCapacityOnHotel +=
                    ((int.tryParse(roomTypesList[i].totalChild ?? '0') ?? 0) *
                        availableRooms);
              }
            }

            if (totalAvailableRoom > 0 &&
                totalAdultCapacityOnHotel >= carController.numberOfAdults &&
                totalChildCapacityOnHotel >= carController.numberOfChildren) {
              isRoomAvailable = true;
            } else {
              isRoomAvailable = false;
            }
          }

          if (roomTypesList.isNotEmpty) {
            roomFacilitiesList.addAll(roomTypesList[0].facilities!);
          }
        }

        if (carDetailsResponseModel.data?.facilities != null &&
            carDetailsResponseModel.data!.facilities!.isNotEmpty) {
          hotelFacilitiesList.addAll(carDetailsResponseModel.data!.facilities!);
          hotelAmenitiesAndFacilitiesList
              .addAll(carDetailsResponseModel.data!.facilities!);
        }

        if (carDetailsResponseModel.data?.amenities != null &&
            carDetailsResponseModel.data!.amenities!.isNotEmpty) {
          hotelAmenitiesList.addAll(carDetailsResponseModel.data!.amenities!);
          hotelAmenitiesAndFacilitiesList
              .addAll(carDetailsResponseModel.data!.amenities!);
        }
      } else {
        CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong.tr]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  setMoreOptionHotelDesc() {
    moreOptionHotelDesc = !moreOptionHotelDesc;
    update();
  }

  int hotelRoomCadLength = 5;

  void setCurrentPage(int value) {
    currentPage = value;
    update();
  }

  bool seeMore = false;

  void toggleSeeMore() {
    seeMore = !seeMore;
    update();
  }
}
