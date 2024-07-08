

import 'dart:convert';

import 'package:get/get.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/utils/my_strings.dart';
// import '../../model/authorization/authorization_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/notification/notification_response_model.dart';
import '../../repo/notificaton_repo/notification_repo.dart';

class NotificationsController extends GetxController {
  NotificationRepo repo;
  bool isLoading = true;

  NotificationsController({required this.repo});

  String? nextPageUrl;
  String? imageUrl;


  List<Datum> notificationList = [];

  int page = 0;

  void clearActiveNotificationInfo(){
    repo.apiClient.sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey,false);
  }

  Future<void> initData() async {
    page=page+1;
    if(page==1){
      notificationList.clear();
      isLoading=true;
      update();
    }

    ResponseModel response = await repo.loadAllNotification(page);
    if(response.statusCode==200){
      NotificationResponseModel model = NotificationResponseModel.fromJson(jsonDecode(response.responseJson));

      nextPageUrl=model.data?.notifications?.nextPageUrl ?? '';
      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        List<Datum>?tempList= model.data?.notifications?.data;
        if(tempList != null && tempList.isNotEmpty){
          notificationList.addAll(tempList);
        }
      }else{
        CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
      }
    }else{
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
    }

    if(page==1){
      isLoading=false;
    }
    update();
  }



  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl!.toLowerCase()!='null'? true : false;
  }


}
