

import 'dart:convert';
import '../auth/login/login_response_model.dart';

PaymentLogResponseModel paymentLogResponseModelFromJson(String str) => PaymentLogResponseModel.fromJson(json.decode(str));

class PaymentLogResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  PaymentLogResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory PaymentLogResponseModel.fromJson(Map<String, dynamic> json) => PaymentLogResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Deposits? deposits;

  Data({
    this.deposits,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    deposits: json["deposits"] == null ? null : Deposits.fromJson(json["deposits"]),
  );
}

class Deposits {
  List<Datum>? data;
  String? nextPageUrl;
  String? total;

  Deposits({
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory Deposits.fromJson(Map<String, dynamic> json) => Deposits(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    nextPageUrl: json["next_page_url"] != null ? json["next_page_url"].toString() : '',
    total: json["total"] != null ? json["total"].toString() : '',
  );
}

class Datum {
  String? id;
  String? userId;
  String? ownerId;
  String? bookingId;
  String? payForMonth;
  String? methodCode;
  String? amount;
  String? methodCurrency;
  String? charge;
  String? rate;
  String? finalAmo;
  String? btcAmo;
  String? btcWallet;
  String? trx;
  String? paymentTry;
  String? status;
  String? fromApi;
  String? adminFeedback;
  String? createdAt;
  String? updatedAt;
  Booking? booking;

  Datum({
    this.id,
    this.userId,
    this.ownerId,
    this.bookingId,
    this.payForMonth,
    this.methodCode,
    this.amount,
    this.methodCurrency,
    this.charge,
    this.rate,
    this.finalAmo,
    this.btcAmo,
    this.btcWallet,
    this.trx,
    this.paymentTry,
    this.status,
    this.fromApi,
    this.adminFeedback,
    this.createdAt,
    this.updatedAt,
    this.booking,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] != null ? json["id"].toString() : '',
    userId: json["user_id"] != null ? json["user_id"].toString() : '',
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    bookingId: json["booking_id"] != null ? json["booking_id"].toString() : '',
    payForMonth: json["pay_for_month"] != null ? json["pay_for_month"].toString() : '',
    methodCode: json["method_code"] != null ? json["method_code"].toString() : '',
    amount: json["amount"] != null ? json["amount"].toString() : '',
    methodCurrency: json["method_currency"] != null ? json["method_currency"].toString() : '',
    charge: json["charge"] != null ? json["charge"].toString() : '',
    rate: json["rate"]!= null ? json["rate"].toString() : '',
    finalAmo: json["final_amo"] != null ? json["final_amo"].toString() : '',
    btcAmo: json["btc_amo"] != null ? json["btc_amo"].toString() : '',
    btcWallet: json["btc_wallet"] != null ? json["btc_wallet"].toString() : '',
    trx: json["trx"] != null ? json["trx"].toString() : '',
    paymentTry: json["payment_try"] != null ? json["payment_try"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    fromApi: json["from_api"] != null ? json["from_api"].toString() : '',
    adminFeedback: json["admin_feedback"] != null ? json["admin_feedback"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
  );
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
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"] != null ? json["id"].toString() : '',
    ownerId: json["owner_id"] != null ? json["owner_id"].toString() : '',
    bookingNumber: json["booking_number"] != null ? json["booking_number"].toString() : '',
    userId: json["user_id"] != null ? json["user_id"].toString() : '',
    guestId: json["guest_id"] != null ? json["guest_id"].toString() : '',
    checkIn: DateTime.parse(json["check_in"]),
    checkOut: DateTime.parse(json["check_out"]),
    contactInfo: json["contact_info"] == null ? null : ContactInfo.fromJson(json["contact_info"]),
    totalAdult: json["total_adult"] != null ? json["total_adult"].toString() : '',
    totalChild: json["total_child"] != null ? json["total_child"].toString() : '',
    totalDiscount: json["total_discount"] != null ? json["total_discount"].toString() : '',
    taxCharge: json["tax_charge"] != null ? json["tax_charge"].toString() : '',
    bookingFare: json["booking_fare"] != null ? json["booking_fare"].toString() : '',
    serviceCost: json["service_cost"] != null ? json["service_cost"].toString() : '',
    extraCharge: json["extra_charge"] != null ? json["extra_charge"].toString() : '',
    extraChargeSubtracted: json["extra_charge_subtracted"],
    paidAmount: json["paid_amount"] != null ? json["paid_amount"].toString() : '',
    cancellationFee: json["cancellation_fee"]  != null ? json["cancellation_fee"].toString() : '',
    refundedAmount: json["refunded_amount"] != null ? json["refunded_amount"].toString() : '',
    keyStatus: json["key_status"] != null ? json["key_status"].toString() : '',
    status: json["status"] != null ? json["status"].toString() : '',
    checkedInAt: json["checked_in_at"] != null ? json["checked_in_at"].toString() : '',
    checkedOutAt: json["checked_out_at"] != null ? json["checked_out_at"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
    updatedAt: json["updated_at"] != null ? json["updated_at"].toString() : '',
    totalAmount: json["total_amount"] != null ? json["total_amount"].toString() : "",
    dueAmount: json["due_amount"] != null ? json["due_amount"].toString() : "",
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
    phone: json["phone"] != null ? json["phone"].toString() : '',
  );
}


