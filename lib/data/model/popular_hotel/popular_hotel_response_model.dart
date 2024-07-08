
import 'dart:convert';

import '../auth/login/login_response_model.dart';

PopularHotelResponseModel popularHotelResponseModelFromJson(String str) => PopularHotelResponseModel.fromJson(json.decode(str));

class PopularHotelResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PopularHotelResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory PopularHotelResponseModel.fromJson(Map<String, dynamic> json) => PopularHotelResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null :  Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Owners? owners;

  Data({
    this.owners,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    owners: json["owners"] == null ? null : Owners.fromJson(json["owners"]),
  );
}

class Owners {
  List<Datum>? data;
  String? nextPageUrl;
  String? total;

  Owners({
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory Owners.fromJson(Map<String, dynamic> json) => Owners(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    nextPageUrl: json["next_page_url"] != null ? json["next_page_url"].toString() : '',
    total: json["total"] != null ? json["total"].toString() : '',
  );
}

class Datum {
  int? id;
  String?parentId;
  String?roleId;
  String? firstname;
  String? lastname;
  String?username;
  String?email;
  String? image;
  String?countryCode;
  String?mobile;
  Address? address;
  String?isFeatured;
  String?status;
  String?ev;
  String?sv;
  String? verCodeSendAt;
  String?ts;
  String?tv;
  String? tsc;
  String? banReason;
  String?avgRating;
  DateTime? expireAt;
  String? createdAt;
  String?updatedAt;
  String?totalBookings;
  HotelSetting? hotelSetting;
  String?minimumFare;

  Datum({
    this.id,
    this.parentId,
    this.roleId,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.image,
    this.countryCode,
    this.mobile,
    this.address,
    this.isFeatured,
    this.status,
    this.ev,
    this.sv,
    this.verCodeSendAt,
    this.ts,
    this.tv,
    this.tsc,
    this.banReason,
    this.avgRating,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
    this.totalBookings,
    this.hotelSetting,
    this.minimumFare
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    parentId: json["parent_id"] != null ? json["parent_id"].toString() : '',
    roleId: json["role_id"] != null ? json["role_id"].toString() : '',
    firstname: json["firstname"] != null ? json["firstname"].toString() : '',
    lastname: json["lastname"] != null ? json["lastname"].toString() : '',
    username: json["username"] != null ? json["username"].toString() : '',
    email: json["email"] != null ? json["email"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    countryCode: json["country_code"] != null ? json["parent_id"].toString() : '',
    mobile: json["mobile"] != null ? json["mobile"].toString() : '',
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    isFeatured: json["is_featured"] != null ? json["is_featured"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    ev: json["ev"] != null ? json["ev"].toString() : '',
    sv: json["sv"] != null ? json["sv"].toString() : '',
    verCodeSendAt: json["ver_code_send_at"],
    ts: json["ts"] != null ? json["ts"].toString() : '',
    tv: json["tv"] != null ? json["tv"].toString() : '',
    tsc: json["tsc"] != null ? json["tsc"].toString() : '',
    banReason: json["ban_reason"] != null ? json["ban_reason"].toString() : '',
    avgRating: json["avg_rating"] != null ? json["avg_rating"].toString() : '',
    expireAt: DateTime.parse(json["expire_at"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    totalBookings: json["total_bookings"] != null ? json["total_bookings"].toString() : '',
    minimumFare: json['minimum_fare'] != null ? json["minimum_fare"].toString() : '',
    hotelSetting: json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"],),
  );
}

class Address {
  String?address;
  String?city;
  String? state;
  String?zip;
  String?country;

  Address({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"] != null ? json["address"].toString() : '',
    city: json["city"] != null ? json["city"].toString() : '',
    state: json["state"] != null ? json["state"].toString() : '',
    zip: json["zip"] != null ? json["zip"].toString() : '',
    country: json["country"] != null ? json["country"].toString() : '',
  );
}

class HotelSetting {
  int? id;
  String? ownerId;
  String? name;
  String? starRating;
  String? logo;
  String? coverPhoto;
  String? latitude;
  String? longitude;
  String? address;
  String? taxName;
  String? taxPercentage;
  String? checkinTime;
  String? checkoutTime;
  String? upcomingCheckinDays;
  String? upcomingCheckoutDays;
  String? description;
  List<String>? keywords;
  String? hasHotDeal;
  String? createdAt;
  String? updatedAt;
  String? ImageUrl;
  String? coverPhotoUrl;

  HotelSetting({
    this.id,
    this.ownerId,
    this.name,
    this.starRating,
    this.logo,
    this.coverPhoto,
    this.latitude,
    this.longitude,
    this.address,
    this.taxName,
    this.taxPercentage,
    this.checkinTime,
    this.checkoutTime,
    this.upcomingCheckinDays,
    this.upcomingCheckoutDays,
    this.description,
    this.keywords,
    this.hasHotDeal,
    this.createdAt,
    this.updatedAt,
    this.ImageUrl,
    this.coverPhotoUrl,
  });

  factory HotelSetting.fromJson(Map<String, dynamic> json) => HotelSetting(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    starRating: json["star_rating"] != null ? json["star_rating"].toString() : '',
    logo: json["logo"] != null ? json["logo"].toString() : '',
    coverPhoto: json["cover_photo"] != null ? json["cover_photo"].toString() : '',
    latitude: json["latitude"] != null ? json["latitude"].toString() : '',
    longitude: json["longitude"] != null ? json["longitude"].toString() : '',
    address: json["hotel_address"] != null ? json["hotel_address"].toString() : '',
    taxName: json["tax_name"] != null ? json["tax_name"].toString() : '',
    taxPercentage: json["tax_percentage"] != null ? json["tax_percentage"].toString() : '',
    checkinTime: json["checkin_time"] != null ? json["checkin_time"].toString() : '',
    checkoutTime: json["checkout_time"] != null ? json["checkout_time"].toString() : '',
    upcomingCheckinDays: json["upcoming_checkin_days"] != null ? json["upcoming_checkin_days"].toString() : '',
    upcomingCheckoutDays: json["upcoming_checkout_days"] != null ? json["upcoming_checkout_days"].toString() : '',
    description: json["description"]!= null ? json["description"].toString() : '',
    keywords: List<String>.from(json["keywords"].map((x) => x)),
    hasHotDeal: json["has_hot_deal"] != null ? json["has_hot_deal"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    ImageUrl: json["image_url"]  != null ? json["image_url"].toString() : '',
    coverPhotoUrl: json["cover_photo_url"]  != null ? json["cover_photo_url"].toString() : '',
  );

}



