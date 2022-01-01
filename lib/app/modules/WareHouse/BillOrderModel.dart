import 'dart:convert';
BillOrderModel billOrderModelFromJson(String str) => BillOrderModel.fromJson(json.decode(str));
String billOrderModelToJson(BillOrderModel data) => json.encode(data.toJson());
class BillOrderModel {
  BillOrderModel({
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
  dynamic tenNhanVienKinhDoanh;
  String? nguoiGui;
  String? nguoiNhan;
  String? ghiChu;
  double? giaTienTe;
  bool? duyet;
  bool? xacNhan;
  int? soLuongSanPham;
  int? tongSoLuongSanPham;
  int? tongSoLuongDuyet;
  double? tongTien;
  int? createdBy;
  String? tenCreatedBy;
  DateTime? createdDate;
  int? idNhanVienXacNhan;
  String? tenNhanVienXacNhan;
  dynamic ngayXacNhan;
  dynamic chiTietSanPham;

  factory BillOrderModel.fromJson(Map<dynamic, dynamic> json) => BillOrderModel(
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
    tongTien: double.parse(json["tongTien"].toString()),
    createdBy: json["createdBy"],
    tenCreatedBy: json["ten_CreatedBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    idNhanVienXacNhan: json["id_NhanVienXacNhan"],
    tenNhanVienXacNhan: json["ten_NhanVienXacNhan"],
    ngayXacNhan: json["ngayXacNhan"] == null ? null : DateTime.parse(json["ngayXacNhan"]),
    chiTietSanPham: json["chiTietSanPham"],
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
    "ngayXacNhan": ngayXacNhan.toString(),
    "chiTietSanPham": chiTietSanPham,
  };
}
