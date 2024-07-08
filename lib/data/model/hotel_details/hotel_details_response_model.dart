// To parse this JSON data, do
//
//     final hotelDetailsReponseModel = hotelDetailsReponseModelFromJson(jsonString);

import 'dart:convert';
import 'package:booking_box/core/utils/my_images.dart';
import '../auth/login/login_response_model.dart';

HotelDetailsResponseModel hotelDetailsReponseModelFromJson(String str) => HotelDetailsResponseModel.fromJson(json.decode(str));


class HotelDetailsResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  HotelDetailsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory HotelDetailsResponseModel.fromJson(Map<String, dynamic> json) => HotelDetailsResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  String? roomTypeImageUrl;
  List<Ity>? facilities;
  List<Ity>? amenities;
  List<Complement>? complements;
  String? totalFacilities;
  Hotel? hotel;

  Data({
    this.roomTypeImageUrl,
    this.facilities,
    this.amenities,
    this.complements,
    this.totalFacilities,
    this.hotel,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    roomTypeImageUrl: json["room_type_image_url"] != null ? json["room_type_image_url"].toString() : '',
    facilities: json["facilities"] == null ? [] : List<Ity>.from(json["facilities"].map((x) => Ity.fromJson(x))),
    amenities: json["amenities"] == null ? [] : List<Ity>.from(json["amenities"].map((x) => Ity.fromJson(x))),
    totalFacilities: json["total_facilities"] != null ? json["total_facilities"].toString() : '',
    hotel: json["hotel"] == null ? null : Hotel.fromJson(json["hotel"]),
  );
}

class Ity {
  int? id;
  String? title;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  String? name;
  Pivot? pivot;

  Ity({
    this.id,
    this.title,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.name,
    this.pivot,
  });

  factory Ity.fromJson(Map<String, dynamic> json) => Ity(
    id: json["id"],
    title: json["title"] != null ? json["title"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );
}

class Pivot {
  String?roomTypeId;
  String? amenitiesId;
  String?createdAt;
  String?updatedAt;
  String? complementId;
  String? facilityId;

  Pivot({
    this.roomTypeId,
    this.amenitiesId,
    this.createdAt,
    this.updatedAt,
    this.complementId,
    this.facilityId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    amenitiesId: json["amenities_id"] != null ? json["amenities_id"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    complementId: json["complement_id"] != null ? json["complement_id"].toString() : '',
    facilityId: json["facility_id"] != null ? json["facility_id"].toString() : '',
  );
}

class Complement {
  int? id;
  String? ownerId;
  String? name;
  List<String>? item;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Complement({
    this.id,
    this.ownerId,
    this.name,
    this.item,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Complement.fromJson(Map<String, dynamic> json) => Complement(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    item: json["item"] == null ? [] : List<String>.from(json["item"].map((x) => x)),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );
}

class Hotel {
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
  String? verCodeSendAt;
  String? banReason;
  String? avgRating;
  DateTime? expireAt;
  String? createdAt;
  String? updatedAt;
  String? minFare;
  HotelSetting? hotelSetting;
  List<RoomType> roomTypes;
  List<CoverPhoto>? coverPhotos;

  Hotel({
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
    this.verCodeSendAt,
    this.banReason,
    this.avgRating,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
    this.hotelSetting,
    required this.roomTypes,
    this.coverPhotos,
    this.minFare
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json["id"],
    parentId: json["parent_id"].toString(),
    roleId: json["role_id"].toString(),
    firstname: json["firstname"] != null ? json["firstname"].toString() : '',
    lastname: json["lastname"] != null ? json["lastname"].toString() : '',
    username: json["username"] != null ? json["username"].toString() : '',
    email: json["email"] != null ? json["email"].toString() : '',
    image: json["image"] != null ? json["image"].toString():MyImages.defaultImageNetwork,
    countryCode: json["country_code"] != null ? json["country_code"].toString() : '',
    mobile: json["mobile"] != null ? json["mobile"].toString() : '',
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    isFeatured: json["is_featured"] != null ? json["is_featured"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    verCodeSendAt: json["ver_code_send_at"] != null ? json["ver_code_send_at"].toString() : '',
    banReason: json["ban_reason"] != null ? json["ban_reason"].toString() : '',
    avgRating: json["avg_rating"] != null ? json["avg_rating"].toString() : '',
    minFare: json["minimum_fare"] != null ? json["minimum_fare"].toString() : '',
    expireAt: DateTime.parse(json["expire_at"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    hotelSetting: json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"]),
    roomTypes: json["room_types"] == null ? [] : List<RoomType>.from(json["room_types"].map((x) => RoomType.fromJson(x))),
    coverPhotos: json["cover_photos"] == null ? [] : List<CoverPhoto>.from(json["cover_photos"].map((x) => CoverPhoto.fromJson(x))),
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
    city: json["city"] != null ? json["city"].toString() : '',
    state: json["state"] != null ? json["state"].toString() : '',
    zip: json["zip"] != null ? json["zip"].toString() : '',
    country: json["country"] != null ? json["country"].toString() : '',
  );
}

class CoverPhoto {
  int? id;
  String? ownerId;
  String? coverPhoto;
  String? createdAt;
  String? updatedAt;
  String? coverPhotoUrl;

  CoverPhoto({
    this.id,
    this.ownerId,
    this.coverPhoto,
    this.createdAt,
    this.updatedAt,
    this.coverPhotoUrl,
  });

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    coverPhoto: json["cover_photo"] != null ? json["cover_photo"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    coverPhotoUrl: json["cover_photo_url"] != null ? json["cover_photo_url"].toString() : '',
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
  String? address;
  String? destinationId;
  String? locationId;
  String? taxName;
  String? taxPercentage;
  String? checkinTime;
  String? checkoutTime;
  String? upcomingCheckinDays;
  String? upcomingCheckoutDays;
  String? description;
  String? cancellationPolicy;
  List<String>? keywords;
  String? hasHotDeal;
  String? createdAt;
  String? updatedAt;
  String? ImageUrl;

  HotelSetting({
    this.id,
    this.ownerId,
    this.name,
    this.starRating,
    this.logo,
    this.latitude,
    this.longitude,
    this.address,
    this.destinationId,
    this.locationId,
    this.taxName,
    this.taxPercentage,
    this.checkinTime,
    this.checkoutTime,
    this.upcomingCheckinDays,
    this.upcomingCheckoutDays,
    this.description,
    this.cancellationPolicy,
    this.keywords,
    this.hasHotDeal,
    this.createdAt,
    this.updatedAt,
    this.ImageUrl,
  });

  factory HotelSetting.fromJson(Map<String, dynamic> json) => HotelSetting(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    starRating: json["star_rating"] != null ? json["star_rating"].toString() : '',
    logo: json["logo"] != null ? json["logo"].toString() : MyImages.defaultImageNetwork,
    latitude: json["latitude"] != null ? json["latitude"].toString() : '',
    longitude: json["longitude"] != null ? json["longitude"].toString() : '',
    address: json["hotel_address"] != null ? json["hotel_address"].toString() : '',
    destinationId: json["destination_id"] != null ? json["destination_id"].toString() : '',
    locationId: json["location_id"] != null ? json["location_id"].toString() : '',
    taxName: json["tax_name"] != null ? json["tax_name"].toString() : '',
    taxPercentage: json["tax_percentage"] != null ? json["tax_percentage"].toString() : '',
    checkinTime: json["checkin_time"] != null ? json["checkin_time"].toString() : '00:00:00',
    checkoutTime: json["checkout_time"] != null ? json["checkout_time"].toString() : '00:00:00',
    upcomingCheckinDays: json["upcoming_checkin_days"] != null ? json["upcoming_checkin_days"].toString() : '',
    upcomingCheckoutDays: json["upcoming_checkout_days"] != null ? json["upcoming_checkout_days"].toString() : '',
    description: json["description"] != null ? json["description"].toString() : '',
    cancellationPolicy: json["cancellation_policy"] != null ? json["cancellation_policy"].toString() : '',
    keywords: json["keywords"] != null ?  List<String>.from(json["keywords"].map((x) => x)) : null,
    hasHotDeal: json["has_hot_deal"] != null ? json["has_hot_deal"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    ImageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
  );
}

class RoomType {
  String? roomId;
  String? ownerId;
  String? name;
  String? totalAdult;
  String? totalChild;
  String? fare;
  String? discountPercentage;
  List<String>? keywords;
  String? description;
  List<String>? beds;
  String? cancellationFee;
  String? cancellationPolicy;
  String? featureStatus;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? totalRooms;
  String? bookedRooms;
  String? availableRooms;
  String? totalCapacity;
  String? isFeatured;
  String? image;
  String? discountedFare;
  String? discount;
  List<Ity>? facilities;
  List<Ity>? amenities;
  List<Complement>? complements;
  List<Image>? images;
  String? bedInfo;
  int totalRoomCount;

  RoomType({
    this.roomId,
    this.ownerId,
    this.name,
    this.totalAdult,
    this.totalChild,
    this.fare,
    this.discountPercentage,
    this.keywords,
    this.description,
    this.beds,
    this.cancellationFee,
    this.cancellationPolicy,
    this.featureStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.totalRooms,
    this.bookedRooms,
    this.availableRooms,
    this.totalCapacity,
    this.isFeatured,
    this.image,
    this.discountedFare,
    this.discount,
    this.facilities,
    this.amenities,
    this.complements,
    this.images,
    this.bedInfo,
    this.totalRoomCount = 0
  });

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
    roomId: json["id"] != null ? json["id"].toString() : '-1',
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    totalAdult: json["total_adult"] != null ? json["total_adult"].toString() : '',
    totalChild: json["total_child"] != null ? json["total_child"].toString() : '',
    fare: json["fare"] != null ? json["fare"].toString() : '',
    discountPercentage: json["discount_percentage"] != null ? json["discount_percentage"].toString() : '',
    keywords: json["keywords"] != null ? List<String>.from(json["keywords"].map((x) => x)) : null,
    description: json["description"] != null ? json["description"].toString() : '',
    beds: json["keywords"] != null ? List<String>.from(json["beds"].map((x) => x)) : null,
    cancellationFee: json["cancellation_fee"] != null ? json["cancellation_fee"].toString() : '',
    cancellationPolicy: json["cancellation_policy"] != null ? json["cancellation_policy"].toString() : '',
    featureStatus: json["feature_status"] != null ? json["feature_status"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    totalRooms: json["total_rooms"] != null ? json["total_rooms"].toString() : '',
    bookedRooms: json["booked_rooms"] != null ? json["booked_rooms"].toString() : '',
    availableRooms: json["available_rooms"] != null ? json["available_rooms"].toString() : '',
    totalCapacity: json["total_capacity"] != null ? json["total_capacity"].toString() : '',
    isFeatured: json["is_featured"] != null ? json["is_featured"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    discountedFare: json["discounted_fare"] != null ? json["discounted_fare"].toString() : '',
    discount: json["discount"] != null ? json["discount"].toString() : '',
    facilities: json["facilities"] == null ? [] : List<Ity>.from(json["facilities"].map((x) => Ity.fromJson(x))),
    amenities: json["amenities"] == null ? [] : List<Ity>.from(json["amenities"].map((x) => Ity.fromJson(x))),
    images: json["images"] != null ? List<Image>.from(json["images"].map((x) => Image.fromJson(x))) : null,
  );

  setBedInfo(String info){
    bedInfo = info;
  }

  increaseTotalRoomCount(){
    totalRoomCount++;
  }

  decreaseTotalRoomCount(){
    totalRoomCount--;
  }

}

class Image {
  int? id;
  String? roomTypeId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Image({
    this.id,
    this.roomTypeId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}