// To parse this JSON data, do
//
//     final AcceptEmpReqModel = AcceptEmpReqModelFromJson(jsonString);

// import 'dart:convert';
import 'dart:convert';

AcceptEmpReqModel acceptEmpReqModelFromJson(String str) => AcceptEmpReqModel.fromJson(json.decode(str));

String acceptEmpReqModelToJson(AcceptEmpReqModel data) => json.encode(data.toJson());

class AcceptEmpReqModel {
  String? status;
  Data? data;

  AcceptEmpReqModel({
    this.status,
    this.data,
  });

  factory AcceptEmpReqModel.fromJson(Map<String, dynamic> json) => AcceptEmpReqModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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
