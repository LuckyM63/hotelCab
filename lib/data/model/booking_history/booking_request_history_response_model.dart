import 'dart:convert';
import '../auth/login/login_response_model.dart';
import '../booking_details/booking_details_response_model.dart';

BookingRequestHistoryResponseModel bookingRequestHistoryResponseModelFromJson(String str) => BookingRequestHistoryResponseModel.fromJson(json.decode(str));

String bookingRequestHistoryResponseModelToJson(BookingRequestHistoryResponseModel data) => json.encode(data.toJson());

class BookingRequestHistoryResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  BookingRequestHistoryResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory BookingRequestHistoryResponseModel.fromJson(Map<String, dynamic> json) => BookingRequestHistoryResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null :  Message.fromJson(json["message"]),
    data:json["data"] == null ? null :  Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "status": status,
  };
}

class Data {
  List<BookingRequest>? bookingRequests;

  Data({
    this.bookingRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingRequests: json["booking_requests"] == null ? [] : List<BookingRequest>.from(json["booking_requests"].map((x) => BookingRequest.fromJson(x))),
  );
}

class BookingRequest {
  int? id;
  String? ownerId;
  String? bookingId;
  String? userId;
  String? totalAdult;
  String? totalChild;
  String? checkIn;
  String? checkOut;
  String? totalAmount;
  ContactInfo? contactInfo;
  String? status;
  String? createdAt;
  String? updatedAt;
  Owner? owner;
  List<BookingRequestDetail>? bookingRequestDetails;

  BookingRequest({
    this.id,
    this.ownerId,
    this.bookingId,
    this.userId,
    this.totalAdult,
    this.totalChild,
    this.checkIn,
    this.checkOut,
    this.totalAmount,
    this.contactInfo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.bookingRequestDetails,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    bookingId: json["booking_id"] != null ? json["booking_id"].toString() : '',
    userId: json["user_id"] != null ? json["user_id"].toString() : '',
    totalAdult: json["total_adult"] != null ? json["total_adult"].toString() : '',
    totalChild: json["total_child"] != null ? json["total_child"].toString() : '',
    checkIn: json["check_in"] != null ? json["check_in"].toString() : '',
    checkOut: json["check_out"] != null ? json["check_out"].toString() : '',
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : '',
    contactInfo: json["contact_info"] == null ? null : ContactInfo.fromJson(json["contact_info"]),
    status: json["status"] != null ? json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    bookingRequestDetails: json["booking_request_details"] == null ? [] : List<BookingRequestDetail>.from(json["booking_request_details"]!.map((x) => BookingRequestDetail.fromJson(x))),
  );
}

class BookingRequestDetail {
  int? id;
  String? bookingRequestId;
  String? roomTypeId;
  String? numberOfRooms;
  String? unitFare;
  String? taxCharge;
  String? discount;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  RoomType? roomType;

  BookingRequestDetail({
    this.id,
    this.bookingRequestId,
    this.roomTypeId,
    this.numberOfRooms,
    this.unitFare,
    this.taxCharge,
    this.discount,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.roomType,
  });

  factory BookingRequestDetail.fromJson(Map<String, dynamic> json) => BookingRequestDetail(
    id: json["id"],
    bookingRequestId: json["booking_request_id"] != null ? json["booking_request_id"].toString() : '',
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    numberOfRooms: json["number_of_rooms"] != null ? json["number_of_rooms"].toString() : '',
    unitFare: json["unit_fare"] != null ? json["unit_fare"].toString() : '',
    taxCharge: json["tax_charge"] != null ? json["tax_charge"].toString() : '',
    discount: json["discount"] != null ? json["discount"].toString() : '',
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    roomType: json["room_type"] == null ? null : RoomType.fromJson(json["room_type"]),
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
    name: json["name"] != null ? json["name"].toString() : '',
    phone: json["phone"] != null ? json["name"].toString() : '',
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
    this.avgRating,
    this.autoPayment,
    this.createdAt,
    this.updatedAt,
    this.hotelSetting,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    parentId: json["parent_id"].toString(),
    roleId: json["role_id"].toString(),
    firstname: json["firstname"]  != null ? json["firstname"].toString() : '',
    lastname: json["lastname"] != null ? json["lastname"].toString() : '',
    username: json["username"]  != null ? json["username"].toString() : '',
    email: json["email"]  != null ? json["email"].toString() : '',
    image: json["image"]  != null ? json["image"].toString() : '',
    countryCode: json["country_code"]  != null ? json["country_code"].toString() : '',
    mobile: json["mobile"]  != null ? json["mobile"].toString() : '',
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
    banReason: json["ban_reason"]  != null ? json["ban_reason"].toString() : '',
    avgRating: json["avg_rating"]  != null ? json["avg_rating"].toString() : '',
    autoPayment: json["auto_payment"] != null ? json["auto_payment"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    hotelSetting: json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"]),
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
  String? logo;
  String? imageUrl;

  HotelSetting({
    this.id,
    this.ownerId,
    this.name,
    this.logo,
    this.imageUrl,
  });

  factory HotelSetting.fromJson(Map<String, dynamic> json) => HotelSetting(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    logo: json["logo"] != null ? json["logo"].toString() : '',
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
  );
}


