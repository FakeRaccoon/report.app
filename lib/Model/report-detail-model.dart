// To parse this JSON data, do
//
//     final reportDetailModel = reportDetailModelFromJson(jsonString);

import 'dart:convert';

ReportDetailModel reportDetailModelFromJson(String str) => ReportDetailModel.fromJson(json.decode(str));

String reportDetailModelToJson(ReportDetailModel data) => json.encode(data.toJson());

class ReportDetailModel {
  ReportDetailModel({
    this.id,
    this.userId,
    this.username,
    this.type,
    this.form,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? username;
  String? type;
  Form? form;
  String? createdAt;
  String? updatedAt;

  factory ReportDetailModel.fromJson(Map<String, dynamic> json) => ReportDetailModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : json["username"],
    type: json["type"] == null ? null : json["type"],
    form: json["form"] == null ? null : Form.fromJson(json["form"]),
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "username": username == null ? null : username,
    "type": type == null ? null : type,
    "form": form == null ? null : form!.toJson(),
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

class Form {
  Form({
    this.time,
    this.customer,
    this.address,
    this.contact,
    this.type,
    this.request,
    this.job,
    this.problem,
    this.link,
    this.solution,
    this.description,
  });

  String? time;
  String? customer;
  String? address;
  String? contact;
  String? type;
  String? request;
  String? job;
  String? problem;
  String? link;
  String? solution;
  String? description;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
    time: json["time"] == null ? null : json["time"],
    customer: json["customer"] == null ? null : json["customer"],
    address: json["address"] == null ? null : json["address"],
    contact: json["contact"] == null ? null : json["contact"],
    type: json["type"] == null ? null : json["type"],
    request: json["request"] == null ? null : json["request"],
    job: json["job"] == null ? null : json["job"],
    problem: json["problem"] == null ? null : json["problem"],
    link: json["link"] == null ? null : json["link"],
    solution: json["solution"] == null ? null : json["solution"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? null : time,
    "customer": customer == null ? null : customer,
    "address": address == null ? null : address,
    "contact": contact == null ? null : contact,
    "type": type == null ? null : type,
    "request": request == null ? null : request,
    "job": job == null ? null : job,
    "problem": problem == null ? null : problem,
    "link": link == null ? null : link,
    "solution": solution == null ? null : solution,
    "description": description == null ? null : description,
  };
}
