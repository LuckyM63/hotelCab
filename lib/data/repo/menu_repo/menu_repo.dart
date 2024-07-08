import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:booking_box/core/utils/method.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/services/api_service.dart';

class MenuRepo{
  ApiClient apiClient;

  MenuRepo({required this.apiClient});

  Future<ResponseModel>logout()async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.logoutUrl}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null,passHeader: true);

    await clearSharedPrefData();

    return responseModel;
  }

  Future<ResponseModel>deleteAccount()async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.deleteAccountEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, null,passHeader: true);

    return responseModel;
  }

  Future<void> clearSharedPrefData()async{
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenType, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.accessTokenKey, '');
    await apiClient.sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.firstName, '');
    await apiClient.sharedPreferences.setString(SharedPreferenceHelper.lastName, '');

    return Future.value();
  }
}