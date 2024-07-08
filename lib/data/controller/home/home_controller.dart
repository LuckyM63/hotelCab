import 'dart:async';
import 'dart:convert';

import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/data/model/general_setting/general_setting_response_model.dart';
import 'package:booking_box/data/model/home/home_model.dart';
import 'package:booking_box/data/model/search/search_destination_response_model.dart';
import 'package:booking_box/data/repo/home/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/room_model/RoomModel.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  PageController? pageController = PageController();

  int numberOfGuests = 1; //all place
  int numberOfRooms = 1; //all place
  int numberOfAdults = 1;
  int numberOfChildren = 0;

  String previousCheckInData = '';
  String previousCheckOutData = '';
  int previousNumberOfRooms = 1;
  int previousNumberOfGuest = 1;
  String previousSearchPlaceName = '';

  String hotelRating = '5';

  String searchedPlaceName = "Place Name";
  String searchedPlaceCountry = "Country";

  String email = "";
  bool isLoading = true;
  String username = "";
  String siteName = "";
  String imagePath = "";
  String defaultCurrency = "";

  bool isClickDone = false;

  GeneralSettingResponseModel generalSettingResponseModel =
      GeneralSettingResponseModel();

  Future<void> loadData({bool isPullRefresh = false}) async {
    getDaysName();
    initialCheckInDate();
    initialCheckOutDate();

    if (searchDataList.isEmpty || isPullRefresh) {
      isLoading = true;
      update();
    }

    await loadHomeData();
    await loadSearchDestinationData();

    isLoading = false;
    update();
  }

  List<Ad> adsList = [];
  List<Owner> popularHotelList = [];
  List<Owner> featuredHotelList = [];
  List<PopularCity> popularCityList = [];
  int totalPopularHotel = -1;
  int totalPopularCities = -1;
  int totalFeaturedOwner = -1;

  String? nextPageUrl = '';

  Future<void> loadHomeData() async {
    ResponseModel model = await homeRepo.getData();
    if (model.statusCode == 200) {
      HomeResponseModel homeResponseModel =
          HomeResponseModel.fromJson(jsonDecode(model.responseJson));

      if (homeResponseModel.data != null) {
        totalPopularHotel =
            int.tryParse(homeResponseModel.data?.totalPopularHotels ?? '-1') ??
                -1;
        totalPopularCities =
            int.tryParse(homeResponseModel.data?.totalPopularCities ?? '-1') ??
                -1;
        totalFeaturedOwner =
            int.tryParse(homeResponseModel.data?.totalFeaturedOwners ?? '-1') ??
                -1;
      }

      if (homeResponseModel.data!.ads != null &&
          homeResponseModel.data!.ads!.isNotEmpty) {
        adsList.clear();
        adsList.addAll(homeResponseModel.data!.ads!);
      }

      if (homeResponseModel.data?.owners != null &&
          homeResponseModel.data!.owners!.isNotEmpty) {
        popularHotelList.clear();
        popularHotelList.addAll(homeResponseModel.data!.owners!);
      }

      if (homeResponseModel.data?.popularCities != null &&
          homeResponseModel.data!.popularCities!.isNotEmpty) {
        popularCityList.clear();
        popularCityList.addAll(homeResponseModel.data!.popularCities!);
      }

      if (homeResponseModel.data!.featuredOwners != null &&
          homeResponseModel.data!.featuredOwners!.isNotEmpty) {
        featuredHotelList.clear();
        featuredHotelList.addAll(homeResponseModel.data!.featuredOwners!);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  List<Datum> searchDataList = [];

  int page = 1;
  String searchKeyword = '';
  Future<void> loadSearchDestinationData() async {
    isSearchListLoading = true;
    update();

    ResponseModel model =
        await homeRepo.getSearchDestinationData(searchKeyword, '$page');
    if (model.statusCode == 200) {
      SearchDestinationResponseModel searchModel =
          SearchDestinationResponseModel.fromJson(
              jsonDecode(model.responseJson));

      if (searchModel.data!.cities?.data != null &&
          searchModel.data!.cities!.data!.isNotEmpty) {
        searchDataList.clear();
        searchDataList.addAll(searchModel.data!.cities!.data!);
        nextPageUrl = searchModel.data!.cities!.nextPageUrl;
        if (searchDataList.isNotEmpty) {
          cityId = searchDataList[0].id.toString();
          searchedPlaceName = searchDataList[0].name.toString();
          searchedPlaceCountry = searchDataList[0].country!.name.toString();
        }
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSearchListLoading = false;
    update();
  }

  bool isSearchListLoading = false;

  Future<void> fetchNewSearchList() async {
    isSearchListLoading = true;
    page = page + 1;

    update();

    ResponseModel model =
        await homeRepo.getSearchDestinationData(searchKeyword, '$page');
    if (model.statusCode == 200) {
      SearchDestinationResponseModel searchModel =
          SearchDestinationResponseModel.fromJson(
              jsonDecode(model.responseJson));

      if (page == 1) {
        searchDataList.clear();
      }

      if (searchModel.data?.cities?.data != null &&
          searchModel.data!.cities!.data!.isNotEmpty) {
        searchDataList.addAll(searchModel.data!.cities!.data!);
        nextPageUrl = searchModel.data!.cities!.nextPageUrl;
      }

      update();
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSearchListLoading = false;
    update();
  }

  bool hasNext() {
    if (nextPageUrl != null && nextPageUrl!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void setPageNumberAndKeyword(int pageNumber, String keyword) {
    page = pageNumber;
    searchKeyword = keyword;
    update();
  }

  String checkInDaysName = '';
  String checkOutDaysName = '';

  String checkInDate = ''; //all place
  String checkOutDate = ''; // all place

  setCheckInCheckOutDate(String checkInDate, String checkOutDate,
      String startDaysName, String endDaysName) {
    if (checkOutDate == MyStrings.endDate) {
      this.checkOutDate = MyStrings.checkOutDate;
    } else {
      this.checkOutDate = checkOutDate;
    }

    this.checkInDate = checkInDate;

    checkInDaysName = startDaysName;
    checkOutDaysName = endDaysName;

    update();
  }

  setCheckOutDate(String checkOutDate, String endDaysName) {
    DateFormat dateFormat = DateFormat('MMM dd, yyyy');

    DateTime checkInDate = dateFormat.parse(this.checkInDate);
    DateTime givenDate = dateFormat.parse(this.checkInDate);

    if (checkOutDate == MyStrings.startDate) {
    } else {
      if (givenDate.isBefore(checkInDate)) {
        this.checkOutDate = MyStrings.checkOutDate.tr;
      } else {
        this.checkOutDate = checkOutDate;
      }
      checkOutDaysName = endDaysName;
    }

    update();
  }

  bool isClickCheckOut = false;
  void setIsClickCheckOut(bool value) {
    isClickCheckOut = value;
    update();
  }

  bool isUserSelectCheckOutFirst = false;
  setCheckOutFirstClickStatus(bool value) {
    isUserSelectCheckOutFirst = value;
    update();
  }

  String cityId = '1';

  void setUserSearchText(Datum searchResult) {
    searchedPlaceName = searchResult.name.toString();
    searchedPlaceCountry = searchResult.country?.name ?? 'country';
    cityId = searchResult.id.toString();
    update();
  }

  void manageSearchTextForDestinationClick(
      String placeName, String country, String cityId) {
    searchedPlaceName = placeName;
    searchedPlaceCountry = country;
    this.cityId = cityId;
    update();
  }

  int expandIndex = -1;

  void changeExpandIndex(int index, [bool initialPopup = false]) {
    if (initialPopup) {
      expandIndex = index;
    } else {
      expandIndex = expandIndex == index ? -1 : index;
    }
    update();
  }

  List<Room> roomList = [
    Room(adults: 1, children: 0),
  ];

  List<Room> previousRoomList = [];

  void increaseQuantityAdults(int index) {
    roomList[index].adults++;
    update();
  }

  void increaseQuantityChildren(int index) {
    roomList[index].children++;
    update();
  }

  void decreaseQuantityAdults(int index) {
    if (roomList[index].adults > 1) {
      roomList[index].adults--;
      update();
    }
  }

  void decreaseQuantityChildren(int index) {
    if (roomList[index].children > 0) {
      roomList[index].children--;
      update();
    }
  }

  void addRoom() {
    // numberOfRooms++;
    roomList.add(Room(adults: 1, children: 0));
    changeExpandIndex(roomList.length - 1);

    numberOfRooms = roomList.length;

    update();
  }

  void removeRoom(int index) {
    if (roomList.length > 1) {
      roomList.removeAt(index);
      changeExpandIndex(roomList.length - 1);

      numberOfRooms = roomList.length;

      update();
    }
  }

  void countTotalGuest() {
    numberOfAdults =
        roomList.fold(0, (int sum, Room room) => sum + room.adults);
    numberOfChildren =
        roomList.fold(0, (int sum, Room room) => sum + room.children);
    numberOfGuests = numberOfAdults + numberOfChildren;
    numberOfRooms = roomList.length;

    update();
  }

  int pageViewCurrentIndex = 0;

  setPageViewCurrentIndex(int index) {
    pageViewCurrentIndex = index;
    update();
  }

  initialCheckInDate() {
    checkInDate = DateFormat('MMM dd, yyyy').format(DateTime.now());
    checkInDaysName = getDayNameFromWeekday(DateTime.now().weekday);
  }

  initialCheckOutDate() {
    DateTime currentDate = DateTime.now();
    DateTime nextDay = currentDate.add(const Duration(days: 1));
    checkOutDate = DateFormat('MMM dd, yyyy').format(nextDay);
    checkOutDaysName = getDayNameFromWeekday(nextDay.weekday);
  }

  getDaysName() {
    checkInDaysName = getDayNameFromWeekday(DateTime.now().weekday);
    checkOutDaysName = getDayNameFromWeekday(DateTime.now().weekday);
  }

  int numberOfNights() {
    final dateFormat = DateFormat('MMM dd, yyyy');

    DateTime checkInDate = dateFormat.parse(this.checkInDate);
    DateTime checkOutDate = dateFormat.parse(this.checkOutDate);

    Duration duration = checkOutDate.difference(checkInDate);
    int numberOfNights = duration.inHours ~/ 24;

    return numberOfNights;
  }

  DateTime dateTimeFormat(String date,
      {bool subtract = false, bool addition = false}) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    if (subtract) {
      DateTime dateTime =
          dateFormat.parse(date).subtract(const Duration(days: 1));
      return dateTime;
    } else if (addition) {
      DateTime dateTime = dateFormat.parse(date).add(const Duration(days: 1));
      return dateTime;
    } else {
      DateTime dateTime = dateFormat.parse(date);
      return dateTime;
    }
  }

  String getDayNameFromWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Invalid Weekday";
    }
  }

  Future<void> addLaunchUrl(String url) async {
    final Uri url0 = Uri.parse(url);

    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  void updateSearchData(
      {bool setPreviousDataIntoPresent = false,
      bool setPresentDataIntoPrevious = false}) {
    if (setPreviousDataIntoPresent) {
      checkInDate = previousCheckInData;
      checkOutDate = previousCheckOutData;

      roomList = previousRoomList;
    } else if (setPresentDataIntoPrevious) {
      previousCheckInData = checkInDate;
      previousCheckOutData = checkOutDate;

      previousRoomList = roomList;
    }
    update();
  }
}
