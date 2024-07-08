

import 'dart:convert';
import '../auth/login/login_response_model.dart';

PrivacyResponseModel privacyResponseModelFromJson(String str) => PrivacyResponseModel.fromJson(json.decode(str));

String privacyResponseModelToJson(PrivacyResponseModel data) => json.encode(data.toJson());

class PrivacyResponseModel {
  String remark;
  String status;
  Message message;
  Data data;

  PrivacyResponseModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory PrivacyResponseModel.fromJson(Map<String, dynamic> json) => PrivacyResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "status": status,
    "message": message.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  List<Policy> policies;

  Data({
    required this.policies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    policies: List<Policy>.from(json["policies"].map((x) => Policy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "policies": List<dynamic>.from(policies.map((x) => x.toJson())),
  };
}

class Policy {
  int id;
  String tempname;
  String dataKeys;
  DataValues dataValues;
  String createdAt;
  String updatedAt;

  Policy({
    required this.id,
    required this.tempname,
    required this.dataKeys,
    required this.dataValues,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
    id: json["id"],
    tempname: json["tempname"].toString(),
    dataKeys: json["data_keys"].toString(),
    dataValues: DataValues.fromJson(json["data_values"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tempname": tempname,
    "data_keys": dataKeys,
    "data_values": dataValues.toJson(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class DataValues {
  String title;
  String details;

  DataValues({
    required this.title,
    required this.details,
  });

  factory DataValues.fromJson(Map<String, dynamic> json) => DataValues(
    title: json["title"],
    details: json["details"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "details": details,
  };
}

