import 'package:v_tech/app/models/role.dart';
class User {
  int? idDoanhNghiep;
  int? id;
  int? idKhachHang;
  int? storeId;
  String? taiKhoan;
  String? ten;
  String? dienThoai;
  String? email;
  String? token;
  List<Role>? role;
  String? createdDate;

  User(
      { this.idDoanhNghiep,
        this.id,
        this.idKhachHang,
        this.storeId,
        this.taiKhoan,
        this.ten,
        this.dienThoai,
        this.email,
        this.token,
        this.role,
        this.createdDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idDoanhNghiep: json['id_DoanhNghiep'] == null ? "" : json['id_DoanhNghiep'],
      id: json['id'],
      idKhachHang: json['id_KhachHang'],
      taiKhoan: json['taiKhoan'] == null ? "" : json['taiKhoan'],
      storeId:  json['id_CuaHang'],
      ten: json['ten'] == null ? "" : json['ten'],
      dienThoai: json['dienThoai'] == null ? "" : json['dienThoai'],
      email: json['email'] == null ? "" : json['email'],
      token: json['token'],
      role: List<Role>.from(json['roles'].map((x) => Role.fromJson(x))),
      createdDate: json['createdDate'] == null ? "" : json['createdDate'],
    );
  }
  Map<String, dynamic> toMap() => {
    'idDoanhNghiep':idDoanhNghiep,
    'id':id,
    'idKhachHang':idKhachHang,
    'storeId': storeId,
    'taiKhoan':taiKhoan,
    'ten':ten,
    'dienThoai':dienThoai,
    'email':email,
    'token':token,
    'role':role.toString(),
    'createdDate':createdDate
  };
}
