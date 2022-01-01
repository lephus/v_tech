// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  CustomerModel({
    this.id,
    this.tenDayDu,
    this.soDienThoai,
    this.email,
    this.facebook,
    this.ngaySinh,
    this.gioiTinh,
    this.diaChi,
    this.thanhPho,
    this.quanHuyen,
    this.phuongXa,
    this.idTinh,
    this.idHuyen,
    this.idXa,
    this.idLoaiKhachHang,
    this.tenLoaiKhachHang,
    this.congTy,
    this.maSoThue,
    this.chungMinhNhanDan,
    this.ghiChu,
    this.idNhanVienPhuTrach,
    this.anhDaiDien,
    this.tongTien,
    this.soLanMua,
    this.soLuongSanPhamMua,
    this.diem,
    this.idKhachHangGioiThieu,
    this.congNo,
    this.gioiHanCongNo,
    this.daTieu,
    this.daTra,
    this.conNo,
    this.qHKhachHangThe,
    this.selectHuyenList,
    this.selectXaList,
  });

  int? id;
  String? tenDayDu;
  String? soDienThoai;
  dynamic email;
  dynamic facebook;
  dynamic ngaySinh;
  dynamic gioiTinh;
  dynamic diaChi;
  dynamic thanhPho;
  dynamic quanHuyen;
  dynamic phuongXa;
  int? idTinh;
  dynamic idHuyen;
  dynamic idXa;
  int? idLoaiKhachHang;
  String? tenLoaiKhachHang;
  dynamic congTy;
  dynamic maSoThue;
  dynamic chungMinhNhanDan;
  String? ghiChu;
  dynamic idNhanVienPhuTrach;
  dynamic anhDaiDien;
  dynamic tongTien;
  int? soLanMua;
  int? soLuongSanPhamMua;
  dynamic diem;
  dynamic idKhachHangGioiThieu;
  double? congNo;
  double? gioiHanCongNo;
  int? daTieu;
  dynamic daTra;
  dynamic conNo;
  dynamic qHKhachHangThe;
  dynamic selectHuyenList;
  dynamic selectXaList;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    id: json["id"],
    tenDayDu: json["tenDayDu"],
    soDienThoai: json["soDienThoai"],
    email: json["email"],
    facebook: json["facebook"],
    ngaySinh: json["ngaySinh"],
    gioiTinh: json["gioiTinh"],
    diaChi: json["diaChi"],
    thanhPho: json["thanhPho"],
    quanHuyen: json["quanHuyen"],
    phuongXa: json["phuongXa"],
    idTinh: json["idTinh"],
    idHuyen: json["idHuyen"],
    idXa: json["idXa"],
    idLoaiKhachHang: json["id_LoaiKhachHang"],
    tenLoaiKhachHang: json["ten_LoaiKhachHang"],
    congTy: json["congTy"],
    maSoThue: json["maSoThue"],
    chungMinhNhanDan: json["chungMinhNhanDan"],
    ghiChu: json["ghiChu"],
    idNhanVienPhuTrach: json["id_NhanVienPhuTrach"],
    anhDaiDien: json["anhDaiDien"],
    tongTien: json["tongTien"] ?? 0.0,
    soLanMua: json["soLanMua"] ?? 0,
    soLuongSanPhamMua: json["soLuongSanPhamMua"],
    diem: json["diem"],
    idKhachHangGioiThieu: json["id_KhachHangGioiThieu"],
    congNo: json["congNo"] ?? 0,
    gioiHanCongNo: json["gioiHanCongNo"] ?? 0.0,
    daTieu: json["daTieu"]?? 0,
    daTra: json["daTra"] ?? 0,
    conNo: json["conNo"] ?? 0,
    qHKhachHangThe: json["qH_KhachHang_The"],
    selectHuyenList: json["selectHuyenList"],
    selectXaList: json["selectXaList"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tenDayDu": tenDayDu,
    "soDienThoai": soDienThoai,
    "email": email,
    "facebook": facebook,
    "ngaySinh": ngaySinh,
    "gioiTinh": gioiTinh,
    "diaChi": diaChi,
    "thanhPho": thanhPho,
    "quanHuyen": quanHuyen,
    "phuongXa": phuongXa,
    "idTinh": idTinh,
    "idHuyen": idHuyen,
    "idXa": idXa,
    "id_LoaiKhachHang": idLoaiKhachHang,
    "ten_LoaiKhachHang": tenLoaiKhachHang,
    "congTy": congTy,
    "maSoThue": maSoThue,
    "chungMinhNhanDan": chungMinhNhanDan,
    "ghiChu": ghiChu,
    "id_NhanVienPhuTrach": idNhanVienPhuTrach,
    "anhDaiDien": anhDaiDien,
    "tongTien": tongTien,
    "soLanMua": soLanMua,
    "soLuongSanPhamMua": soLuongSanPhamMua,
    "diem": diem,
    "id_KhachHangGioiThieu": idKhachHangGioiThieu,
    "congNo": congNo,
    "gioiHanCongNo": gioiHanCongNo,
    "daTieu": daTieu,
    "daTra": daTra,
    "conNo": conNo,
    "qH_KhachHang_The": qHKhachHangThe,
    "selectHuyenList": selectHuyenList,
    "selectXaList": selectXaList,
  };
}
