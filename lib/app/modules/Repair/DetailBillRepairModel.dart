import 'dart:convert';

DetailBillRepairModel detailBillRepairModelFromJson(String str) => DetailBillRepairModel.fromJson(json.decode(str));

String detailBillRepairModelToJson(DetailBillRepairModel data) => json.encode(data.toJson());

class DetailBillRepairModel {
  DetailBillRepairModel({
    this.id,
    this.idPhieuSuaChua,
    this.idSanPham,
    this.tenSanPham,
    this.imei,
    this.trangThai,
    this.thanhTien,
    this.inBienNhan,
    this.ngayBienNhan,
    this.inBienTra,
    this.ngayBienTra,
    this.createBy,
    this.updateBy,
    this.soLuong,
    this.donGia,
    this.chiTietSuaChuaDichVu,
  });

  int? id;
  int? idPhieuSuaChua;
  int? idSanPham;
  String? tenSanPham;
  String? imei;
  String? trangThai;
  int? thanhTien;
  bool? inBienNhan;
  dynamic ngayBienNhan;
  bool? inBienTra;
  dynamic ngayBienTra;
  int? createBy;
  dynamic updateBy;
  int? soLuong;
  dynamic donGia;
  List<ChiTietSuaChuaDichVu>? chiTietSuaChuaDichVu;

  factory DetailBillRepairModel.fromJson(Map<String, dynamic> json) => DetailBillRepairModel(
    id: json["id"],
    idPhieuSuaChua: json["id_PhieuSuaChua"],
    idSanPham: json["id_SanPham"],
    tenSanPham: json["tenSanPham"],
    imei: json["imei"],
    trangThai: json["trangThai"],
    thanhTien: json["thanhTien"],
    inBienNhan: json["inBienNhan"],
    ngayBienNhan: json["ngayBienNhan"],
    inBienTra: json["inBienTra"],
    ngayBienTra: json["ngayBienTra"],
    createBy: json["createBy"],
    updateBy: json["updateBy"],
    soLuong: json["soLuong"],
    donGia: json["donGia"],
    chiTietSuaChuaDichVu: json["chiTiet_SuaChua_DichVu"] ? [] : List<ChiTietSuaChuaDichVu>.from(json["chiTiet_SuaChua_DichVu"].map((x) => ChiTietSuaChuaDichVu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_PhieuSuaChua": idPhieuSuaChua,
    "id_SanPham": idSanPham,
    "tenSanPham": tenSanPham,
    "imei": imei,
    "trangThai": trangThai,
    "thanhTien": thanhTien,
    "inBienNhan": inBienNhan,
    "ngayBienNhan": ngayBienNhan,
    "inBienTra": inBienTra,
    "ngayBienTra": ngayBienTra,
    "createBy": createBy,
    "updateBy": updateBy,
    "soLuong": soLuong,
    "donGia": donGia,
    "chiTiet_SuaChua_DichVu": List<dynamic>.from(chiTietSuaChuaDichVu!.map((x) => x.toJson())),
  };
}

class ChiTietSuaChuaDichVu {
  ChiTietSuaChuaDichVu({
    this.id,
    this.idChiTietPhieuSuaChua,
    this.idDichVu,
    this.tenDichVu,
    this.donGia,
    this.trangThai,
    this.createBy,
    this.updateBy,
    this.ghiChu,
    this.deadLine,
    this.fromBaoHanh,
    this.toBaoHanh,
    this.ktvThucHien,
    this.tenKtvThucHien,
    this.soLuong,
    this.thanhTien,
    this.chiTietSuaChuaDichVuSanPham,
  });

  int? id;
  int? idChiTietPhieuSuaChua;
  String? idDichVu;
  String? tenDichVu;
  dynamic donGia;
  String? trangThai;
  int? createBy;
  dynamic updateBy;
  String? ghiChu;
  dynamic deadLine;
  dynamic fromBaoHanh;
  dynamic toBaoHanh;
  dynamic ktvThucHien;
  String? tenKtvThucHien;
  int? soLuong;
  int? thanhTien;
  List<ChiTietSuaChuaDichVuSanPham>? chiTietSuaChuaDichVuSanPham;

  factory ChiTietSuaChuaDichVu.fromJson(Map<String, dynamic> json) => ChiTietSuaChuaDichVu(
    id: json["id"],
    idChiTietPhieuSuaChua: json["id_ChiTietPhieuSuaChua"],
    idDichVu: json["id_DichVu"],
    tenDichVu: json["tenDichVu"],
    donGia: json["donGia"],
    trangThai: json["trangThai"],
    createBy: json["createBy"],
    updateBy: json["updateBy"],
    ghiChu: json["ghiChu"],
    deadLine: json["deadLine"],
    fromBaoHanh: json["fromBaoHanh"],
    toBaoHanh: json["toBaoHanh"],
    ktvThucHien: json["ktvThucHien"],
    tenKtvThucHien: json["tenKtvThucHien"],
    soLuong: json["soLuong"],
    thanhTien: json["thanhTien"],
    chiTietSuaChuaDichVuSanPham: List<ChiTietSuaChuaDichVuSanPham>.from(json["chiTiet_SuaChua_DichVu_SanPham"].map((x) => ChiTietSuaChuaDichVuSanPham.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_ChiTietPhieuSuaChua": idChiTietPhieuSuaChua,
    "id_DichVu": idDichVu,
    "tenDichVu": tenDichVu,
    "donGia": donGia,
    "trangThai": trangThai,
    "createBy": createBy,
    "updateBy": updateBy,
    "ghiChu": ghiChu,
    "deadLine": deadLine,
    "fromBaoHanh": fromBaoHanh,
    "toBaoHanh": toBaoHanh,
    "ktvThucHien": ktvThucHien,
    "tenKtvThucHien": tenKtvThucHien,
    "soLuong": soLuong,
    "thanhTien": thanhTien,
    "chiTiet_SuaChua_DichVu_SanPham": List<dynamic>.from(chiTietSuaChuaDichVuSanPham!.map((x) => x.toJson())),
  };
}

class ChiTietSuaChuaDichVuSanPham {
  ChiTietSuaChuaDichVuSanPham({
    this.id,
    this.idChitietSuaChuaDichVu,
    this.idSanPham,
    this.tenSanPham,
    this.soLuong,
    this.donGia,
    this.thanhTien,
    this.trangThai,
    this.ghiChu,
    this.soLuongThieu,
    this.daXuatKho,
  });

  int? id;
  int? idChitietSuaChuaDichVu;
  int? idSanPham;
  String? tenSanPham;
  int? soLuong;
  dynamic donGia;
  dynamic thanhTien;
  String? trangThai;
  String? ghiChu;
  int? soLuongThieu;
  bool? daXuatKho;

  factory ChiTietSuaChuaDichVuSanPham.fromJson(Map<String, dynamic> json) => ChiTietSuaChuaDichVuSanPham(
    id: json["id"],
    idChitietSuaChuaDichVu: json["id_Chitiet_SuaChua_DichVu"],
    idSanPham: json["id_SanPham"],
    tenSanPham: json["tenSanPham"],
    soLuong: json["soLuong"],
    donGia: json["donGia"],
    thanhTien: json["thanhTien"],
    trangThai: json["trangThai"],
    ghiChu: json["ghiChu"],
    soLuongThieu: json["soLuongThieu"],
    daXuatKho: json["daXuatKho"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_Chitiet_SuaChua_DichVu": idChitietSuaChuaDichVu,
    "id_SanPham": idSanPham,
    "tenSanPham": tenSanPham,
    "soLuong": soLuong,
    "donGia": donGia,
    "thanhTien": thanhTien,
    "trangThai": trangThai,
    "ghiChu": ghiChu,
    "soLuongThieu": soLuongThieu,
    "daXuatKho": daXuatKho,
  };
}
