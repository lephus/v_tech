import 'dart:convert';

AssembleModel assembleModelModelFromJson(String str) => AssembleModel.fromJson(json.decode(str));

String assembleModelModelToJson(AssembleModel data) => json.encode(data.toJson());

class AssembleModel {
  AssembleModel({
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
  List<LstTenDichVu>? lstTenDichVu;
  dynamic tenDichVu;
  int? updatedBy;
  int? createdBy;
  DateTime? lastUpdatedDate;
  DateTime? createdDate;
  List<ChiTiet>? chiTiets;

  factory AssembleModel.fromJson(Map<String, dynamic> json) => AssembleModel(
    tenNhanVien: json["tenNhanVien"],
    tongSoLuong: json["tongSoLuong"],
    id: json["id"],
    idSanPham: json["id_SanPham"],
    tongSoTien: json["tongSoTien"],
    lstTenDichVu: List<LstTenDichVu>.from(json["lstTenDichVu"].map((x) => LstTenDichVu.fromJson(x))),
    tenDichVu: json["tenDichVu"],
    updatedBy: json["updatedBy"],
    createdBy: json["createdBy"],
    lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
    createdDate: DateTime.parse(json["createdDate"]),
    chiTiets: List<ChiTiet>.from(json["chiTiets"].map((x) => ChiTiet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tenNhanVien": tenNhanVien,
    "tongSoLuong": tongSoLuong,
    "id": id,
    "id_SanPham": idSanPham,
    "tongSoTien": tongSoTien,
    "lstTenDichVu": List<dynamic>.from(lstTenDichVu!.map((x) => x.toJson())),
    "tenDichVu": tenDichVu,
    "updatedBy": updatedBy,
    "createdBy": createdBy,
    "lastUpdatedDate": lastUpdatedDate.toString(),
    "createdDate": createdDate.toString(),
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
  double? thanhTien;

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

class LstTenDichVu {
  LstTenDichVu({
    this.tenDichVu,
    this.donGia,
    this.soLuong,
  });

  String? tenDichVu;
  double? donGia;
  int? soLuong;

  factory LstTenDichVu.fromJson(Map<String, dynamic> json) => LstTenDichVu(
    tenDichVu: json["tenDichVu"],
    donGia: json["donGia"],
    soLuong: json["soLuong"],
  );

  Map<String, dynamic> toJson() => {
    "tenDichVu": tenDichVu,
    "donGia": donGia,
    "soLuong": soLuong,
  };
}
