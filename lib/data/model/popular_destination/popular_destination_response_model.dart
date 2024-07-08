import 'dart:convert';

import '../auth/login/login_response_model.dart';

PopularCityResponseModel popularCityResponseModelFromJson(String str) => PopularCityResponseModel.fromJson(json.decode(str));

class PopularCityResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PopularCityResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory PopularCityResponseModel.fromJson(Map<String, dynamic> json) => PopularCityResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  PopularCities popularCities;

  Data({
    required this.popularCities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    popularCities: PopularCities.fromJson(json["popular_cities"]),
  );
}

class PopularCities {
  List<Datum>? data;
  String? nextPageUrl;
  String? total;

  PopularCities({
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory PopularCities.fromJson(Map<String, dynamic> json) => PopularCities(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    nextPageUrl: json["next_page_url"] != null ? json["next_page_url"].toString() : '',
    total: json["total"] != null ? json["total"].toString() : '',
  );
}

class Datum {
  int? id;
  String? countryId;
  String? name;
  String? image;
  String? isPopular;
  String? createdAt;
  String? updatedAt;
  String? totalHotel;
  String? imageUrl;
  Country? country;

  Datum({
    this.id,
    this.countryId,
    this.name,
    this.image,
    this.isPopular,
    this.createdAt,
    this.updatedAt,
    this.totalHotel,
    this.imageUrl,
    this.country,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    countryId: json["country_id"],
    name: json["name"] != null ? json["name"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    isPopular: json["is_popular"] != null ? json["is_popular"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    totalHotel: json["total_hotel"] != null ? json["total_hotel"].toString() : '',
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );
}

class Country {
  int? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}



