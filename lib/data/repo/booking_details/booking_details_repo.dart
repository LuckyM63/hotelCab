

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class BookingDetailsRepo{

  ApiClient apiClient;
  BookingDetailsRepo({required this.apiClient});


  Future<ResponseModel> getData(String id) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.bookingDetailsEndPoint}/$id";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}