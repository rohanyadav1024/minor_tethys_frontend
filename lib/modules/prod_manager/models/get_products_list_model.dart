// To parse this JSON data, do
//
//     final getProductsList = getProductsListFromJson(jsonString);

import 'dart:convert';

GetProductsList getProductsListFromJson(String str) => GetProductsList.fromJson(json.decode(str));

String getProductsListToJson(GetProductsList data) => json.encode(data.toJson());

class GetProductsList {
  String? status;
  List<ProductsInfo>? data;

  GetProductsList({
    this.status,
    this.data,
  });

  factory GetProductsList.fromJson(Map<String, dynamic> json) => GetProductsList(
        status: json["status"],
        data: json["data"] == null ? [] : List<ProductsInfo>.from(json["data"]!.map((x) => ProductsInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductsInfo {
  String? product;
  int? id;

  ProductsInfo({
    this.product,
    this.id,
  });

  factory ProductsInfo.fromJson(Map<String, dynamic> json) => ProductsInfo(
        product: json["product"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "id": id,
      };
}
