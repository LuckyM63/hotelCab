
import '../auth/sign_up_model/registration_response_model.dart';

class MainLanguageResponseModel {
  MainLanguageResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  MainLanguageResponseModel.fromJson(dynamic json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    required this.languages,
    required this.file,});

  Data.fromJson(dynamic json) {
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
    file = json['file'];
  }
  List<Languages>? languages;
  String? file;


}

class Languages {
  Languages({
    int? id,
    String? name,
    String? code,
    String? isDefault,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _name = name;
    _code = code;
    _isDefault = isDefault;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Languages.fromJson(dynamic json) {
    _id = json['id'] ;
    _name = json['name']  != null? json['name'].toString(): "";
    _code = json['code']  != null? json['code'].toString(): "";
    _isDefault = json['is_default']  != null? json['is_default'].toString(): "";
    _createdAt = json['created_at'] ;
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _code;
  String? _isDefault;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get code => _code;
  String? get isDefault => _isDefault;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    map['is_default'] = _isDefault;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}