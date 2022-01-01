import 'dart:convert';
DetailRepairModel detailRepairModelFromJson(String str) => DetailRepairModel.fromJson(json.decode(str));
String detailRepairModelToJson(DetailRepairModel data) => json.encode(data.toJson());

class DetailRepairModel {
  DetailRepairModel({
    this.idSuaChua,
    this.idPhieu,
    this.loaiyeuCau,
    this.idDichVu,
    this.tenDichVu,
    this.idSanPham,
    this.tenSanPham,
    this.imei,
    this.deadLine,
    this.donGia,
    this.thanhTien,
    this.trangThai,
    this.ghiChu,
  });

  int? idSuaChua;
  int? idPhieu;
  String? loaiyeuCau;
  int? idDichVu;
  String? tenDichVu;
  int? idSanPham;
  String? tenSanPham;
  String? imei;
  dynamic deadLine;
  dynamic donGia;
  dynamic thanhTien;
  String? trangThai;
  String? ghiChu;

  factory DetailRepairModel.fromJson(Map<String, dynamic> json) => DetailRepairModel(
    idSuaChua: json["id_SuaChua"],
    idPhieu: json["id_Phieu"],
    loaiyeuCau: json["loaiyeuCau"],
    idDichVu: json["id_DichVu"],
    tenDichVu: json["tenDichVu"],
    idSanPham: json["id_SanPham"],
    tenSanPham: json["tenSanPham"],
    imei: json["imei"],
    deadLine: json["deadLine"],
    donGia: json["donGia"],
    thanhTien: json["thanhTien"],
    trangThai: json["trangThai"],
    ghiChu: json["ghiChu"],
  );

  Map<String, dynamic> toJson() => {
    "id_SuaChua": idSuaChua,
    "id_Phieu": idPhieu,
    "loaiyeuCau": loaiyeuCau,
    "id_DichVu": idDichVu,
    "tenDichVu": tenDichVu,
    "id_SanPham": idSanPham,
    "tenSanPham": tenSanPham,
    "imei": imei,
    "deadLine": deadLine,
    "donGia": donGia,
    "thanhTien": thanhTien,
    "trangThai": trangThai,
    "ghiChu": ghiChu,
  };
}
