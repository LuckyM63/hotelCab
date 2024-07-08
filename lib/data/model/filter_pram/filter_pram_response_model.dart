import '../auth/login/login_response_model.dart';

class FilterPramResponseModel {
  FilterPramResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  FilterPramResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

}

class Data {
  Data({
      String? minFare,
      String? maxFare,
      String? maxStarRating,
      List<Amenities>? amenities,
      List<Facilities>? facilities}){
    _minFare = minFare;
    _maxFare = maxFare;
    _maxStarRating = maxStarRating;
    _amenities = amenities;
    _facilities = facilities;
}

  Data.fromJson(dynamic json) {
    _minFare = json['min_fare'] != null ? json['min_fare'].toString() : '';
    _maxFare = json['max_fare'] != null ? json['max_fare'].toString() : '';
    _maxStarRating = json['max_star_rating'] != null ? json['max_star_rating'].toString() : '';
    if (json['amenities'] != null) {
      _amenities = [];
      json['amenities'].forEach((v) {
        _amenities?.add(Amenities.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      _facilities = [];
      json['facilities'].forEach((v) {
        _facilities?.add(Facilities.fromJson(v));
      });
    }
  }

  String? _minFare;
  String? _maxFare;
  String? _maxStarRating;
  List<Amenities>? _amenities;
  List<Facilities>? _facilities;

  String? get minFare => _minFare;
  String? get maxFare => _maxFare;
  String? get maxStarRating => _maxStarRating;
  List<Amenities>? get amenities => _amenities;
  List<Facilities>? get facilities => _facilities;

}

class Facilities {
  Facilities({
      int? id, 
      String? name, 
      String? status,
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Facilities.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] != null ? json['name'].toString() : '';
    _isSelected = false;
    _status = json['status'] != null ? json['status'].toString() : '';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _status;
  bool? _isSelected;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  bool get isSelect => _isSelected!;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  void changeSelectedValue(){
    _isSelected = !_isSelected!;
  }

  changeSelectedValueFalse(){
    _isSelected = false;
  }

}

class Amenities {
  Amenities({
      int? id, 
      String? title, 
      String? icon,
      String? status,
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _title = title;
    _icon = icon;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Amenities.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'] != null ? json['title'].toString() : '';
    _icon = json['icon'] != null ? json['icon'].toString() : '';
    _status = json['status'] != null ? json['status'].toString() : '';
    _isSelect = false;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _title;
  String? _icon;
  String? _status;
  bool? _isSelect;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get title => _title;
  String? get icon => _icon;
  String? get status => _status;
  bool get isSelect => _isSelect!;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  void changeSelectedValue(){
    _isSelect = !_isSelect!;
  }

  void changeSelectedValueFalse(){
    _isSelect = false;
  }

}
