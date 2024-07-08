import 'dart:convert';
import 'package:booking_box/core/utils/method.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/data/model/general_setting/general_setting_response_model.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/services/api_service.dart';

import '../../model/room_model/RoomModel.dart';

class FilterPramRepo{

  ApiClient apiClient;
  FilterPramRepo({required this.apiClient});

  Future<ResponseModel> getData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.filterPramEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

}