import 'dart:convert';

OrdersListForSMngr ordersListFromJson(String str) =>
    OrdersListForSMngr.fromJson(json.decode(str));

String ordersListToJson(OrdersListForSMngr data) => json.encode(data.toJson());

class OrdersListForSMngr {
  String? status;
  String? msg;
  List<OrdersDatum>? data;

  OrdersListForSMngr({
    this.status,
    this.msg,
    this.data,
  });

  factory OrdersListForSMngr.fromJson(Map<String, dynamic> json) =>
      OrdersListForSMngr(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<OrdersDatum>.from(
                json["data"]!.map((x) => OrdersDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrdersDatum {
  int? purId;
  DateTime? purTime;
  String? remarks;
  bool? recieved;
  String? invoice;
  String? vehicle;
  DateTime? expDate;
  PurBy? purBy;
  List<OrderDetails>? orders;

  OrdersDatum({
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

  factory OrdersDatum.fromJson(Map<String, dynamic> json) => OrdersDatum(
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
            : List<OrderDetails>.from(
                json["orders"]!.map((x) => OrderDetails.fromJson(x))),
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

class OrderDetails {
  int? orderId;
  int? qtyReq;
  MatDetails? matDetails;

  OrderDetails({
    this.orderId,
    this.qtyReq,
    this.matDetails,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
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
  int? id;
  String? umo;
  int? gNo;

  MatDetails({
    this.material,
    this.id,
    this.umo,
    this.gNo,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        material: json["material"],
        id: json["id"],
        umo: json["umo"],
        gNo: json["g_no"],
      );

  Map<String, dynamic> toJson() => {
        "material": material,
        "id": id,
        "umo": umo,
        "g_no": gNo,
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
