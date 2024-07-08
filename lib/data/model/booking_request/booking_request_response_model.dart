
// To parse this JSON data, do
//
//     final bookingRequestResponseModel = bookingRequestResponseModelFromJson(jsonString);

import 'dart:convert';

BookingRequestResponseModel bookingRequestResponseModelFromJson(String str) => BookingRequestResponseModel.fromJson(json.decode(str));


class BookingRequestResponseModel {
  String? remark;
  String? status;
  Message? message;

  BookingRequestResponseModel({
    this.remark,
    this.status,
    this.message,
  });

  factory BookingRequestResponseModel.fromJson(Map<String, dynamic> json) => BookingRequestResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['error'] = _error;
    return map;
  }

}
