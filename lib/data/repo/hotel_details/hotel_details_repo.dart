
import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/room_model/RoomModel.dart';
import '../../services/api_service.dart';

class HotelDetailsRepo{

  ApiClient apiClient;
  HotelDetailsRepo({required this.apiClient});

  Future<ResponseModel> getData(String hotelId, String checkInDate, String checkOutDate, List<Room> roomList) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.hotelDetailEndPoint}$hotelId?check_in=$checkInDate&checkout=$checkOutDate";
    for(int i = 0; i<roomList.length; i++){
      String adultUrlPart = "&rooms[$i][total_adult]=${roomList[i].adults.toString()}";
      String childrenUrlPart = "&rooms[$i][total_child]=${roomList[i].children.toString()}";
      url = "$url$adultUrlPart$childrenUrlPart";
    }
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}