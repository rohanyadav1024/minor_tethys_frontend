// To parse this JSON data, do
//
//     final getHandoversListModel = getHandoversListModelFromJson(jsonString);

import 'dart:convert';

GetHandoversListModel getHandoversListModelFromJson(String str) => GetHandoversListModel.fromJson(json.decode(str));

String getHandoversListModelToJson(GetHandoversListModel data) => json.encode(data.toJson());

class GetHandoversListModel {
  String? status;
  String? msg;
  List<HandoverDatum>? data;

  GetHandoversListModel({
    this.status,
    this.msg,
    this.data,
  });

  factory GetHandoversListModel.fromJson(Map<String, dynamic> json) => GetHandoversListModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<HandoverDatum>.from(json["data"]!.map((x) => HandoverDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HandoverDatum {
  int? batchId;
  DateTime? mfg;
  String? remarks;
  bool? isRecieved;
  dynamic recievedTime;
  dynamic recievedBy;
  HandoverBy? handoverBy;
  List<Handover>? handovers;

  HandoverDatum({
    this.batchId,
    this.mfg,
    this.remarks,
    this.isRecieved,
    this.recievedTime,
    this.recievedBy,
    this.handoverBy,
    this.handovers,
  });

  factory HandoverDatum.fromJson(Map<String, dynamic> json) => HandoverDatum(
        batchId: json["batch_id"],
        mfg: json["mfg"] == null ? null : DateTime.parse(json["mfg"]),
        remarks: json["remarks"],
        isRecieved: json["is_recieved"],
        recievedTime: json["recieved_time"],
        recievedBy: json["recieved_by"],
        handoverBy: json["handover_by"] == null ? null : HandoverBy.fromJson(json["handover_by"]),
        handovers:
            json["handovers"] == null ? [] : List<Handover>.from(json["handovers"]!.map((x) => Handover.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "mfg": mfg?.toIso8601String(),
        "remarks": remarks,
        "is_recieved": isRecieved,
        "recieved_time": recievedTime,
        "recieved_by": recievedBy,
        "handover_by": handoverBy?.toJson(),
        "handovers": handovers == null ? [] : List<dynamic>.from(handovers!.map((x) => x.toJson())),
      };
}

class HandoverBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  HandoverBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory HandoverBy.fromJson(Map<String, dynamic> json) => HandoverBy(
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

class Handover {
  int? handoverId;
  Product? product;
  int? qtyReq;

  Handover({
    this.handoverId,
    this.product,
    this.qtyReq,
  });

  factory Handover.fromJson(Map<String, dynamic> json) => Handover(
        handoverId: json["handover_id"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        qtyReq: json["qty_req"],
      );

  Map<String, dynamic> toJson() => {
        "handover_id": handoverId,
        "product": product?.toJson(),
        "qty_req": qtyReq,
      };
}

class Product {
  String? product;
  int? id;

  Product({
    this.product,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["product"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "id": id,
      };
}
