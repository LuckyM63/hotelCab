import 'package:booking_box/core/utils/method.dart';
import 'package:booking_box/core/utils/url_container.dart';
import 'package:booking_box/data/model/global/response_model/response_model.dart';
import 'package:booking_box/data/services/api_service.dart';

import '../../model/room_model/RoomModel.dart';

class SearchRepo {
  ApiClient apiClient;
  SearchRepo({required this.apiClient});

  Future<ResponseModel> getSearchResult(List<Room> roomList, String cityId,
      String checkInDate, String checkoutDate, String page,
      {bool isFromDestination = false}) async {
    if (isFromDestination) {
      String url =
          "${UrlContainer.baseUrl}${UrlContainer.filterByCityEndPoint}/$cityId";

      ResponseModel responseModel = await apiClient
          .request(url, Method.getMethod, null, passHeader: true);

      return responseModel;
    } else {
      String url =
          "${UrlContainer.baseUrl}${UrlContainer.searchEndPoint}?city_id=$cityId&check_in=$checkInDate&checkout=$checkoutDate";
      for (int i = 0; i < roomList.length; i++) {
        String adultUrlPart =
            "&rooms[$i][total_adult]=${roomList[i].adults.toString()}";
        String childrenUrlPart =
            "&rooms[$i][total_child]=${roomList[i].children.toString()}";
        url = "$url$adultUrlPart$childrenUrlPart";
      }
      url = '$url&page=$page';

      ResponseModel responseModel = await apiClient
          .request(url, Method.getMethod, null, passHeader: true);

      return responseModel;
    }
  }

  Future<ResponseModel> getFilterSearchData(
      List<Room> roomList,
      String cityId,
      String checkInDate,
      String checkoutDate,
      String minFare,
      String maxFare,
      List<String> amenitiesSelectedIdList,
      List<String> facilitiesSelectedIdList,
      String starRating) async {
    String url =
        "${UrlContainer.baseUrl}${UrlContainer.searchEndPoint}?city_id=$cityId&check_in=$checkInDate&checkout=$checkoutDate";
    for (int i = 0; i < roomList.length; i++) {
      String adultUrlPart =
          "&rooms[$i][total_adult]=${roomList[i].adults.toString()}";
      String childrenUrlPart =
          "&rooms[$i][total_child]=${roomList[i].children.toString()}";
      url = "$url$adultUrlPart$childrenUrlPart";
    }

    url = "$url&min_fare=$minFare&max_fare=$maxFare";

    for (int i = 0; i < amenitiesSelectedIdList.length; i++) {
      url = "$url&amenities[$i]=${amenitiesSelectedIdList[i]}";
    }

    for (int i = 0; i < facilitiesSelectedIdList.length; i++) {
      url = "$url&facilities[$i]=${facilitiesSelectedIdList[i]}";
    }

    url = '$url&star_rating=$starRating';

    ResponseModel responseModel =
        await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return responseModel;
  }
}
