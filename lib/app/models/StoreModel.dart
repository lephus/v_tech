class CuaHangModel {
  int? idDoanhNghiep;
  int? id;
  String? ten;
  String? diaChi;
  String? dienThoai;

  CuaHangModel(
      {this.idDoanhNghiep, this.id, this.ten, this.diaChi, this.dienThoai});

  factory CuaHangModel.fromJson(Map<String, dynamic> json) {
    return CuaHangModel(
        idDoanhNghiep: json['id_DoanhNghiep'],
        id: json['id'],
        ten: json['ten'],
        diaChi: json['diaChi'],
        dienThoai: json['dienThoai']);
  }
}