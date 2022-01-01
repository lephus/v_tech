// To parse this JSON data, do
//
//     final detailBillOrderModel = detailBillOrderModelFromJson(jsonString);

import 'dart:convert';

DetailBillOrderModel detailBillOrderModelFromJson(String str) => DetailBillOrderModel.fromJson(json.decode(str));

String detailBillOrderModelToJson(DetailBillOrderModel data) => json.encode(data.toJson());

class DetailBillOrderModel {
  DetailBillOrderModel({
    this.id,
    this.loai,
    this.idNhaCungCap,
    this.idCuaHang,
    this.soLo,
    this.idNhanVienKinhDoanh,
    this.tenNhaCungCap,
    this.tenCuaHang,
    this.tenNhanVienKinhDoanh,
    this.nguoiGui,
    this.nguoiNhan,
    this.ghiChu,
    this.giaTienTe,
    this.duyet,
    this.xacNhan,
    this.soLuongSanPham,
    this.tongSoLuongSanPham,
    this.tongSoLuongDuyet,
    this.tongTien,
    this.createdBy,
    this.tenCreatedBy,
    this.createdDate,
    this.idNhanVienXacNhan,
    this.tenNhanVienXacNhan,
    this.ngayXacNhan,
    this.chiTietSanPham,
  });

  int? id;
  String? loai;
  int? idNhaCungCap;
  int? idCuaHang;
  String? soLo;
  int? idNhanVienKinhDoanh;
  String? tenNhaCungCap;
  String? tenCuaHang;
  String? tenNhanVienKinhDoanh;
  String? nguoiGui;
  String? nguoiNhan;
  String? ghiChu;
  dynamic giaTienTe;
  bool? duyet;
  bool? xacNhan;
  int? soLuongSanPham;
  int? tongSoLuongSanPham;
  int? tongSoLuongDuyet;
  double? tongTien;
  int? createdBy;
  dynamic tenCreatedBy;
  DateTime? createdDate;
  dynamic idNhanVienXacNhan;
  dynamic tenNhanVienXacNhan;
  dynamic ngayXacNhan;
  List<ChiTietSanPham>? chiTietSanPham;

  factory DetailBillOrderModel.fromJson(Map<String, dynamic> json) => DetailBillOrderModel(
    id: json["id"],
    loai: json["loai"],
    idNhaCungCap: json["id_NhaCungCap"],
    idCuaHang: json["id_CuaHang"],
    soLo: json["soLo"],
    idNhanVienKinhDoanh: json["id_NhanVienKinhDoanh"],
    tenNhaCungCap: json["tenNhaCungCap"],
    tenCuaHang: json["tenCuaHang"],
    tenNhanVienKinhDoanh: json["ten_NhanVienKinhDoanh"],
    nguoiGui: json["nguoiGui"],
    nguoiNhan: json["nguoiNhan"],
    ghiChu: json["ghiChu"],
    giaTienTe: json["giaTienTe"],
    duyet: json["duyet"],
    xacNhan: json["xacNhan"],
    soLuongSanPham: json["soLuongSanPham"],
    tongSoLuongSanPham: json["tongSoLuongSanPham"],
    tongSoLuongDuyet: json["tongSoLuongDuyet"],
    tongTien: json["tongTien"],
    createdBy: json["createdBy"],
    tenCreatedBy: json["ten_CreatedBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    idNhanVienXacNhan: json["id_NhanVienXacNhan"],
    tenNhanVienXacNhan: json["ten_NhanVienXacNhan"],
    ngayXacNhan: json["ngayXacNhan"],
    chiTietSanPham: List<ChiTietSanPham>.from(json["chiTietSanPham"].map((x) => ChiTietSanPham.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loai": loai,
    "id_NhaCungCap": idNhaCungCap,
    "id_CuaHang": idCuaHang,
    "soLo": soLo,
    "id_NhanVienKinhDoanh": idNhanVienKinhDoanh,
    "tenNhaCungCap": tenNhaCungCap,
    "tenCuaHang": tenCuaHang,
    "ten_NhanVienKinhDoanh": tenNhanVienKinhDoanh,
    "nguoiGui": nguoiGui,
    "nguoiNhan": nguoiNhan,
    "ghiChu": ghiChu,
    "giaTienTe": giaTienTe,
    "duyet": duyet,
    "xacNhan": xacNhan,
    "soLuongSanPham": soLuongSanPham,
    "tongSoLuongSanPham": tongSoLuongSanPham,
    "tongSoLuongDuyet": tongSoLuongDuyet,
    "tongTien": tongTien,
    "createdBy": createdBy,
    "ten_CreatedBy": tenCreatedBy,
    "createdDate": createdDate.toString(),
    "id_NhanVienXacNhan": idNhanVienXacNhan,
    "ten_NhanVienXacNhan": tenNhanVienXacNhan,
    "ngayXacNhan": ngayXacNhan,
    "chiTietSanPham": List<dynamic>.from(chiTietSanPham!.map((x) => x.toJson())),
  };
}

class ChiTietSanPham {
  ChiTietSanPham({
    this.id,
    this.idSanPham,
    this.tenSanPham,
    this.soLuong,
    this.soLuongDuyet,
    this.giaYeuCau,
    this.giaSanPham,
    this.moTa,
  });

  int? id;
  int? idSanPham;
  String? tenSanPham;
  int? soLuong;
  int? soLuongDuyet;
  dynamic giaYeuCau;
  dynamic giaSanPham;
  dynamic moTa;

  factory ChiTietSanPham.fromJson(Map<String, dynamic> json) => ChiTietSanPham(
    id: json["id"],
    idSanPham: json["id_SanPham"],
    tenSanPham: json["ten_SanPham"],
    soLuong: json["soLuong"],
    soLuongDuyet: json["soLuongDuyet"],
    giaYeuCau: json["giaYeuCau"],
    giaSanPham: json["giaSanPham"],
    moTa: json["moTa"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_SanPham": idSanPham,
    "ten_SanPham": tenSanPham,
    "soLuong": soLuong,
    "soLuongDuyet": soLuongDuyet,
    "giaYeuCau": giaYeuCau,
    "giaSanPham": giaSanPham,
    "moTa": moTa,
  };
}
