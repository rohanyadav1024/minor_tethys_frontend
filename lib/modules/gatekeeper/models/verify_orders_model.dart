// To parse this JSON data, do
//
//     final verifyOrdersModel = verifyOrdersModelFromJson(jsonString);

import 'dart:convert';

VerifyOrdersModel verifyOrdersModelFromJson(String str) =>
    VerifyOrdersModel.fromJson(json.decode(str));

String verifyOrdersModelToJson(VerifyOrdersModel data) =>
    json.encode(data.toJson());

class VerifyOrdersModel {
  String? status;
  String? msg;
  Data? data;

  VerifyOrdersModel({
    this.status,
    this.msg,
    this.data,
  });

  factory VerifyOrdersModel.fromJson(Map<String, dynamic> json) =>
      VerifyOrdersModel(
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
  int? purId;
  DateTime? purTime;
  String? remarks;
  bool? recieved;
  String? invoice;
  String? vehicle;
  DateTime? expDate;
  RecBy? recBy;
  List<Order>? orders;

  Data({
    this.purId,
    this.purTime,
    this.remarks,
    this.recieved,
    this.invoice,
    this.vehicle,
    this.expDate,
    this.recBy,
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        purId: json["pur_id"],
        purTime:
            json["pur_time"] == null ? null : DateTime.parse(json["pur_time"]),
        remarks: json["remarks"],
        recieved: json["recieved"],
        invoice: json["invoice"],
        vehicle: json["vehicle"],
        expDate:
            json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
        recBy: json["rec_by"] == null ? null : RecBy.fromJson(json["rec_by"]),
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pur_id": purId,
        "pur_time": purTime?.toIso8601String(),
        "remarks": remarks,
        "recieved": recieved,
        "invoice": invoice,
        "vehicle": vehicle,
        "exp_date": expDate?.toIso8601String(),
        "rec_by": recBy?.toJson(),
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  int? orderId;
  int? qtyReq;
  int? qtyRec;
  MatDetails? matDetails;

  Order({
    this.orderId,
    this.qtyReq,
    this.qtyRec,
    this.matDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        qtyReq: json["qty_req"],
        qtyRec: json["qty_rec"],
        matDetails: json["mat_details"] == null
            ? null
            : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "qty_req": qtyReq,
        "qty_rec": qtyRec,
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

class RecBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  RecBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory RecBy.fromJson(Map<String, dynamic> json) => RecBy(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
