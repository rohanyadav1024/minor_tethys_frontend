import 'dart:convert';

GetItemsListModel getItemsListModelFromJson(String str) =>
    GetItemsListModel.fromJson(json.decode(str));

String getItemsListModelToJson(GetItemsListModel data) =>
    json.encode(data.toJson());

class GetItemsListModel {
  String? status;
  List<MaterialInfo>? data;

  GetItemsListModel({
    this.status,
    this.data,
  });

  factory GetItemsListModel.fromJson(Map<String, dynamic> json) =>
      GetItemsListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MaterialInfo>.from(
                json["data"]!.map((x) => MaterialInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MaterialInfo {
  int? id;
  String? material;
  String? umo;
  int? gNo;

  MaterialInfo({
    this.id,
    this.material,
    this.umo,
    this.gNo,
  });

  factory MaterialInfo.fromJson(Map<String, dynamic> json) => MaterialInfo(
        id: json["id"],
        material: json["material"],
        umo: json["umo"],
        gNo: json["g_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "material": material,
        "umo": umo,
        "g_no": gNo,
      };
}
