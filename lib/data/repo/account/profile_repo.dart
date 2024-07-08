import 'dart:convert';

import 'package:booking_box/core/utils/method.dart';
import 'package:booking_box/core/utils/my_strings.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/data/model/authorization/authorization_response_model.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/model/user_post_model/user_post_model.dart';
import 'package:booking_box/data/services/api_service.dart';
import 'package:booking_box/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/helper/shared_preference_helper.dart';

class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<bool> updateProfile(UserPostModel m,bool isProfile) async {

    try{
      apiClient.initToken();

      String url = '${UrlContainer.baseUrl}${isProfile?UrlContainer.updateProfileEndPoint:UrlContainer.profileCompleteEndPoint}';


      var request=http.MultipartRequest('POST',Uri.parse(url));
      Map<String,String>finalMap={
        'firstname': m.firstname,
        'lastname': m.lastName,
        'address': m.address??'',
        'zip': m.zip??'',
        'state': m.state??"",
        'city': m.city??'',
        'mobile': m.mobile,
        'country': m.country,
        'mobileCode': m.mobileCode,
        'country_code': m.countryCode,
      };

      request.headers.addAll(<String,String>{'Authorization' : 'Bearer ${apiClient.token}'});
      if(m.image!=null){
        request.files.add( http.MultipartFile('image', m.image!.readAsBytes().asStream(), m.image!.lengthSync(), filename: m.image!.path.split('/').last));
      }
      request.fields.addAll(finalMap);

      http.StreamedResponse response = await request.send();

      String jsonResponse=await response.stream.bytesToString();
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

      if(model.status?.toLowerCase()==MyStrings.success.toLowerCase()){
        CustomSnackBar.success(successList: model.message?.success??[MyStrings.success]);
        return true;
      }else{
        CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail.tr]);
        return false;
      }

    }catch(e){
      return false;
    }

  }

  Future<ResponseModel> loadProfileInfo() async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;

  }


  Future<dynamic>getCountryList()async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model=await apiClient.request(url, Method.getMethod, null);
    return model;
  }
}
