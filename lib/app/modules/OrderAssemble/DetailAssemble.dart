import 'dart:convert';

DetailAssembleModel detailAssembleModelFromJson(String str) => DetailAssembleModel.fromJson(json.decode(str));

String detailAssembleModelToJson(DetailAssembleModel data) => json.encode(data.toJson());

class DetailAssembleModel {
  DetailAssembleModel({
    this.tenNhanVien,
    this.tongSoLuong,
    this.id,
    this.idSanPham,
    this.tongSoTien,
    this.lstTenDichVu,
    this.tenDichVu,
    this.updatedBy,
    this.createdBy,
    this.lastUpdatedDate,
    this.createdDate,
    this.chiTiets,
  });

  String? tenNhanVien;
  int? tongSoLuong;
  int? id;
  int? idSanPham;
  double? tongSoTien;
  dynamic lstTenDichVu;
  String? tenDichVu;
  int? updatedBy;
  int? createdBy;
  DateTime? lastUpdatedDate;
  dynamic createdDate;
  List<ChiTiet>? chiTiets;

  factory DetailAssembleModel.fromJson(Map<String, dynamic> json) => DetailAssembleModel(
    tenNhanVien: json["tenNhanVien"],
    tongSoLuong: json["tongSoLuong"],
    id: json["id"],
    idSanPham: json["id_SanPham"],
    tongSoTien: json["tongSoTien"],
    lstTenDichVu: json["lstTenDichVu"],
    tenDichVu: json["tenDichVu"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
    createdDate: json["createdDate"],
    chiTiets: List<ChiTiet>.from(json["chiTiets"].map((x) => ChiTiet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tenNhanVien": tenNhanVien,
    "tongSoLuong": tongSoLuong,
    "id": id,
    "id_SanPham": idSanPham,
    "tongSoTien": tongSoTien,
    "lstTenDichVu": lstTenDichVu,
    "tenDichVu": tenDichVu,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "lastUpdatedDate": lastUpdatedDate.toString(),
    "createdDate": createdDate,
    "chiTiets": List<dynamic>.from(chiTiets!.map((x) => x.toJson())),
  };
}

class ChiTiet {
  ChiTiet({
    this.idDonHangLapRap,
    this.idLapRap,
    this.tenDichVu,
    this.soLuong,
    this.donGia,
    this.thanhTien,
  });

  int? idDonHangLapRap;
  int? idLapRap;
  String? tenDichVu;
  int? soLuong;
  double? donGia;
  int? thanhTien;

  factory ChiTiet.fromJson(Map<String, dynamic> json) => ChiTiet(
    idDonHangLapRap: json["id_DonHangLapRap"],
    idLapRap: json["id_LapRap"],
    tenDichVu: json["tenDichVu"],
    soLuong: json["soLuong"],
    donGia: json["donGia"],
    thanhTien: json["thanhTien"],
  );

  Map<String, dynamic> toJson() => {
    "id_DonHangLapRap": idDonHangLapRap,
    "id_LapRap": idLapRap,
    "tenDichVu": tenDichVu,
    "soLuong": soLuong,
    "donGia": donGia,
    "thanhTien": thanhTien,
  };
}
