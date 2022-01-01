// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.idDoanhNghiep,
    this.id,
    this.ten,
    this.tenKhac,
    this.ma,
    this.idSanPhamCha,
    this.maVach,
    this.idTrangThai,
    this.idLoaiSanPham,
    this.anhSanPham,
    this.vat,
    this.donViSanPham,
    this.soThangBaoHanh,
    this.trangThai,
    this.loaiSanPham,
    this.createdDate,
    this.giaBan,
    this.giaBanTheoCuaHang,
    this.soLuongTheoCuaHang,
    this.tonKho,
    this.coTheBan,
    this.soLuongLoi,
    this.giaVon,
    this.soLuongChuyenKho,
    this.dangVe,
    this.soLuongDangGiao,
    this.tenSanPhamCha,
    this.tonToiThieu,
    this.tonToiDa,
    this.giaBanBuon,
    this.giaBanKhachThan,
    this.giaCuoc,
    this.hang,
    this.keHang,
    this.moTa,
    this.sanPhamTepDinhKems,
    this.danhSachCuaHangTon,
    this.sanPhamCon,
    this.qHAnhSanPham,
  });

  int? idDoanhNghiep;
  int? id;
  String? ten;
  String? tenKhac;
  String? ma;
  int? idSanPhamCha;
  String? maVach;
  int? idTrangThai;
  int? idLoaiSanPham;
  dynamic anhSanPham;
  dynamic vat;
  dynamic donViSanPham;
  dynamic soThangBaoHanh;
  String? trangThai;
  String? loaiSanPham;
  DateTime? createdDate;
  double? giaBan;
  double? giaBanTheoCuaHang;
  int? soLuongTheoCuaHang;
  int? tonKho;
  int? coTheBan;
  int? soLuongLoi;
  dynamic giaVon;
  int? soLuongChuyenKho;
  int? dangVe;
  int? soLuongDangGiao;
  dynamic tenSanPhamCha;
  int? tonToiThieu;
  int? tonToiDa;
  double? giaBanBuon;
  double? giaBanKhachThan;
  double? giaCuoc;
  String? hang;
  String? keHang;
  String? moTa;
  dynamic sanPhamTepDinhKems;
  List<dynamic>? danhSachCuaHangTon;
  List<dynamic>? sanPhamCon;
  List<dynamic>? qHAnhSanPham;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    idDoanhNghiep: json["id_DoanhNghiep"],
    id: json["id"],
    ten: json["ten"],
    tenKhac: json["tenKhac"],
    ma: json["ma"],
    idSanPhamCha: json["id_SanPhamCha"],
    maVach: json["maVach"],
    idTrangThai: json["id_TrangThai"],
    idLoaiSanPham: json["id_LoaiSanPham"],
    anhSanPham: json["anhSanPham"],
    vat: json["vat"],
    donViSanPham: json["donViSanPham"],
    soThangBaoHanh: json["soThangBaoHanh"],
    trangThai: json["trangThai"],
    loaiSanPham: json["loaiSanPham"],
    createdDate: DateTime.parse(json["createdDate"]),
    giaBan: double.parse(json["giaBan"].toString()),
    giaBanTheoCuaHang: double.parse(json["giaBanTheoCuaHang"].toString()),
    soLuongTheoCuaHang: json["soLuongTheoCuaHang"],
    tonKho: json["tonKho"],
    coTheBan: json["coTheBan"],
    soLuongLoi: json["soLuongLoi"],
    giaVon: json["giaVon"],
    soLuongChuyenKho: json["soLuongChuyenKho"],
    dangVe: json["dangVe"],
    soLuongDangGiao: json["soLuongDangGiao"],
    tenSanPhamCha: json["tenSanPhamCha"],
    tonToiThieu: json["tonToiThieu"],
    tonToiDa: json["tonToiDa"],
    giaBanBuon: double.parse(json["giaBanBuon"].toString()),
    giaBanKhachThan:  double.parse(json["giaBanKhachThan"].toString()),
    giaCuoc:  0.0,
    hang: json["hang"],
    keHang: json["keHang"],
    moTa: json["moTa"],
    sanPhamTepDinhKems: json["sanPhamTepDinhKems"],
    danhSachCuaHangTon: List<dynamic>.from(json["danhSachCuaHangTon"].map((x) => x)),
    sanPhamCon: List<dynamic>.from(json["sanPhamCon"].map((x) => x)),
    qHAnhSanPham: List<dynamic>.from(json["qH_AnhSanPham"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id_DoanhNghiep": idDoanhNghiep,
    "id": id,
    "ten": ten,
    "tenKhac": tenKhac,
    "ma": ma,
    "id_SanPhamCha": idSanPhamCha,
    "maVach": maVach,
    "id_TrangThai": idTrangThai,
    "id_LoaiSanPham": idLoaiSanPham,
    "anhSanPham": anhSanPham,
    "vat": vat,
    "donViSanPham": donViSanPham,
    "soThangBaoHanh": soThangBaoHanh,
    "trangThai": trangThai,
    "loaiSanPham": loaiSanPham,
    "createdDate": createdDate.toString(),
    "giaBan": giaBan,
    "giaBanTheoCuaHang": giaBanTheoCuaHang,
    "soLuongTheoCuaHang": soLuongTheoCuaHang,
    "tonKho": tonKho,
    "coTheBan": coTheBan,
    "soLuongLoi": soLuongLoi,
    "giaVon": giaVon,
    "soLuongChuyenKho": soLuongChuyenKho,
    "dangVe": dangVe,
    "soLuongDangGiao": soLuongDangGiao,
    "tenSanPhamCha": tenSanPhamCha,
    "tonToiThieu": tonToiThieu,
    "tonToiDa": tonToiDa,
    "giaBanBuon": giaBanBuon,
    "giaBanKhachThan": giaBanKhachThan,
    "giaCuoc": giaCuoc,
    "hang": hang,
    "keHang": keHang,
    "moTa": moTa,
    "sanPhamTepDinhKems": sanPhamTepDinhKems,
    "danhSachCuaHangTon": List<dynamic>.from(danhSachCuaHangTon!.map((x) => x)),
    "sanPhamCon": List<dynamic>.from(sanPhamCon!.map((x) => x)),
    "qH_AnhSanPham": List<dynamic>.from(qHAnhSanPham!.map((x) => x)),
  };
}
