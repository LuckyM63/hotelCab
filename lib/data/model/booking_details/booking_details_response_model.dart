// To parse this JSON data, do
//
//     final bookingDetailsResponseModel = bookingDetailsResponseModelFromJson(jsonString);

import 'dart:convert';
import '../auth/login/login_response_model.dart';

BookingDetailsResponseModel bookingDetailsResponseModelFromJson(String str) => BookingDetailsResponseModel.fromJson(json.decode(str));

class BookingDetailsResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  BookingDetailsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory BookingDetailsResponseModel.fromJson(Map<String, dynamic> json) => BookingDetailsResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Booking? booking;
  List<BookedRooms>? bookedRooms;
  PaymentInfo? paymentInfo;

  Data({
    this.booking,
    this.bookedRooms,
    this.paymentInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(

    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
    bookedRooms: json["bookedRooms"] == null ? null : (json['bookedRooms'] as Map<String, dynamic>?)?.entries.map(
          (entry) {
        return BookedRooms(
          date: entry.key,
          rooms: List<Rooms>.from(entry.value.map((room) => Rooms.fromJson(room))),
        );
      },
    ).toList(),
    paymentInfo: json["paymentInfo"] == null ? null : PaymentInfo.fromJson(json["paymentInfo"]),
  );
}

class BookedRooms {
  String? date;
  List<Rooms>? rooms;

  BookedRooms({
    this.date,
    this.rooms,
  });
}


class Rooms {
  int? id;
  String? bookingId;
  String? roomTypeId;
  String? roomId;
  String? roomNumber;
  DateTime? bookedFor;
  String? fare;
  String? discount;
  String? taxCharge;
  String? cancellationFee;
  String? status;
  String? createdAt;
  String? updatedAt;
  Room? room;
  RoomType? roomType;

  Rooms({
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
    this.roomType,
  });

  factory Rooms.fromJson(Map<String, dynamic> json) => Rooms(
    id: json["id"],
    bookingId: json["booking_id"] != null ? json["booking_id"].toString() : '',
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    roomId: json["room_id"] != null ? json["room_id"].toString() : '',
    roomNumber: json["room_number"] != null ? json["room_number"].toString() : '',
    bookedFor: json["booked_for"] == null ? null : DateTime.parse(json["booked_for"]),
    fare: json["fare"] != null ? json["fare"].toString() : '',
    discount: json["discount"] != null ? json["discount"].toString() : '',
    taxCharge: json["tax_charge"] != null ? json["tax_charge"].toString() : '',
    cancellationFee: json["cancellation_fee"] != null ? json["cancellation_fee"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    room: json["room"] == null ? null : Room.fromJson(json["room"]),
    roomType: json["room_type"] == null ? null : RoomType.fromJson(json["room_type"]),
  );
}

class Room {
  int? id;
  String? ownerId;
  String? roomTypeId;
  String? roomNumber;
  String? status;
  String? createdAt;
  String? updatedAt;

  Room({
    this.id,
    this.ownerId,
    this.roomTypeId,
    this.roomNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    roomTypeId: json["room_type_id"] != null ? json["room_type_id"].toString() : '',
    roomNumber: json["room_number"] != null ? json["room_number"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class RoomType {
  int? id;
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
    id: json["id"],
    name: json["name"] != null ? json["name"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    discountedFare: json["discounted_fare"] != null ? json["discounted_fare"].toString() : '',
    discount: json["discount"] != null ? json["discount"].toString() : '',
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
  );
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
    roomTypeId: json["room_type_id"] != null ?  json["room_type_id"].toString() : "",
    image: json["image"] != null ? json["image"].toString() : "",
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class Booking {
  int? id;
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
  String? confirmationAmount;
  DateTime? confirmationDeadline;
  String? status;
  String? checkedInAt;
  String? checkedOutAt;
  String? createdAt;
  String? updatedAt;
  String? totalAmount;
  String? dueAmount;
  String? taxPercent;
  List<dynamic>? usedExtraService;
  List<Payment>? payments;
  String? guest;
  Owner? owner;
  List<Rooms>? bookedRooms;

  Booking({
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
    this.confirmationAmount,
    this.confirmationDeadline,
    this.status,
    this.checkedInAt,
    this.checkedOutAt,
    this.createdAt,
    this.updatedAt,
    this.totalAmount,
    this.dueAmount,
    this.taxPercent,
    this.usedExtraService,
    this.payments,
    this.guest,
    this.owner,
    this.bookedRooms,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
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
    paidAmount: json["paid_amount"] != null ? json["paid_amount"].toString() : '',
    cancellationFee: json["cancellation_fee"] != null ? json["cancellation_fee"].toString() : '',
    refundedAmount: json["refunded_amount"] != null ? json["refunded_amount"].toString() : '',
    keyStatus: json["key_status"] != null ? json["key_status"].toString() : '',
    confirmationAmount: json["confirmation_amount"] != null ? json["confirmation_amount"].toString() : '',
    confirmationDeadline: json["confirmation_deadline"] == null ? null : DateTime.parse(json["confirmation_deadline"]),
    status: json["status"] != null ? json["status"].toString() : '',
    checkedInAt: json["checked_in_at"] != null ? json["checked_in_at"].toString() : '',
    checkedOutAt: json["checked_out_at"] != null ? json["checked_out_at"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"]  != null ? json["updated_at"].toString() : '',
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : '',
    dueAmount: json["due_amount"] != null ? json["due_amount"].toString() : '',
    taxPercent: json["tax_percent"] != null ? json["tax_percent"].toString() : '',
    usedExtraService: json["used_extra_service"] == null ? [] : List<dynamic>.from(json["used_extra_service"]!.map((x) => x)),
    payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
    guest: json["guest"] != null ? json["guest"].toString() : '',
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    bookedRooms: json["booked_rooms"] == null ? [] : List<Rooms>.from(json["booked_rooms"]!.map((x) => Rooms.fromJson(x))),
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
    name: json["name"] != null ? json["name"].toString() : "",
    phone: json["phone"] != null ? json["phone"].toString() : "",
  );
}

class Owner {
  int? id;
  String? firstname;
  HotelSetting? hotelSetting;

  Owner({
    this.id,
    this.firstname,
    this.hotelSetting,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    firstname: json["firstname"] != null ? json["firstname"].toString() : "",
    hotelSetting: json["hotel_setting"] == null ? null : HotelSetting.fromJson(json["hotel_setting"]),
  );
}

class HotelSetting {
  int? id;
  String? ownerId;
  String? locationId;
  String? cityId;
  String? countryId;
  String? name;
  String? logo;
  String? taxName;
  String? ImageUrl;
  Location? location;
  City? city;
  Country? country;

  HotelSetting({
    this.id,
    this.ownerId,
    this.locationId,
    this.cityId,
    this.countryId,
    this.name,
    this.logo,
    this.taxName,
    this.ImageUrl,
    this.location,
    this.city,
    this.country,
  });

  factory HotelSetting.fromJson(Map<String, dynamic> json) => HotelSetting(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    locationId: json["location_id"] != null ? json["location_id"].toString() : '',
    cityId: json["city_id"] != null ? json["city_id"].toString() : '',
    countryId: json["country_id"] != null ? json["country_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    logo: json["logo"] != null ? json["logo"].toString() : '',
    taxName: json["tax_name"] != null ? json["tax_name"].toString() : '',
    ImageUrl: json["image_url"] != null ? json["image_url"].toString() : '',
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
  );
}

class City {
  int? id;
  String? countryId;
  String? name;
  String? image;
  String? isPopular;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  City({
    this.id,
    this.countryId,
    this.name,
    this.image,
    this.isPopular,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    countryId: json["country_id"] != null ? json["country_id"].toString() : "",
    name: json["name"] != null ? json["name"].toString() : "",
    image: json["image"] != null ? json["image"].toString() : "",
    isPopular: json["is_popular"].toString(),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    imageUrl: json["image_url"] != null ? json["image_url"].toString() : "",
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
    id: json["id"],
    name: json["name"] != null ? json["name"].toString() : "",
    code: json["code"] != null ? json["code"].toString() : "",
    dialCode: json["dial_code"] != null ? json["dial_code"].toString() : "",
    status: json["status"].toString(),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class Location {
  int? id;
  String? cityId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Location({
    this.id,
    this.cityId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    cityId: json["city_id"] != null ? json["city_id"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}

class Payment {
  int? id;
  String? ownerId;
  String? bookingId;
  String? amount;
  String? type;
  String? paymentSystem;
  String? actionBy;
  String? createdAt;
  String? updatedAt;

  Payment({
    this.id,
    this.ownerId,
    this.bookingId,
    this.amount,
    this.type,
    this.paymentSystem,
    this.actionBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"] ,
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    bookingId: json["booking_id"] != null ? json["booking_id"].toString() : '',
    amount: json["amount"] != null ? json["amount"].toString() : '',
    type: json["type"] != null ? json["type"].toString() : '',
    paymentSystem: json["payment_system"] != null ? json["payment_system"].toString() : '',
    actionBy: json["action_by"] != null ? json["action_by"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
  );
}

class PaymentInfo {
  String? subtotal;
  String? totalAmount;
  String? canceledFare;
  String? canceledTaxCharge;
  String? paymentReceived;
  String? refunded;

  PaymentInfo({
    this.subtotal,
    this.totalAmount,
    this.canceledFare,
    this.canceledTaxCharge,
    this.paymentReceived,
    this.refunded,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
    subtotal: json["subtotal"] != null ? json["subtotal"].toString() : '',
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : '',
    canceledFare: json["canceled_fare"] != null ? json["canceled_fare"].toString() : '',
    canceledTaxCharge: json["canceled_tax_charge"] != null ? json["canceled_tax_charge"].toString() : '',
    paymentReceived: json["payment_received"] != null ? json["payment_received"].toString() : '',
    refunded: json["refunded"] != null ? json["refunded"].toString() : '',
  );
}

