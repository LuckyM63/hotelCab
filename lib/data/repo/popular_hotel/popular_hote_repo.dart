

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class PopularHotelRepo{

  ApiClient apiClient;
  PopularHotelRepo({required this.apiClient});

  Future<ResponseModel> getData(String page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.popularHotelEndPoint}?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}