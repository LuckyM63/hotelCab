import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class PopularCarRepo {
  ApiClient apiClient;
  PopularCarRepo({required this.apiClient});

  Future<ResponseModel> getData(String page) async {
    String url =
        "${UrlContainer.carBookingBaseUrl}${UrlContainer.carPopularHotelsEndPoint}?page=$page";
    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}
