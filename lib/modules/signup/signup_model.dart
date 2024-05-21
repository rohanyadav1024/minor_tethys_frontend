// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String? status;
  String? detail;
  Data? data;

  SignupModel({
    this.status,
    this.detail,
    this.data,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        status: json["status"],
        detail: json["detail"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "detail": detail,
        "data": data?.toJson(),
      };
}

class Data {
  String? name;
  String? email;
  int? role;
  String? phone;
  int? id;
  DateTime? createdAt;
  bool? isActive;

  Data({
    this.name,
    this.email,
    this.role,
    this.phone,
    this.id,
    this.createdAt,
    this.isActive,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "phone": phone,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}
