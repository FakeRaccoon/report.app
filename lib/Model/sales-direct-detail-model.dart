// To parse this JSON data, do
//
//     final salesDirectDetailModel = salesDirectDetailModelFromJson(jsonString);

import 'dart:convert';

SalesDirectDetailModel salesDirectDetailModelFromJson(String str) => SalesDirectDetailModel.fromJson(json.decode(str));

String salesDirectDetailModelToJson(SalesDirectDetailModel data) => json.encode(data.toJson());

class SalesDirectDetailModel {
  SalesDirectDetailModel({
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

  factory SalesDirectDetailModel.fromJson(Map<String, dynamic> json) => SalesDirectDetailModel(
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
    this.type,
    this.category,
    this.prospect,
    this.dateCall,
    this.payment,
    this.reasonCall,
    this.leasing,
    this.description,
    this.agriculturalSeason,
    this.rentalPrice,
    this.engineProblem,
    this.performance,
    this.goal,
    this.need,
    this.formIn,
    this.out,
    this.total,
    this.asset,
    this.formReturn,
    this.customer,
    this.ownership,
    this.dateVisit,
    this.detail,
  });

  String? type;
  String? category;
  String? prospect;
  DateTime? dateCall;
  String? payment;
  String? reasonCall;
  String? leasing;
  String? description;
  String? agriculturalSeason;
  String? rentalPrice;
  String? engineProblem;
  String? performance;
  String? goal;
  String? need;
  DateTime? formIn;
  DateTime? out;
  int? total;
  int? asset;
  int? formReturn;
  Customer? customer;
  Ownership? ownership;
  DateVisit? dateVisit;
  List<Detail>? detail;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        type: json["type"] == null ? null : json["type"],
        category: json["category"] == null ? null : json["category"],
        prospect: json["prospect"] == null ? null : json["prospect"],
        dateCall: json["date_call"] == null ? null : DateTime.parse(json["date_call"]),
        payment: json["payment"] == null ? null : json["payment"],
        reasonCall: json["reason_call"] == null ? null : json["reason_call"],
        leasing: json["leasing"] == null ? null : json["leasing"],
        description: json["description"] == null ? null : json["description"],
        agriculturalSeason: json["agricultural_season"] == null ? null : json["agricultural_season"],
        rentalPrice: json["rental_price"] == null ? null : json["rental_price"],
        engineProblem: json["engine_problem"] == null ? null : json["engine_problem"],
        performance: json["performance"] == null ? null : json["performance"],
        goal: json["goal"] == null ? null : json["goal"],
        need: json["need"] == null ? null : json["need"],
        formIn: json["in"] == null ? null : DateTime.parse(json["in"]),
        out: json["out"] == null ? null : DateTime.parse(json["out"]),
        total: json["total"] == null ? null : json["total"],
        asset: json["asset"] == null ? null : json["asset"],
        formReturn: json["return"] == null ? null : json["return"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        ownership: json["ownership"] == null ? null : Ownership.fromJson(json["ownership"]),
        dateVisit: json["date_visit"] == null ? null : DateVisit.fromJson(json["date_visit"]),
        detail: json["detail"] == null ? null : List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "category": category == null ? null : category,
        "prospect": prospect == null ? null : prospect,
        "date_call": dateCall == null ? null : dateCall,
        "payment": payment == null ? null : payment,
        "reason_call": reasonCall == null ? null : reasonCall,
        "leasing": leasing == null ? null : leasing,
        "description": description == null ? null : description,
        "agricultural_season": agriculturalSeason == null ? null : agriculturalSeason,
        "rental_price": rentalPrice == null ? null : rentalPrice,
        "engine_problem": engineProblem == null ? null : engineProblem,
        "performance": performance == null ? null : performance,
        "goal": goal == null ? null : goal,
        "need": need == null ? null : need,
        "in": formIn == null ? null : formIn,
        "out": out == null ? null : out,
        "total": total == null ? null : total,
        "asset": asset == null ? null : asset,
        "return": formReturn == null ? null : formReturn,
        "customer": customer == null ? null : customer!.toJson(),
        "ownership": ownership == null ? null : ownership!.toJson(),
        "date_visit": dateVisit == null ? null : dateVisit!.toJson(),
        "detail": detail == null ? null : List<dynamic>.from(detail!.map((x) => x.toJson())),
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

  String? name;
  String? phone;
  String? email;
  String? job;
  String? background;
  String? province;
  String? city;
  String? district;
  String? village;
  String? address;

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

class DateVisit {
  DateVisit({
    this.i,
    this.ii,
    this.iii,
    this.iv,
    this.v,
  });

  DateTime? i;
  DateTime? ii;
  DateTime? iii;
  DateTime? iv;
  DateTime? v;

  factory DateVisit.fromJson(Map<String, dynamic> json) => DateVisit(
        i: json["I"] == null ? null : DateTime.parse(json["I"]),
        ii: json["II"] == null ? null : DateTime.parse(json["II"]),
        iii: json["III"] == null ? null : DateTime.parse(json["III"]),
        iv: json["IV"] == null ? null : DateTime.parse(json["IV"]),
        v: json["V"] == null ? null : DateTime.parse(json["V"]),
      );

  Map<String, dynamic> toJson() => {
        "I": i == null ? null : i,
        "II": ii == null ? null : ii,
        "III": iii == null ? null : iii,
        "IV": iv == null ? null : iv,
        "V": v == null ? null : v,
      };
}

class Detail {
  Detail({
    this.date,
    this.eat,
    this.lodging,
    this.other,
    this.description,
    this.subtotal,
  });

  DateTime? date;
  int? eat;
  int? lodging;
  int? other;
  String? description;
  int? subtotal;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        eat: json["eat"] == null ? null : json["eat"],
        lodging: json["lodging"] == null ? null : json["lodging"],
        other: json["other"] == null ? null : json["other"],
        description: json["description"] == null ? null : json["description"],
        subtotal: json["subtotal"] == null ? null : json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "eat": eat == null ? null : eat,
        "lodging": lodging == null ? null : lodging,
        "other": other == null ? null : other,
        "description": description == null ? null : description,
        "subtotal": subtotal == null ? null : subtotal,
      };
}

class Ownership {
  Ownership({
    this.yanmar,
    this.kubota,
    this.china,
  });

  String? yanmar;
  String? kubota;
  String? china;

  factory Ownership.fromJson(Map<String, dynamic> json) => Ownership(
        yanmar: json["yanmar"] == null ? null : json["yanmar"],
        kubota: json["kubota"] == null ? null : json["kubota"],
        china: json["china"] == null ? null : json["china"],
      );

  Map<String, dynamic> toJson() => {
        "yanmar": yanmar == null ? null : yanmar,
        "kubota": kubota == null ? null : kubota,
        "china": china == null ? null : china,
      };
}
