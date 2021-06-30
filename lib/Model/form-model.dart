// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  FormModel({
    this.status,
    this.data,
    this.recordsTotal,
    this.recordsFiltered,
  });

  int status;
  List<Datum> data;
  int recordsTotal;
  int recordsFiltered;

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "recordsTotal": recordsTotal == null ? null : recordsTotal,
        "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
      };
}

class Datum {
  Datum({
    this.id,
    this.username,
    this.customer,
    this.phoneNumber,
    this.createdAt,
    this.category,
  });

  int id;
  String username;
  String customer;
  String phoneNumber;
  String createdAt;
  String category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        customer: json["customer"] == null ? null : json["customer"],
        phoneNumber: json["notelp_customer"] == null ? null : json["notelp_customer"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        category: json["category"] == null ? null : json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "customer": customer == null ? null : customer,
        "notelp_customer": phoneNumber == null ? null : phoneNumber,
        "created_at": createdAt == null ? null : createdAt,
        "category": category == null ? null : category,
      };
}
