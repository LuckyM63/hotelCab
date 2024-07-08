class SearchResultResponseModel {
  SearchResultResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  SearchResultResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainData = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _mainData;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get mainData => _mainData;

}

class MainData {
  MainData({
      String? logoPath, 
      Hotels? hotels,}){
    _logoPath = logoPath;
    _hotels = hotels;
}

  MainData.fromJson(dynamic json) {
    _logoPath = json['image_path'] != null ?  json['image_path'].toString() : '';
    _hotels = json['hotels'] != null ? Hotels.fromJson(json['hotels']) : null;
  }
  String? _logoPath;
  Hotels? _hotels;

  String? get logoPath => _logoPath;
  Hotels? get hotels => _hotels;

}

class Hotels {
  Hotels({
      List<SearchResultData>? searchResultData,
      String? nextPageUrl,
      String? total,}){
    _searchResultData = searchResultData;
    _nextPageUrl = nextPageUrl;
    _total = total;
}

  Hotels.fromJson(dynamic json) {
    if (json['data'] != null) {
      _searchResultData = [];
      json['data'].forEach((v) {
        _searchResultData?.add(SearchResultData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'] != null ? json['next_page_url'].toString() : '';
    _total = json['total'] != null ? json['total'].toString() : '';
  }

  List<SearchResultData>? _searchResultData;
  String? _nextPageUrl;
  String? _total;


  List<SearchResultData>? get searchResultData => _searchResultData;
  String? get nextPageUrl => _nextPageUrl;
  String? get total => _total;

}


class SearchResultData {
  SearchResultData({
      int? id, 
      String? ownerId,
      String? name, 
      String? starRating,
      String? logo, 
      String? coverPhoto, 
      String? latitude, 
      String? longitude, 
      String? hotelAddress,
      String? destinationId,
      String? neighborhoodId,
      String? taxName, 
      String? taxPercentage, 
      String? checkinTime, 
      String? checkoutTime, 
      String? upcomingCheckinDays,
      String? upcomingCheckoutDays,
      String? description, 
      String? keywords, 
      String? hasHotDeal,
      String? createdAt, 
      String? updatedAt, 
      String? country, 
      String? destination, 
      String? adultCapacity, 
      String? childCapacity, 
      String? minimumFare, 
      String? maximumFare,}){
    _id = id;
    _ownerId = ownerId;
    _name = name;
    _starRating = starRating;
    _logo = logo;
    _coverPhoto = coverPhoto;
    _latitude = latitude;
    _longitude = longitude;
    _hotelAddress = hotelAddress;
    _destinationId = destinationId;
    _neighborhoodId = neighborhoodId;
    _taxName = taxName;
    _taxPercentage = taxPercentage;
    _checkinTime = checkinTime;
    _checkoutTime = checkoutTime;
    _upcomingCheckinDays = upcomingCheckinDays;
    _upcomingCheckoutDays = upcomingCheckoutDays;
    _description = description;
    _keywords = keywords;
    _hasHotDeal = hasHotDeal;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _country = country;
    _destination = destination;
    _adultCapacity = adultCapacity;
    _childCapacity = childCapacity;
    _minimumFare = minimumFare;
    _maximumFare = maximumFare;
}

  SearchResultData.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['owner_id'] != null ? json['owner_id'].toString() : '';
    _name = json['name'] != null ? json['name'].toString() : '';
    _starRating = json['star_rating'] != null ? json['star_rating'].toString() : '';
    _logo = json['image'] != null ? json['image'].toString() : '';
    _coverPhoto = json['cover_photo'] != null ? json['cover_photo'].toString() : '';
    _latitude = json['latitude'] != null ? json['latitude'].toString() : '';
    _longitude = json['longitude'] != null ? json['longitude'].toString() : '';
    _hotelAddress = json['hotel_address'] != null ? json['hotel_address'].toString() : '';
    _destinationId = json['destination_id'] != null ? json['destination_id'].toString() : '';
    _neighborhoodId = json['neighborhood_id'] != null ? json['neighborhood_id'].toString() : '';
    _taxName = json['tax_name'] != null ? json['tax_name'].toString() : '';
    _taxPercentage = json['tax_percentage'] != null ? json['tax_percentage'].toString() : '';
    _checkinTime = json['checkin_time'] != null ? json['checkin_time'].toString() : '';
    _checkoutTime = json['checkout_time'] != null ? json['checkout_time'].toString() : '';
    _upcomingCheckinDays = json['upcoming_checkin_days'] != null ? json['upcoming_checkin_days'].toString() : '';
    _upcomingCheckoutDays = json['upcoming_checkout_days']!= null ? json['upcoming_checkout_days'].toString() : '';
    _description = json['description'] != null ? json['description'].toString() : '';
    _keywords = json['keywords']!= null ? json['keywords'].toString() : '';
    _hasHotDeal = json['has_hot_deal'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _country = json['country'] != null ? json['country'].toString() : '';
    _destination = json['destination'] != null ? json['destination'].toString() : '';
    _adultCapacity = json['adult_capacity'] != null ? json['adult_capacity'].toString() : '';
    _childCapacity = json['child_capacity']!= null ? json['child_capacity'].toString() : '';
    _minimumFare = json['minimum_fare'] != null ? json['minimum_fare'].toString() : '';
    _maximumFare = json['maximum_fare'] != null ? json['maximum_fare'].toString() : '';
  }
  int? _id;
  String? _ownerId;
  String? _name;
  String? _starRating;
  String? _logo;
  String? _coverPhoto;
  String? _latitude;
  String? _longitude;
  String? _hotelAddress;
  String? _destinationId;
  String? _neighborhoodId;
  String? _taxName;
  String? _taxPercentage;
  String? _checkinTime;
  String? _checkoutTime;
  String? _upcomingCheckinDays;
  String? _upcomingCheckoutDays;
  String? _description;
  String? _keywords;
  String? _hasHotDeal;
  String? _createdAt;
  String? _updatedAt;
  String? _country;
  String? _destination;
  String? _adultCapacity;
  String? _childCapacity;
  String? _minimumFare;
  String? _maximumFare;

  int? get id => _id;
  String? get ownerId => _ownerId;
  String? get name => _name;
  String? get starRating => _starRating;
  String? get logo => _logo;
  String? get coverPhoto => _coverPhoto;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get hotelAddress => _hotelAddress;
  String? get destinationId => _destinationId;
  String? get neighborhoodId => _neighborhoodId;
  String? get taxName => _taxName;
  String? get taxPercentage => _taxPercentage;
  String? get checkinTime => _checkinTime;
  String? get checkoutTime => _checkoutTime;
  String? get upcomingCheckinDays => _upcomingCheckinDays;
  String? get upcomingCheckoutDays => _upcomingCheckoutDays;
  String? get description => _description;
  String? get keywords => _keywords;
  String? get hasHotDeal => _hasHotDeal;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get country => _country;
  String? get destination => _destination;
  String? get adultCapacity => _adultCapacity;
  String? get childCapacity => _childCapacity;
  String? get minimumFare => _minimumFare;
  String? get maximumFare => _maximumFare;

}

class Message {
  Message({
    List<String>? success,
    List<String>? error
  }){
    _success = success;
    _error = error;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ? [json['success'].toString()] : null;
    _error   = json['error']   != null ? [json['error'].toString()]  : null;
  }

  List<String>? _success;
  List<String>? _error;

  List<String>? get success => _success;
  List<String>? get error => _error;

}
