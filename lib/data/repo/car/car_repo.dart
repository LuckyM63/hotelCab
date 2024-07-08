import 'package:booking_box/core/utils/method.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/services/api_service.dart';

class CarRepo {
  ApiClient apiClient;
  CarRepo({required this.apiClient});

  Future<ResponseModel> getData() async {
    String url =
        "${UrlContainer.carBookingBaseUrl}${UrlContainer.carHomeEndPoint}";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getSearchDestinationData(
      String keywords, String pageNumber) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.searchDestinationEndPoint}?keywords=$keywords&page=$pageNumber";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
