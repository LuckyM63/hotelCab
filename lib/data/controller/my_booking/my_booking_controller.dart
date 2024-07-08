import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/model/booking_history/booking_history_response_model.dart';
import 'package:booking_box/data/model/booking_history/booking_request_history_response_model.dart';
import 'package:booking_box/data/model/booking_history/cancel_booking_response_model.dart';
import 'package:booking_box/data/repo/my_booking_repo.dart';

import '../../../core/utils/my_strings.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class MyBookingController extends GetxController{

  MyBookingRepo myBookingRepo;
  MyBookingController({required this.myBookingRepo});

  var homeController = Get.find<HomeController>();

  int currentPaymentType = 0;


  bool isLoading = true;
  bool isRequestLoading = true;

  Future<void> loadData() async{

    if(bookingHistoryList.isEmpty){
      isLoading = true;
      update();
    }

    isRequestLoading = true;

    await loadBookingData();
    await loadBookingRequestData();

    isLoading = false;
    update();

  }

  List<Datum> bookingHistoryList = [];

  double confirmationAmount = 0.0;

  Future<void> loadBookingData() async {

    ResponseModel model = await myBookingRepo.getData();
    if(model.statusCode == 200){

      BookingHistoryResponseModel bookingHistoryResponseModel = BookingHistoryResponseModel.fromJson(jsonDecode(model.responseJson));

      if(bookingHistoryResponseModel.data?.bookings?.data != null && bookingHistoryResponseModel.data!.bookings!.data!.isNotEmpty){
        bookingHistoryList.clear();
        bookingHistoryList.addAll(bookingHistoryResponseModel.data!.bookings!.data!);
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

  Future<void> fetchNewBookingData() async {

    page = page + 1;

    ResponseModel model = await myBookingRepo.getData();
    if(model.statusCode == 200){

      BookingHistoryResponseModel bookingHistoryResponseModel = BookingHistoryResponseModel.fromJson(jsonDecode(model.responseJson));

      if(bookingHistoryResponseModel.data?.bookings?.data != null && bookingHistoryResponseModel.data!.bookings!.data!.isNotEmpty){
        bookingHistoryList.addAll(bookingHistoryResponseModel.data!.bookings!.data!);
      }

      update();

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  //----------request booking-----------

  List<BookingRequest>requestBookingList = [];

  Future<void> loadBookingRequestData() async {
    isRequestLoading = true;
    update();
    requestBookingList.clear();

    ResponseModel model = await myBookingRepo.getBookingRequestData(pageRequestBooking.toString());
    if(model.statusCode == 200){

      BookingRequestHistoryResponseModel bookingRequestHistoryResponseModel = BookingRequestHistoryResponseModel.fromJson(jsonDecode(model.responseJson));

      if(bookingRequestHistoryResponseModel.data?.bookingRequests != null && bookingRequestHistoryResponseModel.data!.bookingRequests!.isNotEmpty){
        requestBookingList.clear();
        requestBookingList.addAll(bookingRequestHistoryResponseModel.data!.bookingRequests!);

        List<BookingRequest>temp = [];

        for(int i = requestBookingList.length - 1; i >= 0; i--){
          temp.add(requestBookingList[i]);
        }

        requestBookingList.clear();
        requestBookingList = temp;
      }

      isRequestLoading = false;

    }else{
      CustomSnackBar.error(errorList: [model.message]);
      isRequestLoading = false;
    }
  }


  String? nextPageUrlRequestBooking='';
  int pageRequestBooking = 1;

  bool hasNextRequestBooking(){
    if(nextPageUrlRequestBooking!=null && nextPageUrlRequestBooking!.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<void> fetchNewBookingRequestData() async {

    pageRequestBooking = pageRequestBooking + 1;

    ResponseModel model = await myBookingRepo.getBookingRequestData(pageRequestBooking.toString());
    if(model.statusCode == 200){

      BookingRequestHistoryResponseModel bookingRequestHistoryResponseModel = BookingRequestHistoryResponseModel.fromJson(jsonDecode(model.responseJson));

      if(bookingRequestHistoryResponseModel.data?.bookingRequests != null && bookingRequestHistoryResponseModel.data!.bookingRequests!.isNotEmpty){

        List<BookingRequest>tempBookingList = [];

        tempBookingList.addAll(bookingRequestHistoryResponseModel.data!.bookingRequests!);

        List<BookingRequest>temp = [];

        for(int i = tempBookingList.length - 1; i >= 0; i--){
          temp.add(requestBookingList[i]);
        }

        requestBookingList.addAll(temp);
      }

      update();

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  bool isBookingCancelLoading = false;

  int currentIndex = -1;

  setCurrentIndex(int index){
    currentIndex = index;
    update();
  }

  Future<void> cancelBookingRequest(String bookingId)async{
    isBookingCancelLoading = true;
    update();

    ResponseModel model = await myBookingRepo.cancelBooking(bookingId);

    if(model.statusCode == 200){

      CancelBookingResponseModel cancelBookingResponseModel = CancelBookingResponseModel.fromJson(jsonDecode(model.responseJson));

      if (cancelBookingResponseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(successList: cancelBookingResponseModel.message?.success ??[MyStrings.success.tr]);

        requestBookingList.removeWhere((element) => element.id.toString() == bookingId);

      } else {
        CustomSnackBar.error(errorList:cancelBookingResponseModel.message?.error ?? [MyStrings.somethingWentWrong.tr]);
      }

    } else{
      CustomSnackBar.error(errorList: [model.message]);
    }

    isBookingCancelLoading=false;
    update();
  }

  void changeCurrentPaymentType(int index){
    currentPaymentType = index;
    update();
  }


  String getBookingStatus(Datum bookingHistory){

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime currentDate = DateTime.now();
    DateTime givenDate = dateFormat.parse(bookingHistory.checkIn!);

    if (givenDate.isBefore(currentDate) && bookingHistory.status == '1') {
      return MyStrings.running.tr;
    } else if (givenDate.isAfter(currentDate) && bookingHistory.status == '1') {
      return MyStrings.upcoming.tr;
    } else if(bookingHistory.status == '3') {
      return MyStrings.canceled.tr;
    }else{
      return MyStrings.checkedOut.tr;
    }
  }

  int tabInitialIndex = 0;

  setTabInitialIndex(int index){
    tabInitialIndex = index;
    update();
  }

}