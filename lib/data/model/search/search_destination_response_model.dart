
import 'dart:convert';
import '../auth/login/login_response_model.dart';

SearchDestinationResponseModel searchDestinationResponseModelFromJson(String str) => SearchDestinationResponseModel.fromJson(json.decode(str));


class SearchDestinationResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SearchDestinationResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory SearchDestinationResponseModel.fromJson(Map<String, dynamic> json) => SearchDestinationResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Cities? cities;

  Data({
    this.cities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cities: json["cities"] == null ? null : Cities.fromJson(json["cities"]),
  );
}

class Cities {
  List<Datum>? data;
  String? nextPageUrl;
  String? total;

  Cities({
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    nextPageUrl: json["next_page_url"] != null ? json["next_page_url"].toString() : '',
    total: json["total"] != null ? json["total"].toString() : '',
  );

}

class Datum {
  int? id;
  String? name;
  String? countryId;
  String? image;
  String? imageUrl;
  Country? country;

  Datum({
    this.id,
    this.name,
    this.countryId,
    this.image,
    this.imageUrl,
    this.country,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"] != null ? json["name"].toString() : '',
    countryId: json["country_id"] != null ? json["country_id"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );
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
    id: json["id"] ,
    name: json["name"] != null ? json["name"].toString() : "",
    code: json["code"] != null ? json["code"].toString() : "",
    dialCode: json["dial_code"] != null ? json["dial_code"].toString() : "",
    status: json["status"] != null ? json["status"].toString() : "",
    createdAt: json["created_at"] != null ? json["created_at"].toString() : "",
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : "",
  );

}


