import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.idDoanhNghiep,
    this.id,
    this.taiKhoan,
    this.ten,
    this.dienThoai,
    this.email,
    this.trangThaiHoaDonMacDinh,
    this.hinhThucVanChuyenMacDinh,
    this.trangThaiHoaDonDichVuMacDinh,
    this.token,
    this.roles,
    this.createdDate,
    this.idCuaHang,
    this.tenCuaHang,
    this.idKhachHang,
    this.idChucVu,
    this.tenChucVu,
    this.maChucVu,
  });

  int? idDoanhNghiep;
  int? id;
  String? taiKhoan;
  String? ten;
  String? dienThoai;
  String? email;
  String? trangThaiHoaDonMacDinh;
  String? hinhThucVanChuyenMacDinh;
  String? trangThaiHoaDonDichVuMacDinh;
  dynamic token;
  List<Role>? roles;
  DateTime? createdDate;
  int? idCuaHang;
  String? tenCuaHang;
  int? idKhachHang;
  int? idChucVu;
  String? tenChucVu;
  String? maChucVu;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    idDoanhNghiep: json["id_DoanhNghiep"],
    id: json["id"],
    taiKhoan: json["taiKhoan"],
    ten: json["ten"],
    dienThoai: json["dienThoai"],
    email: json["email"],
    trangThaiHoaDonMacDinh: json["trangThaiHoaDonMacDinh"],
    hinhThucVanChuyenMacDinh: json["hinhThucVanChuyenMacDinh"],
    trangThaiHoaDonDichVuMacDinh: json["trangThaiHoaDonDichVuMacDinh"],
    token: json["token"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    createdDate: DateTime.parse(json["createdDate"]),
    idCuaHang: json["id_CuaHang"],
    tenCuaHang: json["tenCuaHang"],
    idKhachHang: json["id_KhachHang"],
    idChucVu: json["id_ChucVu"],
    tenChucVu: json["ten_ChucVu"],
    maChucVu: json["ma_ChucVu"],
  );

  Map<String, dynamic> toJson() => {
    "id_DoanhNghiep": idDoanhNghiep,
    "id": id,
    "taiKhoan": taiKhoan,
    "ten": ten,
    "dienThoai": dienThoai,
    "email": email,
    "trangThaiHoaDonMacDinh": trangThaiHoaDonMacDinh,
    "hinhThucVanChuyenMacDinh": hinhThucVanChuyenMacDinh,
    "trangThaiHoaDonDichVuMacDinh": trangThaiHoaDonDichVuMacDinh,
    "token": token,
    "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
    "createdDate": createdDate.toString(),
    "id_CuaHang": idCuaHang,
    "tenCuaHang": tenCuaHang,
    "id_KhachHang": idKhachHang,
    "id_ChucVu": idChucVu,
    "ten_ChucVu": tenChucVu,
    "ma_ChucVu": maChucVu,
  };
}

class Role {
  Role({
    this.id,
    this.ten,
  });

  int? id;
  String? ten;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    ten: json["ten"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten": ten,
  };
}
