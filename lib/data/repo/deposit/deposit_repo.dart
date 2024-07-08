import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class DepositRepo{

  ApiClient apiClient;
  DepositRepo({required this.apiClient});

  Future<ResponseModel> getDepositHistory({required int page, String searchText = ""}) async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.depositHistoryUrl}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;

  }

  Future<dynamic>getDepositMethods(String bookingId) async {

    String url='${UrlContainer.baseUrl}${UrlContainer.depositMethodUrl}/$bookingId';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;

  }


  Future<ResponseModel> insertDeposit({required String amount, required String methodCode, required String currency, required String bookingId}) async{

    print("------repo booking id---${bookingId}");
    
    String url = "${UrlContainer.baseUrl}${UrlContainer.depositInsertUrl}";
    Map<String, String> map = {
      "amount" : amount,
      "method_code": methodCode,
      "currency": currency,
      "booking_id": bookingId,
    };

    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;

  }

  Future<dynamic>getUserInfo() async {

    String url='${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel response= await apiClient.request(url,Method.getMethod, null,passHeader: true);
    return response;

  }

}