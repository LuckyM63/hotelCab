

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../services/api_service.dart';

class PaymentLogRepo{

  ApiClient apiClient;
  PaymentLogRepo({required this.apiClient});

  Future<ResponseModel> getData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.paymentHistoryEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}