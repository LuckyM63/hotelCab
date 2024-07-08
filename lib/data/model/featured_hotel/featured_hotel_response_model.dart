import 'dart:convert';

import '../auth/login/login_response_model.dart';

FeaturedHotelResponseModel featuredHotelResponseModelFromJson(String str) => FeaturedHotelResponseModel.fromJson(json.decode(str));

class FeaturedHotelResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  FeaturedHotelResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory FeaturedHotelResponseModel.fromJson(Map<String, dynamic> json) => FeaturedHotelResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  FeaturedHotels? featuredHotels;

  Data({
    this.featuredHotels,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    featuredHotels: json["featured_hotels"] == null ? null : FeaturedHotels.fromJson(json["featured_hotels"]),
  );
}

class FeaturedHotels {
  String? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  String? from;
  String? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  String? to;
  String? total;

  FeaturedHotels({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory FeaturedHotels.fromJson(Map<String, dynamic> json) => FeaturedHotels(
    currentPage: json["current_page"]  != null ?  json["current_page"].toString() : '',
    data: json["data"] != null ?  List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
    nextPageUrl: json["next_page_url"]  != null ?  json["next_page_url"].toString() : '',
    total: json["total"]  != null ?  json["total"].toString() : '',
  );
}

class Datum {
  int? id;
  String?parentId;
  String?roleId;
  String?firstname;
  String? lastname;
  String?email;
  String? image;
  String?countryCode;
  String?mobile;
  Address? address;
  String?isFeatured;
  String? formData;
  String? banReason;
  DateTime? expireAt;
  String?avgRating;
  String?autoPayment;
  String? createdAt;
  String?updatedAt;
  HotelSetting? hotelSetting;

  Datum({
    this.id,
    this.parentId,
    this.roleId,
    this.firstname,
    this.lastname,
    this.email,
    this.image,
    this.countryCode,
    this.mobile,
    this.address,
    this.isFeatured,
    this.formData,
    this.banReason,
    this.expireAt,
    this.avgRating,
    this.autoPayment,
    this.createdAt,
    this.updatedAt,
    this.hotelSetting,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    parentId: json["parent_id"] != null ? json["parent_id"].toString() : '',
    roleId: json["role_id"] != null ? json["parent_id"].toString() : '',
    firstname: json["firstname"] != null ? json["firstname"].toString() : '',
    lastname: json["lastname"] != null ? json["lastname"].toString() : '',
    email: json["email"] != null ? json["email"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    countryCode: json["country_code"] != null ? json["country_code"].toString() : '',
    mobile: json["mobile"] != null ? json["mobile"].toString() : '',
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    isFeatured: json["is_featured"] != null ? json["is_featured"].toString() : '',
    formData: json["form_data"] != null ? json["form_data"].toString() : '',
    banReason: json["ban_reason"] != null ? json["ban_reason"].toString() : '',
    expireAt: DateTime.parse(json["expire_at"]),
    avgRating: json["avg_rating"] != null ? json["avg_rating"].toString() : '',
    autoPayment: json["auto_payment"] != null ? json["auto_payment"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    hotelSetting: json["hotel_setting"] == null ? null : json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"]),
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
  String? latitude;
  String? longitude;
  String? hotelAddress;
  String? countryId;
  String? cityId;
  String? locationId;
  String? taxName;
  String? taxPercentage;
  String? checkinTime;
  String? checkoutTime;
  String? upcomingCheckinDays;
  String? upcomingCheckoutDays;
  String? description;
  List<String>? keywords;
  String? cancellationPolicy;
  String? hasHotDeal;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  HotelSetting({
    this.id,
    this.ownerId,
    this.name,
    this.starRating,
    this.logo,
    this.latitude,
    this.longitude,
    this.hotelAddress,
    this.countryId,
    this.cityId,
    this.locationId,
    this.taxName,
    this.taxPercentage,
    this.checkinTime,
    this.checkoutTime,
    this.upcomingCheckinDays,
    this.upcomingCheckoutDays,
    this.description,
    this.keywords,
    this.cancellationPolicy,
    this.hasHotDeal,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory HotelSetting.fromJson(Map<String, dynamic> json) => HotelSetting(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    starRating: json["star_rating"] != null ? json["star_rating"].toString() : '',
    logo: json["logo"] != null ? json["logo"].toString() : '',
    latitude: json["latitude"] != null ? json["latitude"].toString() : '',
    longitude: json["longitude"] != null ? json["longitude"].toString() : '',
    hotelAddress: json["hotel_address"] != null ? json["hotel_address"].toString() : '',
    countryId: json["country_id"] != null ? json["country_id"].toString() : '',
    cityId: json["city_id"] != null ? json["city_id"].toString() : '',
    locationId: json["location_id"] != null ? json["location_id"].toString() : '',
    taxName: json["tax_name"] != null ? json["tax_name"].toString() : '',
    taxPercentage: json["tax_percentage"] != null ? json["tax_percentage"].toString() : '',
    checkinTime: json["checkin_time"] != null ? json["checkin_time"].toString() : '',
    checkoutTime: json["checkout_time"] != null ? json["checkout_time"].toString() : '',
    upcomingCheckinDays: json["upcoming_checkin_days"] != null ? json["upcoming_checkin_days"].toString() : '',
    upcomingCheckoutDays: json["upcoming_checkout_days"] != null ? json["upcoming_checkout_days"].toString() : '',
    description: json["description"]!= null ? json["description"].toString() : '',
    keywords: json["keywords"] != null ? List<String>.from(json["keywords"].map((x) => x)) : null,
    cancellationPolicy: json["cancellation_policy"] != null ? json["cancellation_policy"].toString() : '',
    hasHotDeal: json["has_hot_deal"] != null ? json["has_hot_deal"].toString() : '',
    createdAt: json["created_at"] ,
    updatedAt: json["updated_at"],
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
  );

}

class Link {
  String? url;
  String? label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] != null ? json["url"].toString() : '',
    label: json["label"] != null ? json["label"].toString() : '',
    active: json["active"],
  );
}


