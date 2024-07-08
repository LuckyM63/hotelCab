
import '../../core/utils/method.dart';
import '../../core/utils/url_container.dart';
import '../model/global/response_model/response_model.dart';
import '../services/api_service.dart';

class MyBookingRepo{

  ApiClient apiClient;
  MyBookingRepo({required this.apiClient});

  Future<ResponseModel> getData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.bookingHistoryEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getBookingRequestData(String page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.bookingRequestHistoryEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> cancelBooking(String bookingId) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.cancelBookingEndPoint}/$bookingId";
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, null, passHeader: true);
    return responseModel;
  }
}