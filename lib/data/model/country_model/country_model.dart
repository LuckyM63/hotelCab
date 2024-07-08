// To parse this JSON data, do
//  final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

import '../auth/login/login_response_model.dart';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  String remark;
  String status;
  Message message;
  Data data;

  CountryModel({
    required this.remark,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
  List<Country> countries;

  Data({
    required this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
  };
}

class Country {
  int? id;
  String? name;
  String? code;
  String? dialCode;
  String? status;
  String? createdAt;
  String? updatedAt;

  Country({
    this.id,
    this.name,
    this.code,
    this.dialCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"] != null ?  json["name"].toString() : '',
    code: json["code"] != null ?  json["code"].toString() : '',
    dialCode: json["dial_code"] != null ?  json["dial_code"].toString() : '',
    status: json["status"] != null ?  json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "dial_code": dialCode,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}


