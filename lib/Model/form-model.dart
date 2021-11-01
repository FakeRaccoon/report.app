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

  int? status;
  List<Data>? data;
  int? recordsTotal;
  int? recordsFiltered;

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        recordsTotal: json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"] == null ? null : json["recordsFiltered"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        "recordsTotal": recordsTotal == null ? null : recordsTotal,
        "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
      };
}

class Data {
  Data({
    this.id,
    this.username,
    this.customer,
    this.phoneNumber,
    this.createdAt,
    this.category,
    this.job,
    this.request,
    this.description,
    this.link,
    this.contact,
    this.problem,
    this.solution,
    this.type,
    this.asset,
    this.total,
    this.goal,
  });

  int? id;
  int? asset;
  int? total;
  String? username;
  String? customer;
  String? phoneNumber;
  String? createdAt;
  String? category;
  String? job;
  String? goal;
  String? request;
  String? description;
  String? link;
  String? contact;
  String? problem;
  String? solution;
  String? type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        customer: json["customer"] == null ? null : json["customer"],
        phoneNumber: json["notelp_customer"] == null ? null : json["notelp_customer"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        category: json["category"] == null ? null : json["category"],
        job: json["job"] == null ? null : json["job"],
        request: json["request"] == null ? null : json["request"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        contact: json["contact"] == null ? null : json["contact"],
        problem: json["problem"] == null ? null : json["problem"],
        solution: json["solution"] == null ? null : json["solution"],
        type: json["type"] == null ? null : json["type"],
        goal: json["goal"] == null ? null : json["goal"],
        asset: json["asset"] == null ? null : json["asset"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "customer": customer == null ? null : customer,
        "notelp_customer": phoneNumber == null ? null : phoneNumber,
        "created_at": createdAt == null ? null : createdAt,
        "category": category == null ? null : category,
        "job": job == null ? null : job,
        "request": request == null ? null : request,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "contact": contact == null ? null : contact,
        "problem": problem == null ? null : problem,
        "solution": solution == null ? null : solution,
        "type": type == null ? null : type,
        "goal": goal == null ? null : goal,
        "asset": asset == null ? null : asset,
        "total": total == null ? null : total,
      };
}
