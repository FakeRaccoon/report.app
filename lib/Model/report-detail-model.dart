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

  int id;
  String userId;
  String username;
  String type;
  Data form;
  String createdAt;
  String updatedAt;

  factory ReportDetailModel.fromJson(Map<String, dynamic> json) => ReportDetailModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : json["username"],
    type: json["type"] == null ? null : json["type"],
    form: json["form"] == null ? null : Data.fromJson(json["form"]),
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "username": username == null ? null : username,
    "type": type == null ? null : type,
    "form": form == null ? null : form.toJson(),
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

class Data {
  Data({
    this.type,
    this.category,
    this.prospect,
    this.dateCall,
    this.reasonCall,
    this.agriculturalSeason,
    this.rentalPrice,
    this.engineProblem,
    this.performance,
    this.description,
    this.customer,
    this.ownership,
  });

  String type;
  String category;
  String prospect;
  DateTime dateCall;
  String reasonCall;
  String agriculturalSeason;
  String rentalPrice;
  String engineProblem;
  String performance;
  String description;
  Customer customer;
  Ownership ownership;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"] == null ? null : json["type"],
    category: json["category"] == null ? null : json["category"],
    prospect: json["prospect"] == null ? null : json["prospect"],
    dateCall: json["date_call"] == null ? null : DateTime.parse(json["date_call"]),
    reasonCall: json["reason_call"] == null ? null : json["reason_call"],
    agriculturalSeason: json["agricultural_season"] == null ? null : json["agricultural_season"],
    rentalPrice: json["rental_price"] == null ? null : json["rental_price"],
    engineProblem: json["engine_problem"] == null ? null : json["engine_problem"],
    performance: json["performance"] == null ? null : json["performance"],
    description: json["description"] == null ? null : json["description"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    ownership: json["ownership"] == null ? null : Ownership.fromJson(json["ownership"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "category": category == null ? null : category,
    "prospect": prospect == null ? null : prospect,
    "date_call": dateCall == null ? null : "${dateCall.year.toString().padLeft(4, '0')}-${dateCall.month.toString().padLeft(2, '0')}-${dateCall.day.toString().padLeft(2, '0')}",
    "reason_call": reasonCall == null ? null : reasonCall,
    "agricultural_season": agriculturalSeason == null ? null : agriculturalSeason,
    "rental_price": rentalPrice == null ? null : rentalPrice,
    "engine_problem": engineProblem == null ? null : engineProblem,
    "performance": performance == null ? null : performance,
    "description": description == null ? null : description,
    "customer": customer == null ? null : customer.toJson(),
    "ownership": ownership == null ? null : ownership.toJson(),
  };
}

class Customer {
  Customer({
    this.name,
    this.phone,
    this.email,
    this.job,
    this.background,
    this.province,
    this.city,
    this.district,
    this.village,
    this.address,
  });

  String name;
  String phone;
  String email;
  String job;
  String background;
  String province;
  String city;
  String district;
  String village;
  String address;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    job: json["job"] == null ? null : json["job"],
    background: json["background"] == null ? null : json["background"],
    province: json["province"] == null ? null : json["province"],
    city: json["city"] == null ? null : json["city"],
    district: json["district"] == null ? null : json["district"],
    village: json["village"] == null ? null : json["village"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "job": job == null ? null : job,
    "background": background == null ? null : background,
    "province": province == null ? null : province,
    "city": city == null ? null : city,
    "district": district == null ? null : district,
    "village": village == null ? null : village,
    "address": address == null ? null : address,
  };
}

class Ownership {
  Ownership({
    this.yanmar,
    this.kubota,
    this.china,
  });

  dynamic yanmar;
  String kubota;
  dynamic china;

  factory Ownership.fromJson(Map<String, dynamic> json) => Ownership(
    yanmar: json["yanmar"],
    kubota: json["kubota"] == null ? null : json["kubota"],
    china: json["china"],
  );

  Map<String, dynamic> toJson() => {
    "yanmar": yanmar,
    "kubota": kubota == null ? null : kubota,
    "china": china,
  };
}
