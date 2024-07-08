

import 'dart:convert';
import '../auth/login/login_response_model.dart';

BookingHistoryResponseModel bookingHistoryResponseModelFromJson(String str) => BookingHistoryResponseModel.fromJson(json.decode(str));

class BookingHistoryResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  BookingHistoryResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory BookingHistoryResponseModel.fromJson(Map<String, dynamic> json) => BookingHistoryResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: Message.fromJson(json["message"]),
    data:json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Bookings? bookings;

  Data({
    required this.bookings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookings: json["bookings"] == null ? null : Bookings.fromJson(json["bookings"]),
  );
}

class Bookings {
  List<Datum>? data;
  String? nextPageUrl;
  String? total;

  Bookings({
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    data:json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    nextPageUrl: json["next_page_url"] != null ? json["next_page_url"].toString() : '',
    total: json["total"] != null ? json["total"].toString() : '',
  );
}

class Datum {
  String? id;
  String? ownerId;
  String? bookingNumber;
  String? userId;
  String? guestId;
  String? checkIn;
  String? checkOut;
  ContactInfo? contactInfo;
  String? totalAdult;
  String? totalChild;
  String? totalDiscount;
  String? taxCharge;
  String? bookingFare;
  String? serviceCost;
  String? extraCharge;
  String? extraChargeSubtracted;
  String? paidAmount;
  String? cancellationFee;
  String? refundedAmount;
  String? keyStatus;
  String? status;
  String? checkedInAt;
  String? checkedOutAt;
  String? createdAt;
  String? updatedAt;
  String? totalAmount;
  String? dueAmount;
  String? confirmationAmount;
  String? confirmationDeadline;
  List<BookedRoom>? bookedRooms;
  Owner? owner;

  Datum({
    this.id,
    this.ownerId,
    this.bookingNumber,
    this.userId,
    this.guestId,
    this.checkIn,
    this.checkOut,
    this.contactInfo,
    this.totalAdult,
    this.totalChild,
    this.totalDiscount,
    this.taxCharge,
    this.bookingFare,
    this.serviceCost,
    this.extraCharge,
    this.extraChargeSubtracted,
    this.paidAmount,
    this.cancellationFee,
    this.refundedAmount,
    this.keyStatus,
    this.status,
    this.checkedInAt,
    this.checkedOutAt,
    this.createdAt,
    this.updatedAt,
    this.totalAmount,
    this.dueAmount,
    this.bookedRooms,
    this.confirmationAmount,
    this.confirmationDeadline,
    this.owner,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] != null ? json["id"].toString() : '-1',
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    bookingNumber: json["booking_number"] != null ? json["booking_number"].toString() : '',
    userId: json["user_id"] != null ? json["user_id"].toString() : '',
    guestId: json["guest_id"] != null ? json["guest_id"].toString() : '',
    checkIn: json["check_in"] != null ? json["check_in"].toString() : '',
    checkOut: json["check_out"] != null ? json["check_out"].toString() : '',
    contactInfo: json["contact_info"] == null ? null : ContactInfo.fromJson(json["contact_info"]),
    totalAdult: json["total_adult"] != null ? json["total_adult"].toString() : '',
    totalChild: json["total_child"] != null ? json["total_child"].toString() : '',
    totalDiscount: json["total_discount"] != null ? json["total_discount"].toString() : '',
    taxCharge: json["tax_charge"] != null ? json["tax_charge"].toString() : '',
    bookingFare: json["booking_fare"] != null ? json["booking_fare"].toString() : '',
    serviceCost: json["service_cost"] != null ? json["service_cost"].toString() : '',
    extraCharge: json["extra_charge"] != null ? json["extra_charge"].toString() : '',
    extraChargeSubtracted: json["extra_charge_subtracted"] != null ? json["extra_charge_subtracted"].toString() : '',
    paidAmount: json["paid_amount"] != null ? json["paid_amount"].toString() : '0.0',
    cancellationFee: json["cancellation_fee"] != null ? json["cancellation_fee"].toString() : '',
    refundedAmount: json["refunded_amount"] != null ? json["refunded_amount"].toString() : '',
    keyStatus: json["key_status"] != null ? json["key_status"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    checkedInAt: json["checked_in_at"] != null ? json["checked_in_at"].toString() : '',
    checkedOutAt: json["checked_out_at"] != null ? json["checked_out_at"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : '',
    dueAmount: json["due_amount"] != null ? json["due_amount"].toString() : '',
    confirmationAmount: json["confirmation_amount"] != null ? json["confirmation_amount"].toString() : '0.0',
    confirmationDeadline: json["confirmation_deadline"] != null ? json["confirmation_deadline"].toString() : '',
    bookedRooms:json["booked_rooms"] == null ? [] : List<BookedRoom>.from(json["booked_rooms"].map((x) => BookedRoom.fromJson(x))),
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
  );
}

class BookedRoom {
  String? id;
  String? bookingId;
  String? roomTypeId;
  String? roomId;
  String? roomNumber;
  String? bookedFor;
  String? fare;
  String? discount;
  String? taxCharge;
  String? cancellationFee;
  String? status;
  String? createdAt;
  String? updatedAt;
  Room? room;

  BookedRoom({
    this.id,
    this.bookingId,
    this.roomTypeId,
    this.roomId,
    this.roomNumber,
    this.bookedFor,
    this.fare,
    this.discount,
    this.taxCharge,
    this.cancellationFee,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.room,
  });

  factory BookedRoom.fromJson(Map<String, dynamic> json) => BookedRoom(
    id: json["id"] != null ? json["id"].toString() : '',
    bookingId: json["booking_id"] != null ? json["booking_id"].toString() : '',
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    roomId: json["room_id"] != null ? json["room_id"].toString() : '',
    roomNumber: json["room_number"] != null ? json["room_number"].toString() : '',
    bookedFor: json["booked_for"] != null ? json["booked_for"].toString() : '',
    fare: json["fare"] != null ? json["fare"].toString() : '',
    discount: json["discount"] != null ? json["discount"].toString() : '',
    taxCharge: json["tax_charge"] != null ? json["tax_charge"].toString() : '',
    cancellationFee: json["cancellation_fee"] != null ? json["cancellation_fee"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    room: json["room"] == null ? null : Room.fromJson(json["room"]),
  );
}

class Room {
  String? id;
  String? ownerId;
  String? roomTypeId;
  String? roomNumber;
  String? status;
  String? createdAt;
  String? updatedAt;
  RoomType? roomType;

  Room({
    this.id,
    this.ownerId,
    this.roomTypeId,
    this.roomNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.roomType,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"]  != null ? json["id"].toString() : '',
    ownerId: json["owner_id"]  != null ? json["owner_id"].toString() : '',
    roomTypeId: json["room_type_id"]  != null ? json["room_type_id"].toString() : '',
    roomNumber: json["room_number"]  != null ? json["room_number"].toString() : '',
    status: json["status"]  != null ? json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    roomType: json["room_type"] == null ? null : RoomType.fromJson(json["room_type"]),
  );
}

class RoomType {
  String? id;
  String? name;
  String? image;
  String? discountedFare;
  String? discount;
  List<Image>? images;

  RoomType({
    this.id,
    this.name,
    this.image,
    this.discountedFare,
    this.discount,
    this.images,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
    id: json["id"]  != null ? json["id"].toString() : '',
    name: json["name"]  != null ? json["name"].toString() : '',
    image: json["image"]  != null ? json["image"].toString() : '',
    discountedFare: json["discounted_fare"]  != null ? json["discounted_fare"].toString() : '',
    discount: json["discount"]  != null ? json["id"].toString() : '',
    images: json["images"] == null ? [] : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );
}

class Image {
  String? id;
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
    id: json["id"] != null ? json["id"].toString() : '',
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class ContactInfo {
  String? name;
  String? phone;

  ContactInfo({
    this.name,
    this.phone,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
    name: json["name"]  != null ? json["name"].toString() : '',
    phone: json["phone"]  != null ? json["phone"].toString() : '',
  );
}

class Owner {
  String? id;
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
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"] != null ? json["id"].toString() : '',
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
    isFeatured: json["is_featured"].toString(),
    status: json["status"].toString(),
    ev: json["ev"].toString(),
    sv: json["sv"].toString(),
    verCodeSendAt: json["ver_code_send_at"] != null ? json["ver_code_send_at"].toString() : '',
    ts: json["ts"].toString(),
    tv: json["tv"].toString(),
    tsc: json["tsc"].toString(),
    formData: json["form_data"] != null ? json["form_data"].toString() : '',
    banReason: json["ban_reason"] != null ? json["ban_reason"].toString() : '',
    expireAt: DateTime.parse(json["expire_at"]),
    avgRating: json["avg_rating"] != null ? json["avg_rating"].toString() : '',
    autoPayment: json["auto_payment"] != null ? json["auto_payment"].toString() : '',
    createdAt: json["created_at"].toString(),
    updatedAt: json["updated_at"].toString(),
    hotelSetting:json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"]),
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
  String? ImageUrl;

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
    this.ImageUrl,
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
    description: json["description"] != null ? json["description"].toString() : '',
    keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"].map((x) => x)),
    cancellationPolicy: json["cancellation_policy"] != null ? json["cancellation_policy"].toString() : '',
    hasHotDeal: json["has_hot_deal"] != null ? json["has_hot_deal"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    ImageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
  );
}



