
import 'dart:convert';

DepositMethodResponseModel depositMethodResponseModelFromJson(String str) => DepositMethodResponseModel.fromJson(json.decode(str));

String depositMethodResponseModelToJson(DepositMethodResponseModel data) => json.encode(data.toJson());

class DepositMethodResponseModel {
  String? remark;
  Message? message;
  Data? data;

  DepositMethodResponseModel({
    this.remark,
    this.message,
    this.data,
  });

  factory DepositMethodResponseModel.fromJson(Map<String, dynamic> json) => DepositMethodResponseModel(
    remark: json["remark"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "message": message?.toJson(),
    "data": data?.toJson(),
  };
}

class Data {
  Booking? booking;
  List<MethodElement>? methods;

  Data({
    this.booking,
    this.methods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
    methods: json["methods"] == null ? [] : List<MethodElement>.from(json["methods"]!.map((x) => MethodElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "booking": booking?.toJson(),
    "methods": methods == null ? [] : List<dynamic>.from(methods!.map((x) => x.toJson())),
  };
}

class Booking {
  String? id;
  String? ownerId;
  String? bookingNumber;
  String? userId;
  String? guestId;
  DateTime? checkIn;
  DateTime? checkOut;
  ContactInfo? contactInfo;
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
  dynamic checkedInAt;
  dynamic checkedOutAt;
  String? createdAt;
  String? updatedAt;
  String? totalAmount;
  String? dueAmount;

  Booking({
    this.id,
    this.ownerId,
    this.bookingNumber,
    this.userId,
    this.guestId,
    this.checkIn,
    this.checkOut,
    this.contactInfo,
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
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"] != null ? json["id"].toString() : '',
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    bookingNumber: json["booking_number"] != null ? json["booking_number"].toString() : '',
    userId: json["user_id"] != null ? json["user_id"].toString() : '',
    guestId: json["guest_id"] != null ? json["guest_id"].toString() : '',
    checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
    checkOut: json["check_out"] == null ? null : DateTime.parse(json["check_out"]),
    contactInfo: json["contact_info"] == null ? null : ContactInfo.fromJson(json["contact_info"]),
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
    status: json["status"] != null ? json["status"].toString() : '',
    checkedInAt: json["checked_in_at"] != null ? json["checked_in_at"].toString() : '',
    checkedOutAt: json["checked_out_at"] != null ? json["checked_out_at"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : '',
    dueAmount: json["due_amount"] != null ? json["due_amount"].toString() : '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "booking_number": bookingNumber,
    "user_id": userId,
    "guest_id": guestId,
    "check_in": "${checkIn!.year.toString().padLeft(4, '0')}-${checkIn!.month.toString().padLeft(2, '0')}-${checkIn!.day.toString().padLeft(2, '0')}",
    "check_out": "${checkOut!.year.toString().padLeft(4, '0')}-${checkOut!.month.toString().padLeft(2, '0')}-${checkOut!.day.toString().padLeft(2, '0')}",
    "contact_info": contactInfo?.toJson(),
    "total_discount": totalDiscount,
    "tax_charge": taxCharge,
    "booking_fare": bookingFare,
    "service_cost": serviceCost,
    "extra_charge": extraCharge,
    "extra_charge_subtracted": extraChargeSubtracted,
    "paid_amount": paidAmount,
    "cancellation_fee": cancellationFee,
    "refunded_amount": refundedAmount,
    "key_status": keyStatus,
    "status": status,
    "checked_in_at": checkedInAt,
    "checked_out_at": checkedOutAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "total_amount": totalAmount,
    "due_amount": dueAmount,
  };
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
    phone: json["phone"] != null ? json["phone"].toString() : '',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}

class MethodElement {
  int? id;
  String? name;
  String? currency;
  String? symbol;
  String? methodCode;
  String? gatewayAlias;
  String? minAmount;
  String? maxAmount;
  String? percentCharge;
  String? fixedCharge;
  String? rate;
  dynamic image;
  String? createdAt;
  String? updatedAt;
  MethodMethod? method;

  MethodElement({
    this.id,
    this.name,
    this.currency,
    this.symbol,
    this.methodCode,
    this.gatewayAlias,
    this.minAmount,
    this.maxAmount,
    this.percentCharge,
    this.fixedCharge,
    this.rate,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.method,
  });

  factory MethodElement.fromJson(Map<String, dynamic> json) => MethodElement(
    id: json["id"],
    name: json["name"] != null ? json["name"].toString() : '',
    currency: json["currency"] != null ? json["currency"].toString() : '',
    symbol: json["symbol"] != null ? json["symbol"].toString() : '',
    methodCode: json["method_code"] != null ? json["method_code"].toString() : '',
    gatewayAlias: json["gateway_alias"] != null ? json["gateway_alias"].toString() : '',
    minAmount: json["min_amount"] != null ? json["min_amount"].toString() : '',
    maxAmount: json["max_amount"] != null ? json["max_amount"].toString() : '',
    percentCharge: json["percent_charge"] != null ? json["percent_charge"].toString() : '',
    fixedCharge: json["fixed_charge"] != null ? json["fixed_charge"].toString() : '',
    rate: json["rate"] != null ? json["rate"].toString() : '',
    image: json["image"] != null ? json["image"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    method: json["method"] == null ? null : MethodMethod.fromJson(json["method"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "currency": currency,
    "symbol": symbol,
    "method_code": methodCode,
    "gateway_alias": gatewayAlias,
    "min_amount": minAmount,
    "max_amount": maxAmount,
    "percent_charge": percentCharge,
    "fixed_charge": fixedCharge,
    "rate": rate,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "method": method?.toJson(),
  };
}

class MethodMethod {
  int? id;
  String? ownerId;
  String? formId;
  String? code;
  String? name;
  String? alias;
  String? status;
  dynamic supportedCurrencies;
  String? crypto;
  String? description;
  String? createdAt;
  String? updatedAt;

  MethodMethod({
    this.id,
    this.ownerId,
    this.formId,
    this.code,
    this.name,
    this.alias,
    this.status,
    this.supportedCurrencies,
    this.crypto,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MethodMethod.fromJson(Map<String, dynamic> json) => MethodMethod(
    id: json["id"],
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    formId: json["form_id"] != null ? json["form_id"].toString() : '',
    code: json["code"] != null ? json["code"].toString() : '',
    name: json["name"] != null ? json["name"].toString() : '',
    alias: json["alias"] != null ? json["alias"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    supportedCurrencies: json["supported_currencies"] != null ? json["supported_currencies"].toString() : '',
    crypto: json["crypto"] != null ? json["crypto"].toString() : '',
    description: json["description"] != null ? json["description"].toString() : '',
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "form_id": formId,
    "code": code,
    "name": name,
    "alias": alias,
    "status": status,
    "supported_currencies": supportedCurrencies,
    "crypto": crypto,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Message {
  List<String>? success;

  Message({
    this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
  };
}
