import 'dart:convert';

PermissionsModel permissionsModelFromJson(String str) => PermissionsModel.fromJson(json.decode(str));

String permissionsModelToJson(PermissionsModel data) => json.encode(data.toJson());

class PermissionsModel {
  PermissionsModel({
    this.id,
    this.parentId,
    this.ten,
    this.url,
    this.tenHienThi,
    this.checked,
    this.idNguoiDung,
    this.idHanhDong,
    this.children,
  });

  int? id;
  int? parentId;
  String? ten;
  dynamic url;
  String? tenHienThi;
  bool? checked;
  dynamic idNguoiDung;
  dynamic idHanhDong;
  List<PermissionsModel>? children;

  factory PermissionsModel.fromJson(Map<String, dynamic> json) => PermissionsModel(
    id: json["id"],
    parentId: json["parent_Id"],
    ten: json["ten"],
    url: json["url"],
    tenHienThi: json["tenHienThi"],
    checked: json["checked"],
    idNguoiDung: json["id_NguoiDung"],
    idHanhDong: json["id_HanhDong"],
    children: List<PermissionsModel>.from(json["children"].map((x) => PermissionsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_Id": parentId,
    "ten": ten,
    "url": url,
    "tenHienThi": tenHienThi,
    "checked": checked,
    "id_NguoiDung": idNguoiDung,
    "id_HanhDong": idHanhDong,
    "children": List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}
