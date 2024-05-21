// To parse this JSON data, do
//
//     final issueRequesitionsModel = issueRequesitionsModelFromJson(jsonString);

import 'dart:convert';

IssueRequesitionsModel issueRequesitionsModelFromJson(String str) => IssueRequesitionsModel.fromJson(json.decode(str));

String issueRequesitionsModelToJson(IssueRequesitionsModel data) => json.encode(data.toJson());

class IssueRequesitionsModel {
  String? status;
  String? msg;
  Data? data;

  IssueRequesitionsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory IssueRequesitionsModel.fromJson(Map<String, dynamic> json) => IssueRequesitionsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  int? slotId;
  DateTime? reqTime;
  String? remarks;
  bool? issueStatus;
  IssuedBy? issuedBy;
  List<Requisition>? requisitions;

  Data({
    this.slotId,
    this.reqTime,
    this.remarks,
    this.issueStatus,
    this.issuedBy,
    this.requisitions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slotId: json["slot_id"],
        reqTime: json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        remarks: json["remarks"],
        issueStatus: json["issue_status"],
        issuedBy: json["issued_by"] == null ? null : IssuedBy.fromJson(json["issued_by"]),
        requisitions: json["requisitions"] == null
            ? []
            : List<Requisition>.from(json["requisitions"]!.map((x) => Requisition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "req_time": reqTime?.toIso8601String(),
        "remarks": remarks,
        "issue_status": issueStatus,
        "issued_by": issuedBy?.toJson(),
        "requisitions": requisitions == null ? [] : List<dynamic>.from(requisitions!.map((x) => x.toJson())),
      };
}

class IssuedBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  IssuedBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory IssuedBy.fromJson(Map<String, dynamic> json) => IssuedBy(
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

class Requisition {
  int? reqId;
  int? qtyReq;
  int? qtyIssued;
  MatDetails? matDetails;

  Requisition({
    this.reqId,
    this.qtyReq,
    this.qtyIssued,
    this.matDetails,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) => Requisition(
        reqId: json["req_id"],
        qtyReq: json["qty_req"],
        qtyIssued: json["qty_issued"],
        matDetails: json["mat_details"] == null ? null : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "qty_req": qtyReq,
        "qty_issued": qtyIssued,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  int? id;
  String? umo;
  String? material;
  int? gNo;

  MatDetails({
    this.id,
    this.umo,
    this.material,
    this.gNo,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        id: json["id"],
        umo: json["umo"],
        material: json["material"],
        gNo: json["g_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "umo": umo,
        "material": material,
        "g_no": gNo,
      };
}
