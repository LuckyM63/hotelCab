import 'package:booking_box/data/model/hotel_details/hotel_details_response_model.dart';

import '../../../core/utils/method.dart';
import '../../../core/utils/url_container.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/review_booking/booking_request_model.dart';
import '../../services/api_service.dart';

class ReviewBookingRepo{

  ApiClient apiClient;
  ReviewBookingRepo({required this.apiClient});

  Future<ResponseModel> getCountryData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> requestBooking(BookingRequestModel model, List<RoomType> selectedRoomList) async {

    final map = modelToMap(model,selectedRoomList);



    String url ='${UrlContainer.baseUrl}${UrlContainer.bookingRequestEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map,passHeader: true,);

    return responseModel;
  }

  Map<String, dynamic> modelToMap(BookingRequestModel model,List<RoomType> selectedRoomList) {

    Map<String, dynamic> bodyFields = {
      'check_in':model.checkIn,
      'checkout':model.checkOut,
      'owner_id': model.ownerId,
      'contact_name':model.contactName,
      'contact_number':model.contactNumber,
      'total_adult':model.totalAdults,
      'total_child':model.totalChildren,
    };

    List<RoomType> uniqueRooms = removeDuplicateRooms(selectedRoomList);

    for(int i = 0; i < uniqueRooms.length; i++){
      bodyFields['room_types[$i][type_id]'] = '${uniqueRooms[i].roomId}';
      bodyFields['room_types[$i][total_room]'] = '${uniqueRooms[i].totalRoomCount}';
    }

    return bodyFields;
  }

  List<RoomType> removeDuplicateRooms(List<RoomType> items) {
    List<RoomType> uniqueItems = [];
    var uniqueRoomsId = items
        .map((e) => e.roomId)
        .toSet(); // set remove all duplicate items
    for (var e in uniqueRoomsId) {
      uniqueItems.add(items.firstWhere((i) => i.roomId == e));
    }
    return uniqueItems;
  }

}