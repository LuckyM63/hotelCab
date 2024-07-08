

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class FeaturedHotelRepo{

  ApiClient apiClient;
  FeaturedHotelRepo({required this.apiClient});

  Future<ResponseModel> getData(String page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.featuredHotelEndPoint}?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}