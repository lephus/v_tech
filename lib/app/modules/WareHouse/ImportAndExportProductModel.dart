import 'dart:convert';

ImportAndExportProductModel importAndExportProductModelFromJson(String str) => ImportAndExportProductModel.fromJson(json.decode(str));

String importAndExportProductModelToJson(ImportAndExportProductModel data) => json.encode(data.toJson());

class ImportAndExportProductModel {
  ImportAndExportProductModel({
    this.id,
    this.loai,
    this.imei,
    this.idSanPham,
    this.idThucThiXnk,
    this.tenSanPham,
    this.soLuongSanPham,
    this.maSanPham,
    this.createdDate,
    this.idCuaHang,
    this.idDonHang,
    this.tenCuaHang,
    this.tonKho,
    this.giaSanPham,
    this.giaVonSanPham,
    this.tongTien,
    this.ghiChu,
    this.loaiDoiTuong,
  });

  int? id;
  String? loai;
  dynamic imei;
  int? idSanPham;
  int? idThucThiXnk;
  String? tenSanPham;
  int? soLuongSanPham;
  String? maSanPham;
  DateTime? createdDate;
  int? idCuaHang;
  int? idDonHang;
  String? tenCuaHang;
  int? tonKho;
  double? giaSanPham;
  double? giaVonSanPham;
  double? tongTien;
  String? ghiChu;
  dynamic loaiDoiTuong;

  factory ImportAndExportProductModel.fromJson(Map<String, dynamic> json) => ImportAndExportProductModel(
    id: json["id"],
    loai: json["loai"],
    imei: json["imei"],
    idSanPham: json["id_SanPham"],
    idThucThiXnk: json["id_ThucThiXNK"],
    tenSanPham: json["ten_SanPham"],
    soLuongSanPham: json["soLuong_SanPham"],
    maSanPham: json["ma_SanPham"],
    createdDate: DateTime.parse(json["createdDate"]),
    idCuaHang: json["id_CuaHang"],
    idDonHang: json["id_DonHang"],
    tenCuaHang: json["ten_CuaHang"],
    tonKho: json["tonKho"],
    giaSanPham: double.parse(json["gia_SanPham"].toString()),
    giaVonSanPham: double.parse(json["giaVon_SanPham"].toString()),
    tongTien: double.parse(json["tongTien"].toString()),
    ghiChu: json["ghiChu"],
    loaiDoiTuong: json["loaiDoiTuong"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "loai": loai,
    "imei": imei,
    "id_SanPham": idSanPham,
    "id_ThucThiXNK": idThucThiXnk,
    "ten_SanPham": tenSanPham,
    "soLuong_SanPham": soLuongSanPham,
    "ma_SanPham": maSanPham,
    "createdDate": createdDate.toString(),
    "id_CuaHang": idCuaHang,
    "id_DonHang": idDonHang,
    "ten_CuaHang": tenCuaHang,
    "tonKho": tonKho,
    "gia_SanPham": giaSanPham,
    "giaVon_SanPham": giaVonSanPham,
    "tongTien": tongTien,
    "ghiChu": ghiChu,
    "loaiDoiTuong": loaiDoiTuong,
  };
}
