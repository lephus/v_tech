// To parse this JSON data, do
//
//     final revenueModel = revenueModelFromJson(jsonString);

import 'dart:convert';

List<RevenueModel> revenueModelFromJson(String str) => List<RevenueModel>.from(json.decode(str).map((x) => RevenueModel.fromJson(x)));

String revenueModelToJson(List<RevenueModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RevenueModel {
  RevenueModel({
    this.idCuaHang,
    this.tenCuaHang,
    this.doanhThu,
  });

  int? idCuaHang;
  String? tenCuaHang;
  double? doanhThu;

  factory RevenueModel.fromJson(Map<String, dynamic> json) => RevenueModel(
    idCuaHang: json["idCuaHang"],
    tenCuaHang: json["tenCuaHang"],
    doanhThu: json["doanhThu"] == null ? 0.0 : double.parse(json["doanhThu"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "idCuaHang": idCuaHang,
    "tenCuaHang": tenCuaHang,
    "doanhThu": doanhThu,
  };
}
