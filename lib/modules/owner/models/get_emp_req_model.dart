// To parse this JSON data, do
//
//     final employeeRequestModel = getEmpReqModelFromJson(jsonString);

import 'dart:convert';

GetEmpReqModel getEmpReqModelFromJson(String str) => GetEmpReqModel.fromJson(json.decode(str));

String getEmpReqModelToJson(GetEmpReqModel data) => json.encode(data.toJson());

class GetEmpReqModel {
  String? status;
  List<EmpReqDatum>? data;

  GetEmpReqModel({
    this.status,
    this.data,
  });

  factory GetEmpReqModel.fromJson(Map<String, dynamic> json) => GetEmpReqModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<EmpReqDatum>.from(json["data"]!.map((x) => EmpReqDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EmpReqDatum {
  int? reqId;
  Employee? employee;

  EmpReqDatum({
    this.reqId,
    this.employee,
  });

  factory EmpReqDatum.fromJson(Map<String, dynamic> json) => EmpReqDatum(
        reqId: json["req_id"],
        employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "employee": employee?.toJson(),
      };
}

class Employee {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  Employee({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}
