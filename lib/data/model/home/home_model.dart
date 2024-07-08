import 'dart:convert';
import '../auth/login/login_response_model.dart';

HomeResponseModel homeResponseModelFromJson(String str) => HomeResponseModel.fromJson(json.decode(str));

class HomeResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  HomeResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}
class Data {
  List<Ad>? ads;
  List<Owner> ? owners;
  List<PopularCity> ? popularCities;
  List<Owner>? featuredOwners;
  String? totalPopularHotels;
  String? totalPopularCities;
  String? totalFeaturedOwners;

  Data({
    this.ads,
    this.owners,
    this.popularCities,
    this.featuredOwners,
    this.totalPopularHotels,
    this.totalPopularCities,
    this.totalFeaturedOwners
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ads: json["ads"] == null ? [] : List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
    owners: json["owners"] == null ? [] : List<Owner>.from(json["owners"].map((x) => Owner.fromJson(x))),
    popularCities: json["popular_cities"] == null ? [] : List<PopularCity>.from(json["popular_cities"].map((x) => PopularCity.fromJson(x))),
    featuredOwners: json["featured_owners"] == null ? [] : List<Owner>.from(json["featured_owners"].map((x) => Owner.fromJson(x))),
    totalPopularHotels: json["total_owners"] != null ? json["total_owners"].toString() : '',
    totalPopularCities: json["total_popular_cities"] != null ? json["total_popular_cities"].toString() : '',
    totalFeaturedOwners: json["total_featured_owners"] != null ? json["total_featured_owners"].toString() : '',
  );
}

class Ad {
  int? id;
  String? ownerId;
  String? image;
  DateTime? endDate;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  String? url;

  Ad({
    this.id,
    this.ownerId,
    this.image,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.url
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    endDate: DateTime.parse(json["end_date"]),
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
    url: json["url"] != null ? json["url"].toString() : '',
  );
}

class Owner {
  int? id;
  String? parentId;
  String? roleId;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? image;
  String? countryCode;
  String? mobile;
  Address? address;
  String? isFeatured;
  String? status;
  String? ev;
  String? sv;
  String? verCodeSendAt;
  String? ts;
  String? tv;
  String? tsc;
  String? formData;
  String? banReason;
  DateTime? expireAt;
  String? avgRating;
  String? autoPayment;
  String? createdAt;
  String? updatedAt;
  HotelSetting? hotelSetting;
  String? totalBookings;
  String? minimumFare;

  Owner({
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
    this.formData,
    this.banReason,
    this.expireAt,
    this.avgRating,
    this.autoPayment,
    this.createdAt,
    this.updatedAt,
    this.hotelSetting,
    this.totalBookings,
    this.minimumFare,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    parentId: json["parent_id"] != null ? json["parent_id"].toString() : '',
    roleId: json["role_id"] != null ? json["role_id"].toString() : '',
    firstname: json["firstname"] != null ? json["firstname"].toString() : '',
    lastname: json["lastname"] != null ? json["lastname"].toString() : '',
    username: json["username"] != null ? json["username"].toString() : '',
    email: json["email"] != null ? json["email"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    countryCode: json["country_code"] != null ? json["country_code"].toString() : '',
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
    formData: json["form_data"] != null ? json["form_data"].toString() : '',
    banReason: json["ban_reason"] != null ? json["ban_reason"].toString() : '',
    avgRating: json["avg_rating"] != null ? json["avg_rating"].toString() : '',
    autoPayment: json["auto_payment"] != null ? json["auto_payment"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    hotelSetting: json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"]),
    totalBookings: json["total_bookings"] != null ? json["total_bookings"].toString() : '',
    minimumFare: json["minimum_fare"] != null ? json["minimum_fare"].toString() : '',
  );

}

class Address {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"] != null ? json["address"].toString() : '',
    city: json["city"]!= null ? json["city"].toString() : '',
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
    logo: json["logo"]!= null ? json["logo"].toString() : '',
    latitude: json["latitude"]!= null ? json["latitude"].toString() : '',
    longitude: json["longitude"] != null ? json["longitude"].toString() : '',
    hotelAddress: json["hotel_address"] != null ? json["hotel_address"].toString() : '',
    countryId: json["country_id"] != null ? json["country_id"].toString() : '',
    cityId: json["city_id"] != null ? json["city_id"].toString() : '',
    locationId: json["location_id"] != null ? json["location_id"].toString() : '',
    taxName: json["tax_name"] != null ? json["tax_name"].toString() : '',
    taxPercentage: json["tax_percentage"] != null ? json["tax_percentage"].toString() : '',
    checkinTime: json["checkin_time"] != null ? json["checkin_time"].toString() : '',
    checkoutTime: json["checkout_time"]  != null ? json["checkout_time"].toString() : '',
    upcomingCheckinDays: json["upcoming_checkin_days"]  != null ? json["upcoming_checkin_days"].toString() : '',
    upcomingCheckoutDays: json["upcoming_checkout_days"]  != null ? json["upcoming_checkout_days"].toString() : '',
    description: json["description"]  != null ? json["description"].toString() : '',
    keywords: json["keywords"] != null ? List<String>.from(json["keywords"].map((x) => x)) : null,
    cancellationPolicy: json["cancellation_policy"] != null ? json["cancellation_policy"].toString() : '',
    hasHotDeal: json["has_hot_deal"]  != null ? json["has_hot_deal"].toString() : '',
    createdAt: json["created_at"]  != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"]  != null ? json["updated_at"].toString() : '',
    imageUrl: json["image_url"]  != null ? json["image_url"].toString() : '',
  );
}

class PopularCity {
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

  PopularCity({
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

  factory PopularCity.fromJson(Map<String, dynamic> json) => PopularCity(
    id: json["id"],
    countryId: json["country_id"] != null ? json["country_id"].toString() : '',
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
    name: json["name"] != null ? json["name"].toString() : '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
