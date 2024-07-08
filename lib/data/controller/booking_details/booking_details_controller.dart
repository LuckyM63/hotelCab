import 'dart:convert';

import 'package:get/get.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/model/booking_details/booking_details_response_model.dart';
import 'package:booking_box/data/repo/booking_details/booking_details_repo.dart';

import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class BookingDetailsController extends GetxController{

  BookingDetailsRepo bookingDetailsRepo;
  BookingDetailsController({required this.bookingDetailsRepo});

  var homeController = Get.find<HomeController>();

  int currentPaymentType = 0;


  bool isLoading = true;
  bool isRoomDetails = false;

  List<String> dateList = [];
  List<Rooms> roomList = [];
  List<BookedRooms> bookedRooms = [];

  Booking? booking;
  PaymentInfo? paymentInfo;

  String hotelName = '';
  String hotelImage = '';
  String location = '';
  String checkIn = '';
  String checkOut = '';
  String taxName = '';

  List<BookedRooms> roomDetails = [];


  Future<void> loadBookingDetailsData(String id) async {
    isLoading = true;
    update();
    ResponseModel model = await bookingDetailsRepo.getData(id);
    if(model.statusCode == 200){

      try{
        BookingDetailsResponseModel bookingDetailsResponseModel = BookingDetailsResponseModel.fromJson(jsonDecode(model.responseJson));

        if(bookingDetailsResponseModel.data?.booking != null){
          booking = bookingDetailsResponseModel.data!.booking!;

          checkIn = bookingDetailsResponseModel.data?.booking?.checkIn ?? '';
          checkOut = bookingDetailsResponseModel.data?.booking?.checkOut ?? '';

          if(booking?.owner != null){
            hotelName = booking?.owner?.hotelSetting?.name??'';
            hotelImage = booking?.owner?.hotelSetting?.ImageUrl ?? '';
            location = booking?.owner?.hotelSetting?.location?.name ?? '';
            taxName = booking?.owner?.hotelSetting?.taxName ?? '';
          }
        }

        if(bookingDetailsResponseModel.data?.paymentInfo != null){
          paymentInfo = bookingDetailsResponseModel.data!.paymentInfo!;
        }

        roomDetails = bookingDetailsResponseModel.data!.bookedRooms!;

        bookingDetailsResponseModel.data?.bookedRooms?.forEach((element) {
          dateList.add(element.date.toString());
        });
      } catch(e){
        //handle error
      }


    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }

    isLoading = false;
    update();

  }

  void toggleRoomDetails(){
    isRoomDetails = !isRoomDetails;
    update();
  }

}