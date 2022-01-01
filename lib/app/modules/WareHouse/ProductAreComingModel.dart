// To parse this JSON data, do
//
//     final detailTransferModel = detailTransferModelFromJson(jsonString);

import 'dart:convert';

ProductAreComingModel detailTransferModelFromJson(String str) => ProductAreComingModel.fromJson(json.decode(str));

String detailTransferModelToJson(ProductAreComingModel data) => json.encode(data.toJson());

class ProductAreComingModel {
  ProductAreComingModel({
    this.soLuongDangVe,
    this.soLuongDaVe,
    this.tongTienNdtDangVe,
    this.tongTienVndDangVe,
    this.tongTienNdtDaVe,
    this.tongTienVndDaVe,
    this.totalRecords,
    this.data,
  });

  int? soLuongDangVe;
  int? soLuongDaVe;
  double? tongTienNdtDangVe;
  double? tongTienVndDangVe;
  double? tongTienNdtDaVe;
  double? tongTienVndDaVe;
  int? totalRecords;
  List<Datum>? data;

  factory ProductAreComingModel.fromJson(Map<String, dynamic> json) => ProductAreComingModel(
    soLuongDangVe: json["soLuongDangVe"],
    soLuongDaVe: json["soLuongDaVe"],
    tongTienNdtDangVe: double.parse(json["tongTienNdtDangVe"].toString()),
    tongTienVndDangVe: double.parse(json["tongTienVndDangVe"].toString()),
    tongTienNdtDaVe: double.parse(json["tongTienNdtDaVe"].toString()),
    tongTienVndDaVe: double.parse(json["tongTienVndDaVe"].toString()),
    totalRecords: json["totalRecords"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "soLuongDangVe": soLuongDangVe,
    "soLuongDaVe": soLuongDaVe,
    "tongTienNdtDangVe": tongTienNdtDangVe,
    "tongTienVndDangVe": tongTienVndDangVe,
    "tongTienNdtDaVe": tongTienNdtDaVe,
    "tongTienVndDaVe": tongTienVndDaVe,
    "totalRecords": totalRecords,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.idYeuCauXnk,
    this.idNhaCungCap,
    this.tenNhaCungCap,
    this.idCuaHang,
    this.tenCuaHang,
    this.soLo,
    this.giaTienTe,
    this.giaNhapVnd,
    this.idSanPham,
    this.tenSanPham,
    this.soLuongYeuCau,
    this.soLuongDuyet,
    this.giaYeuCau,
    this.moTa,
    this.daHoanThanh,
  });

  int? id;
  int? idYeuCauXnk;
  int? idNhaCungCap;
  String? tenNhaCungCap;
  int? idCuaHang;
  String? tenCuaHang;
  String? soLo;
  double? giaTienTe;
  double? giaNhapVnd;
  int? idSanPham;
  String? tenSanPham;
  int? soLuongYeuCau;
  int? soLuongDuyet;
  double? giaYeuCau;
  String? moTa;
  bool? daHoanThanh;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    idYeuCauXnk: json["id_YeuCauXNK"],
    idNhaCungCap: json["id_NhaCungCap"],
    tenNhaCungCap: json["ten_NhaCungCap"],
    idCuaHang: json["id_CuaHang"],
    tenCuaHang: json["ten_CuaHang"],
    soLo: json["soLo"],
    giaTienTe: double.parse(json["giaTienTe"].toString()),
    giaNhapVnd: double.parse(json["giaNhapVnd"].toString()),
    idSanPham: json["id_SanPham"],
    tenSanPham: json["ten_SanPham"],
    soLuongYeuCau: json["soLuongYeuCau"],
    soLuongDuyet: json["soLuongDuyet"],
    giaYeuCau: json["giaYeuCau"],
    moTa: json["moTa"],
    daHoanThanh: json["daHoanThanh"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_YeuCauXNK": idYeuCauXnk,
    "id_NhaCungCap": idNhaCungCap,
    "ten_NhaCungCap": tenNhaCungCap,
    "id_CuaHang": idCuaHang,
    "ten_CuaHang": tenCuaHang,
    "soLo": soLo,
    "giaTienTe": giaTienTe,
    "giaNhapVnd": giaNhapVnd,
    "id_SanPham": idSanPham,
    "ten_SanPham": tenSanPham,
    "soLuongYeuCau": soLuongYeuCau,
    "soLuongDuyet": soLuongDuyet,
    "giaYeuCau": giaYeuCau,
    "moTa": moTa,
    "daHoanThanh": daHoanThanh,
  };
}
