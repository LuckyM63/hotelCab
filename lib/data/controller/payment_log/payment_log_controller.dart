import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:booking_box/data/controller/home/home_controller.dart';
import 'package:booking_box/data/model/payment_log/payment_log_response_model.dart';
import 'package:booking_box/data/repo/payment_log/payment_log_repo.dart';

import '../../../core/utils/my_strings.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class PaymentLogController extends GetxController{

  PaymentLogRepo paymentLogRepo;
  PaymentLogController({required this.paymentLogRepo});

  var homeController = Get.find<HomeController>();

  int currentPaymentType = 0;


  bool isLoading = true;

  Future<void> loadData() async{

    await loadBookingData();

    isLoading = false;
    update();

  }

  List<Datum> paymentLogList = [];

  Future<void> loadBookingData() async {

    ResponseModel model = await paymentLogRepo.getData();
    if(model.statusCode == 200){

      PaymentLogResponseModel paymentLogResponseModel = PaymentLogResponseModel.fromJson(jsonDecode(model.responseJson));

      if(paymentLogResponseModel.data?.deposits?.data != null && paymentLogResponseModel.data!.deposits!.data!.isNotEmpty){
        paymentLogList.clear();
        paymentLogList.addAll(paymentLogResponseModel.data!.deposits!.data!);
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

    ResponseModel model = await paymentLogRepo.getData();
    if(model.statusCode == 200){

      PaymentLogResponseModel paymentLogResponseModel = PaymentLogResponseModel.fromJson(jsonDecode(model.responseJson));

      if(paymentLogResponseModel.data?.deposits?.data != null &&  paymentLogResponseModel.data!.deposits!.data!.isNotEmpty){
        paymentLogList.addAll(paymentLogResponseModel.data!.deposits!.data!);
      }

      update();

    }else{
      CustomSnackBar.error(errorList: [model.message]);
    }
  }
  String getBookingStatus(Datum bookingHistory){

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime currentDate = DateTime.now();
    DateTime givenDate = dateFormat.parse('');

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



}