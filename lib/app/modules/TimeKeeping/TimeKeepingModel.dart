

import 'dart:convert';

TimeKeepingModel timeKeepingModelFromJson(String str) => TimeKeepingModel.fromJson(json.decode(str));

String timeKeepingModelToJson(TimeKeepingModel data) => json.encode(data.toJson());

class TimeKeepingModel {
  TimeKeepingModel({
    this.tenCaLamViec,
    this.idChamCong,
    this.loaiYeuCau,
    this.thoiGianVao,
    this.thoiGianVaoStr,
    this.thoiGianVe,
    this.thoiGianVeStr,
    this.thoiGianNghiGg,
    this.thoiGianNghiGgStr,
    this.thoiGianKetThucNghiGg,
    this.thoiGianKetThucNghiGgStr,
    this.ghiChu,
    this.trangThai,
  });

  dynamic tenCaLamViec;
  int? idChamCong;
  dynamic loaiYeuCau;
  int? thoiGianVao;
  String? thoiGianVaoStr;
  int? thoiGianVe;
  String? thoiGianVeStr;
  int? thoiGianNghiGg;
  String? thoiGianNghiGgStr;
  int? thoiGianKetThucNghiGg;
  String? thoiGianKetThucNghiGgStr;
  String? ghiChu;
  String? trangThai;

  factory TimeKeepingModel.fromJson(Map<String, dynamic> json) => TimeKeepingModel(
    tenCaLamViec: json["tenCaLamViec"],
    idChamCong: json["id_ChamCong"],
    loaiYeuCau: json["loaiYeuCau"],
    thoiGianVao: json["thoiGianVao"],
    thoiGianVaoStr: json["thoiGianVaoStr"],
    thoiGianVe: json["thoiGianVe"],
    thoiGianVeStr: json["thoiGianVeStr"],
    thoiGianNghiGg: json["thoiGianNghiGG"],
    thoiGianNghiGgStr: json["thoiGianNghiGGStr"],
    thoiGianKetThucNghiGg: json["thoiGianKetThucNghiGG"],
    thoiGianKetThucNghiGgStr: json["thoiGianKetThucNghiGGStr"],
    ghiChu: json["ghiChu"],
    trangThai: json["trangThai"],
  );

  Map<String, dynamic> toJson() => {
    "tenCaLamViec": tenCaLamViec,
    "id_ChamCong": idChamCong,
    "loaiYeuCau": loaiYeuCau,
    "thoiGianVao": thoiGianVao,
    "thoiGianVaoStr": thoiGianVaoStr,
    "thoiGianVe": thoiGianVe,
    "thoiGianVeStr": thoiGianVeStr,
    "thoiGianNghiGG": thoiGianNghiGg,
    "thoiGianNghiGGStr": thoiGianNghiGgStr,
    "thoiGianKetThucNghiGG": thoiGianKetThucNghiGg,
    "thoiGianKetThucNghiGGStr": thoiGianKetThucNghiGgStr,
    "ghiChu": ghiChu,
    "trangThai": trangThai,
  };
}
