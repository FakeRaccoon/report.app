// To parse this JSON data, do
//
//     final loginDetail = loginDetailFromJson(jsonString);

import 'dart:convert';

LoginDetail loginDetailFromJson(String str) => LoginDetail.fromJson(json.decode(str));

String loginDetailToJson(LoginDetail data) => json.encode(data.toJson());

class LoginDetail {
  LoginDetail({
    this.success,
    this.statusCode,
  });

  Success? success;
  int? statusCode;

  factory LoginDetail.fromJson(Map<String, dynamic> json) => LoginDetail(
        success: json["success"] == null ? null : Success.fromJson(json["success"]),
        statusCode: json["status_code"] == null ? null : json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success!.toJson(),
        "status_code": statusCode == null ? null : statusCode,
      };
}

class Success {
  Success({
    this.id,
    this.name,
    this.username,
    this.password,
    this.role,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  String? username;
  String? password;
  String? role;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        role: json["role"] == null ? null : json["role"],
        token: json["token"] == null ? null : json['token'],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "role": role == null ? null : role,
        "token": token,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
