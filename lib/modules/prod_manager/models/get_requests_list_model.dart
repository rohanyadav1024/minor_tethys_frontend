// To parse this JSON data, do
//
//     final requisitionListModel = requisitionListModelFromJson(jsonString);

import 'dart:convert';

RequisitionListModel requisitionListModelFromJson(String str) => RequisitionListModel.fromJson(json.decode(str));

String requisitionListModelToJson(RequisitionListModel data) => json.encode(data.toJson());

class RequisitionListModel {
  String? status;
  String? msg;
  List<ReqListDatum>? data;

  RequisitionListModel({
    this.status,
    this.msg,
    this.data,
  });

  factory RequisitionListModel.fromJson(Map<String, dynamic> json) => RequisitionListModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<ReqListDatum>.from(json["data"]!.map((x) => ReqListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReqListDatum {
  int? slotId;
  DateTime? reqTime;
  String? remarks;
  bool? issueStatus;
  DateTime? issueTime;
  IssueBy? issueBy;
  List<Requisition>? requisitions;

  ReqListDatum({
    this.slotId,
    this.reqTime,
    this.remarks,
    this.issueStatus,
    this.issueTime,
    this.issueBy,
    this.requisitions,
  });

  factory ReqListDatum.fromJson(Map<String, dynamic> json) => ReqListDatum(
        slotId: json["slot_id"],
        reqTime: json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        remarks: json["remarks"],
        issueStatus: json["issue_status"],
        issueTime: json["issue_time"] == null ? null : DateTime.parse(json["issue_time"]),
        issueBy: json["issue_by"] == null ? null : IssueBy.fromJson(json["issue_by"]),
        requisitions: json["requisitions"] == null
            ? []
            : List<Requisition>.from(json["requisitions"]!.map((x) => Requisition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "req_time": reqTime?.toIso8601String(),
        "remarks": remarks,
        "issue_status": issueStatus,
        "issue_time": issueTime?.toIso8601String(),
        "issue_by": issueBy?.toJson(),
        "requisitions": requisitions == null ? [] : List<dynamic>.from(requisitions!.map((x) => x.toJson())),
      };
}

class IssueBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  IssueBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory IssueBy.fromJson(Map<String, dynamic> json) => IssueBy(
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
  int? qtyConsumed;
  MatDetails? matDetails;

  Requisition({
    this.reqId,
    this.qtyReq,
    this.qtyIssued,
    this.qtyConsumed,
    this.matDetails,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) => Requisition(
        reqId: json["req_id"],
        qtyReq: json["qty_req"],
        qtyIssued: json["qty_issued"],
        qtyConsumed: json["qty_consumed"],
        matDetails: json["mat_details"] == null ? null : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "qty_req": qtyReq,
        "qty_issued": qtyIssued,
        "qty_consumed": qtyConsumed,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  int? id;
  String? umo;
  int? gNo;
  String? material;

  MatDetails({
    this.id,
    this.umo,
    this.gNo,
    this.material,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        id: json["id"],
        umo: json["umo"],
        gNo: json["g_no"],
        material: json["material"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "umo": umo,
        "g_no": gNo,
        "material": material,
      };
}
