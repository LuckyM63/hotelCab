
import 'dart:convert';
import '../auth/login/login_response_model.dart';

NotificationResponseModel notificationResponseModelFromJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

class NotificationResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  NotificationResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
    remark: json["remark"],
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Notifications? notifications;

  Data({
    this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
  );
}

class Notifications {
  List<Datum>? data;
  String? nextPageUrl;
  String? total;

  Notifications({
    this.data,
    this.nextPageUrl,
    this.total,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    nextPageUrl: json["next_page_url"] != null ? json["next_page_url"].toString() : '',
    total: json["total"] != null ? json["total"].toString() : '',
  );
}

class Datum {
  int? id;
  String? subject;
  String? message;
  String? createdAt;

  Datum({
    this.id,
    this.subject,
    this.message,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    subject: json["subject"] != null ? json["subject"].toString() : '',
    message: json["message"] != null ? json["message"].toString() : '',
    createdAt: json["created_at"] != null ? json["created_at"].toString() : '',
  );
}

class Link {
  String? url;
  String? label;
  String? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] != null ? json["url"].toString() : '',
    label: json["label"] != null ? json["label"].toString() : '',
    active: json["active"] != null ? json["active"].toString() : '',
  );
}

