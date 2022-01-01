
import 'dart:convert';

TrangThaiModel trangThaiModelFromJson(String str) => TrangThaiModel.fromJson(json.decode(str));

String trangThaiModelToJson(TrangThaiModel data) => json.encode(data.toJson());

class TrangThaiModel {
  TrangThaiModel({
    this.id,
    this.ten,
    this.ma,
    this.kieuTrangThai,
  });

  int? id;
  String? ten;
  String? ma;
  String? kieuTrangThai;

  factory TrangThaiModel.fromJson(Map<String, dynamic> json) => TrangThaiModel(
    id: json["id"],
    ten: json["ten"],
    ma: json["ma"],
    kieuTrangThai: json["kieuTrangThai"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten": ten,
    "ma": ma,
    "kieuTrangThai": kieuTrangThai,
  };
}
