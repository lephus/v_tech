import 'dart:convert';

TrangThaiGiaoHangModel trangThaiGiaoHangModelFromJson(String str) => TrangThaiGiaoHangModel.fromJson(json.decode(str));

String trangThaiGiaoHangModelToJson(TrangThaiGiaoHangModel data) => json.encode(data.toJson());

class TrangThaiGiaoHangModel {
  TrangThaiGiaoHangModel({
    this.id,
    this.idDonHang,
    this.idTrangThai,
    this.tenNhaVanChuyen,
    this.tenKhachHang,
    this.soDienThoai,
    this.ngayTaoDonHang,
    this.donHang,
    this.trangThai,
    this.ghiChu,
    this.tongTienDon,
    this.idNguonDonHang,
    this.idDoanhNghiep,
    this.nguonDonHang,
  });

  int? id;
  int? idDonHang;
  int? idTrangThai;
  String? tenNhaVanChuyen;
  String? tenKhachHang;
  String? soDienThoai;
  DateTime? ngayTaoDonHang;
  dynamic donHang;
  String? trangThai;
  String? ghiChu;
  dynamic tongTienDon;
  dynamic idNguonDonHang;
  int? idDoanhNghiep;
  dynamic nguonDonHang;

  factory TrangThaiGiaoHangModel.fromJson(Map<String, dynamic> json) => TrangThaiGiaoHangModel(
    id: json["id"],
    idDonHang: json["idDonHang"],
    idTrangThai: json["idTrangThai"],
    tenNhaVanChuyen: json["tenNhaVanChuyen"],
    tenKhachHang: json["tenKhachHang"],
    soDienThoai: json["soDienThoai"],
    ngayTaoDonHang: DateTime.parse(json["ngayTaoDonHang"]),
    donHang: json["donHang"],
    trangThai: json["trangThai"],
    ghiChu: json["ghiChu"],
    tongTienDon: json["tongTienDon"],
    idNguonDonHang: json["idNguonDonHang"],
    idDoanhNghiep: json["idDoanhNghiep"],
    nguonDonHang: json["nguonDonHang"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idDonHang": idDonHang,
    "idTrangThai": idTrangThai,
    "tenNhaVanChuyen": tenNhaVanChuyen,
    "tenKhachHang": tenKhachHang,
    "soDienThoai": soDienThoai,
    "ngayTaoDonHang": ngayTaoDonHang.toString(),
    "donHang": donHang,
    "trangThai": trangThai,
    "ghiChu": ghiChu,
    "tongTienDon": tongTienDon,
    "idNguonDonHang": idNguonDonHang,
    "idDoanhNghiep": idDoanhNghiep,
    "nguonDonHang": nguonDonHang,
  };
}
