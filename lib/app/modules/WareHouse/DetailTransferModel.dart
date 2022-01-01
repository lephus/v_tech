// To parse this JSON data, do
//
//     final detailTransferModel = detailTransferModelFromJson(jsonString);

import 'dart:convert';

DetailTransferModel detailTransferModelFromJson(String str) => DetailTransferModel.fromJson(json.decode(str));

String detailTransferModelToJson(DetailTransferModel data) => json.encode(data.toJson());

class DetailTransferModel {
  DetailTransferModel({
    this.id,
    this.idCuaHangXuat,
    this.tenCuaHangXuat,
    this.hotlineCuaHangXuat,
    this.idCuaHangNhap,
    this.tenCuaHangNhap,
    this.ghiChu,
    this.nguoiGui,
    this.nguoiNhan,
    this.idNhanVienDuyet,
    this.tenNhanVienDuyet,
    this.idNhanVienXacNhan,
    this.tenNhanVienXacNhan,
    this.tenNhanVienLapPhieu,
    this.createdDate,
    this.duyet,
    this.xacNhan,
    this.ngayDuyet,
    this.ngayXacNhan,
    this.soLuongSanPham,
    this.tongSoLuongSanPham,
    this.tongTien,
    this.createdBy,
    this.saveChiTietYeuCauInput,
  });

  int? id;
  int? idCuaHangXuat;
  String? tenCuaHangXuat;
  dynamic hotlineCuaHangXuat;
  int? idCuaHangNhap;
  String? tenCuaHangNhap;
  String? ghiChu;
  String? nguoiGui;
  String? nguoiNhan;
  int? idNhanVienDuyet;
  dynamic tenNhanVienDuyet;
  int? idNhanVienXacNhan;
  String? tenNhanVienXacNhan;
  String? tenNhanVienLapPhieu;
  DateTime? createdDate;
  bool? duyet;
  bool? xacNhan;
  DateTime? ngayDuyet;
  DateTime? ngayXacNhan;
  int? soLuongSanPham;
  int? tongSoLuongSanPham;
  int? tongTien;
  int? createdBy;
  List<SaveChiTietYeuCauInput>? saveChiTietYeuCauInput;

  factory DetailTransferModel.fromJson(Map<String, dynamic> json) => DetailTransferModel(
    id: json["id"],
    idCuaHangXuat: json["id_CuaHangXuat"],
    tenCuaHangXuat: json["ten_CuaHangXuat"],
    hotlineCuaHangXuat: json["hotline_CuaHangXuat"],
    idCuaHangNhap: json["id_CuaHangNhap"],
    tenCuaHangNhap: json["ten_CuaHangNhap"],
    ghiChu: json["ghiChu"],
    nguoiGui: json["nguoiGui"],
    nguoiNhan: json["nguoiNhan"],
    idNhanVienDuyet: json["id_NhanVienDuyet"],
    tenNhanVienDuyet: json["ten_NhanVienDuyet"],
    idNhanVienXacNhan: json["id_NhanVienXacNhan"],
    tenNhanVienXacNhan: json["ten_NhanVienXacNhan"],
    tenNhanVienLapPhieu: json["ten_NhanVienLapPhieu"],
    createdDate: DateTime.parse(json["createdDate"]),
    duyet: json["duyet"],
    xacNhan: json["xacNhan"],
    ngayDuyet: json["ngayDuyet"] == null ? null : DateTime.parse(json["ngayDuyet"]),
    ngayXacNhan: json["ngayXacNhan"] == null ? null : DateTime.parse(json["ngayXacNhan"]),
    soLuongSanPham: json["soLuongSanPham"],
    tongSoLuongSanPham: json["tongSoLuongSanPham"],
    tongTien: json["tongTien"],
    createdBy: json["createdBy"],
    saveChiTietYeuCauInput: List<SaveChiTietYeuCauInput>.from(json["saveChiTietYeuCauInput"].map((x) => SaveChiTietYeuCauInput.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_CuaHangXuat": idCuaHangXuat,
    "ten_CuaHangXuat": tenCuaHangXuat,
    "hotline_CuaHangXuat": hotlineCuaHangXuat,
    "id_CuaHangNhap": idCuaHangNhap,
    "ten_CuaHangNhap": tenCuaHangNhap,
    "ghiChu": ghiChu,
    "nguoiGui": nguoiGui,
    "nguoiNhan": nguoiNhan,
    "id_NhanVienDuyet": idNhanVienDuyet,
    "ten_NhanVienDuyet": tenNhanVienDuyet,
    "id_NhanVienXacNhan": idNhanVienXacNhan,
    "ten_NhanVienXacNhan": tenNhanVienXacNhan,
    "ten_NhanVienLapPhieu": tenNhanVienLapPhieu,
    "createdDate": createdDate.toString(),
    "duyet": duyet,
    "xacNhan": xacNhan,
    "ngayDuyet": ngayDuyet.toString(),
    "ngayXacNhan": ngayXacNhan.toString(),
    "soLuongSanPham": soLuongSanPham,
    "tongSoLuongSanPham": tongSoLuongSanPham,
    "tongTien": tongTien,
    "createdBy": createdBy,
    "saveChiTietYeuCauInput": List<dynamic>.from(saveChiTietYeuCauInput!.map((x) => x.toJson())),
  };
}

class SaveChiTietYeuCauInput {
  SaveChiTietYeuCauInput({
    this.id,
    this.idSanPham,
    this.maSanPham,
    this.maVach,
    this.tenSanPham,
    this.soLuong,
    this.sanPhamLoi,
    this.soLuongDuyet,
    this.soLuongXnk,
    this.giaSanPham,
    this.loaiLoi,
    this.lichSuThaoTacResponse,
  });

  int? id;
  int? idSanPham;
  String? maSanPham;
  String? maVach;
  String? tenSanPham;
  int? soLuong;
  int? sanPhamLoi;
  int? soLuongDuyet;
  int? soLuongXnk;
  double? giaSanPham;
  dynamic loaiLoi;
  dynamic lichSuThaoTacResponse;

  factory SaveChiTietYeuCauInput.fromJson(Map<String, dynamic> json) => SaveChiTietYeuCauInput(
    id: json["id"],
    idSanPham: json["id_SanPham"],
    maSanPham: json["maSanPham"],
    maVach: json["maVach"],
    tenSanPham: json["tenSanPham"],
    soLuong: json["soLuong"],
    sanPhamLoi: json["sanPhamLoi"],
    soLuongDuyet: json["soLuongDuyet"],
    soLuongXnk: json["soLuongXNK"],
    giaSanPham: double.parse(json["giaSanPham"].toString()),
    loaiLoi: json["loaiLoi"],
    lichSuThaoTacResponse: json["lichSuThaoTacResponse"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_SanPham": idSanPham,
    "maSanPham": maSanPham,
    "maVach": maVach,
    "tenSanPham": tenSanPham,
    "soLuong": soLuong,
    "sanPhamLoi": sanPhamLoi,
    "soLuongDuyet": soLuongDuyet,
    "soLuongXNK": soLuongXnk,
    "giaSanPham": giaSanPham,
    "loaiLoi": loaiLoi,
    "lichSuThaoTacResponse":lichSuThaoTacResponse,
  };
}
