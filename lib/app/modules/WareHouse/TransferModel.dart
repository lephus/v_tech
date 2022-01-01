
import 'dart:convert';

TransferModel transferModelFromJson(String str) => TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) => json.encode(data.toJson());

class TransferModel {
  TransferModel({
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
    this.album,
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
  String? tenNhanVienDuyet;
  int? idNhanVienXacNhan;
  String? tenNhanVienXacNhan;
  String? tenNhanVienLapPhieu;
  DateTime? createdDate;
  bool? duyet;
  bool? xacNhan;
  DateTime? ngayDuyet;
  dynamic ngayXacNhan;
  int? soLuongSanPham;
  double? tongSoLuongSanPham;
  double? tongTien;
  int? createdBy;
  dynamic saveChiTietYeuCauInput;
  List<Album>? album;

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
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
    tongSoLuongSanPham: double.parse(json["tongSoLuongSanPham"].toString()),
    tongTien: double.parse(json["tongTien"].toString()),
    createdBy: json["createdBy"],
    saveChiTietYeuCauInput: json["saveChiTietYeuCauInput"],
    album: List<Album>.from(json["album"].map((x) => Album.fromJson(x))),
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
    "saveChiTietYeuCauInput": saveChiTietYeuCauInput,
    "album": List<dynamic>.from(album!.map((x) => x.toJson())),
  };
}

class Album {
  Album({
    this.id,
    this.name,
    this.url,
  });

  int? id;
  String? name;
  String? url;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}
