import 'dart:convert';

CancelBookingResponseModel cancelBookingResponseModelFromJson(String str) => CancelBookingResponseModel.fromJson(json.decode(str));

class CancelBookingResponseModel {
  String? remark;
  String? status;
  Message? message;

  CancelBookingResponseModel({
    this.remark,
    this.status,
    this.message,
  });

  factory CancelBookingResponseModel.fromJson(Map<String, dynamic> json) => CancelBookingResponseModel(
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

}
