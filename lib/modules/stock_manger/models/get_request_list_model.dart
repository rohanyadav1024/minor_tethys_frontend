// To parse this JSON data, do
//
//     final materialRequestModel = materialRequestModelFromJson(jsonString);

import 'dart:convert';

MaterialRequestModel materialRequestModelFromJson(String str) => MaterialRequestModel.fromJson(json.decode(str));

String materialRequestModelToJson(MaterialRequestModel data) => json.encode(data.toJson());

class MaterialRequestModel {
  String? status;
  String? msg;
  List<MaterialReqDatum>? data;

  MaterialRequestModel({
    this.status,
    this.msg,
    this.data,
  });

  factory MaterialRequestModel.fromJson(Map<String, dynamic> json) => MaterialRequestModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<MaterialReqDatum>.from(json["data"]!.map((x) => MaterialReqDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MaterialReqDatum {
  int? slotId;
  DateTime? reqTime;
  String? remarks;
  bool? issueStatus;
  ReqBy? reqBy;
  List<Requisition>? requisitions;

  MaterialReqDatum({
    this.slotId,
    this.reqTime,
    this.remarks,
    this.issueStatus,
    this.reqBy,
    this.requisitions,
  });

  factory MaterialReqDatum.fromJson(Map<String, dynamic> json) => MaterialReqDatum(
        slotId: json["slot_id"],
        reqTime: json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        remarks: json["remarks"],
        issueStatus: json["issue_status"],
        reqBy: json["req_by"] == null ? null : ReqBy.fromJson(json["req_by"]),
        requisitions: json["requisitions"] == null
            ? []
            : List<Requisition>.from(json["requisitions"]!.map((x) => Requisition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "req_time": reqTime?.toIso8601String(),
        "remarks": remarks,
        "issue_status": issueStatus,
        "req_by": reqBy?.toJson(),
        "requisitions": requisitions == null ? [] : List<dynamic>.from(requisitions!.map((x) => x.toJson())),
      };
}

class ReqBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  ReqBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory ReqBy.fromJson(Map<String, dynamic> json) => ReqBy(
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
