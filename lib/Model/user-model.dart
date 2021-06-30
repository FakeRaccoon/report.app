// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.success,
    this.statusCode,
  });

  List<User> success;
  int statusCode;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"] == null ? null : List<User>.from(json["success"].map((x) => User.fromJson(x))),
    statusCode: json["status_code"] == null ? null : json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : List<dynamic>.from(success.map((x) => x.toJson())),
    "status_code": statusCode == null ? null : statusCode,
  };
}

class User {
  User({
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

  int id;
  String name;
  String username;
  String password;
  String role;
  dynamic token;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    role: json["role"] == null ? null : json["role"],
    token: json["token"],
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
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
