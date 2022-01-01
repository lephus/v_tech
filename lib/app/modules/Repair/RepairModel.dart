// To parse this JSON data, do
//
//     final repairModel = repairModelFromJson(jsonString);

import 'dart:convert';

RepairModel repairModelFromJson(String str) => RepairModel.fromJson(json.decode(str));

String repairModelToJson(RepairModel data) => json.encode(data.toJson());

class RepairModel {
  RepairModel({
    this.id,
    this.soLuong,
    this.trangThai,
    this.soLuongDaHoanThanh,
    this.tongSo,
    this.cuaHangInfo,
    this.khachHangInfo,
    this.nhaCungCapInfo,
    this.createDate,
    this.album,
    this.thanhTien,
  });

  int? id;
  int? soLuong;
  String? trangThai;
  int? soLuongDaHoanThanh;
  int? tongSo;
  CuaHangInfo? cuaHangInfo;
  dynamic khachHangInfo;
  dynamic nhaCungCapInfo;
  DateTime? createDate;
  List<dynamic>? album;
  dynamic thanhTien;

  factory RepairModel.fromJson(Map<String, dynamic> json) => RepairModel(
    id: json["id"],
    soLuong: json["soLuong"],
    trangThai: json["trangThai"],
    soLuongDaHoanThanh: json["soLuongDaHoanThanh"],
    tongSo: json["tongSo"],
    cuaHangInfo: CuaHangInfo.fromJson(json["cuaHangInfo"]),
    khachHangInfo: json["khachHangInfo"],
    nhaCungCapInfo: json["nhaCungCapInfo"],
    createDate: DateTime.parse(json["createDate"]),
    album: List<dynamic>.from(json["album"].map((x) => x)),
    thanhTien: json["thanhTien"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "soLuong": soLuong,
    "trangThai": trangThai,
    "soLuongDaHoanThanh": soLuongDaHoanThanh,
    "tongSo": tongSo,
    "cuaHangInfo": cuaHangInfo!.toJson(),
    "khachHangInfo": khachHangInfo,
    "nhaCungCapInfo": nhaCungCapInfo,
    "createDate": createDate.toString(),
    "album": List<dynamic>.from(album!.map((x) => x)),
    "thanhTien": thanhTien,
  };
}

class CuaHangInfo {
  CuaHangInfo({
    this.id,
    this.ten,
    this.diaChi,
  });

  int? id;
  String? ten;
  String? diaChi;

  factory CuaHangInfo.fromJson(Map<String, dynamic> json) => CuaHangInfo(
    id: json["id"],
    ten: json["ten"],
    diaChi: json["diaChi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten": ten,
    "diaChi": diaChi,
  };
}
