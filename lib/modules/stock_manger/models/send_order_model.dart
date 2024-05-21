// To parse this JSON data, do
//
//     final sendOrderModel = sendOrderModelFromJson(jsonString);

import 'dart:convert';

SendOrderModel sendOrderModelFromJson(String str) =>
    SendOrderModel.fromJson(json.decode(str));

String sendOrderModelToJson(SendOrderModel data) => json.encode(data.toJson());

class SendOrderModel {
  String? status;
  String? msg;
  Data? data;

  SendOrderModel({
    this.status,
    this.msg,
    this.data,
  });

  factory SendOrderModel.fromJson(Map<String, dynamic> json) => SendOrderModel(
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
  PurBy? purBy;
  List<Order>? orders;

  Data({
    this.purId,
    this.purTime,
    this.remarks,
    this.recieved,
    this.invoice,
    this.vehicle,
    this.expDate,
    this.purBy,
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
        purBy: json["pur_by"] == null ? null : PurBy.fromJson(json["pur_by"]),
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
        "pur_by": purBy?.toJson(),
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  int? orderId;
  int? qtyReq;
  MatDetails? matDetails;

  Order({
    this.orderId,
    this.qtyReq,
    this.matDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        qtyReq: json["qty_req"],
        matDetails: json["mat_details"] == null
            ? null
            : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "qty_req": qtyReq,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  String? material;
  int? gNo;
  int? id;
  String? umo;

  MatDetails({
    this.material,
    this.gNo,
    this.id,
    this.umo,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        material: json["material"],
        gNo: json["g_no"],
        id: json["id"],
        umo: json["umo"],
      );

  Map<String, dynamic> toJson() => {
        "material": material,
        "g_no": gNo,
        "id": id,
        "umo": umo,
      };
}

class PurBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  PurBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory PurBy.fromJson(Map<String, dynamic> json) => PurBy(
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
