// To parse this JSON data, do
//
//     final billOfLadingHistoryModel = billOfLadingHistoryModelFromJson(jsonString);

import 'dart:convert';

BillOfLadingHistoryModel billOfLadingHistoryModelFromJson(String str) => BillOfLadingHistoryModel.fromJson(json.decode(str));

String billOfLadingHistoryModelToJson(BillOfLadingHistoryModel data) => json.encode(data.toJson());

class BillOfLadingHistoryModel {
  BillOfLadingHistoryModel({
    this.id,
    this.ngayVanDon,
    this.soKm,
    this.tenKhachHang,
    this.nguoiTaoDon,
    this.ghiChu,
    this.createdBy,
    this.lastUpdatedDate,
    this.createdDate,
  });

  int? id;
  DateTime? ngayVanDon;
  dynamic soKm;
  dynamic tenKhachHang;
  String? nguoiTaoDon;
  String? ghiChu;
  int? createdBy;
  DateTime? lastUpdatedDate;
  DateTime? createdDate;

  factory BillOfLadingHistoryModel.fromJson(Map<String, dynamic> json) => BillOfLadingHistoryModel(
    id: json["id"],
    ngayVanDon: DateTime.parse(json["ngayVanDon"]),
    soKm: json["soKm"],
    tenKhachHang: json["tenKhachHang"],
    nguoiTaoDon: json["nguoiTaoDon"],
    ghiChu: json["ghiChu"],
    createdBy: json["createdBy"],
    lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
    createdDate: DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ngayVanDon": ngayVanDon.toString(),
    "soKm": soKm,
    "tenKhachHang": tenKhachHang,
    "nguoiTaoDon": nguoiTaoDon,
    "ghiChu": ghiChu,
    "createdBy": createdBy,
    "lastUpdatedDate": lastUpdatedDate.toString(),
    "createdDate": createdDate.toString(),
  };
}
