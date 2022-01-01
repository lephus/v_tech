// To parse this JSON data, do
//
//     final divisionModel = divisionModelFromJson(jsonString);

import 'dart:convert';

DivisionModel divisionModelFromJson(String str) => DivisionModel.fromJson(json.decode(str));

String divisionModelToJson(DivisionModel data) => json.encode(data.toJson());

class DivisionModel {
  DivisionModel({
    this.id,
    this.idCaLamViec,
    this.idCuaHang,
    this.idNguoiDung,
    this.thuHai,
    this.thuBa,
    this.thuTu,
    this.thuNam,
    this.thuSau,
    this.thuBay,
    this.chuNhat,
    this.thuTuHienThi,
    this.caLamViec,
    this.chamCong,
  });

  int? id;
  int? idCaLamViec;
  int? idCuaHang;
  int? idNguoiDung;
  bool? thuHai;
  bool? thuBa;
  bool? thuTu;
  bool? thuNam;
  bool? thuSau;
  bool? thuBay;
  bool? chuNhat;
  int? thuTuHienThi;
  CaLamViec? caLamViec;
  List<ChamCong>? chamCong;

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
    id: json["id"],
    idCaLamViec: json["id_CaLamViec"],
    idCuaHang: json["id_CuaHang"],
    idNguoiDung: json["id_NguoiDung"],
    thuHai: json["thuHai"],
    thuBa: json["thuBa"],
    thuTu: json["thuTu"],
    thuNam: json["thuNam"],
    thuSau: json["thuSau"],
    thuBay: json["thuBay"],
    chuNhat: json["chuNhat"],
    thuTuHienThi: json["thuTuHienThi"],
    caLamViec: CaLamViec.fromJson(json["caLamViec"]),
    chamCong: List<ChamCong>.from(json["chamCong"].map((x) => ChamCong.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_CaLamViec": idCaLamViec,
    "id_CuaHang": idCuaHang,
    "id_NguoiDung": idNguoiDung,
    "thuHai": thuHai,
    "thuBa": thuBa,
    "thuTu": thuTu,
    "thuNam": thuNam,
    "thuSau": thuSau,
    "thuBay": thuBay,
    "chuNhat": chuNhat,
    "thuTuHienThi": thuTuHienThi,
    "caLamViec": caLamViec!.toJson(),
    "chamCong": List<dynamic>.from(chamCong!.map((x) => x.toJson())),
  };
}

class CaLamViec {
  CaLamViec({
    this.ten,
    this.tuKhoa,
    this.kyHieu,
    this.soCong,
    this.thoiGianVao,
    this.thoiGianVaoStr,
    this.thoiGianVe,
    this.thoiGianVeStr,
    this.thoiGianNghiGg,
    this.thoiGianNghiGgStr,
    this.thoiGianKetThucNghiGg,
    this.thoiGianKetThucNghiGgStr,
    this.gioCongToiThieu,
    this.tangCa,
  });

  String? ten;
  String? tuKhoa;
  String? kyHieu;
  int? soCong;
  int? thoiGianVao;
  String? thoiGianVaoStr;
  int? thoiGianVe;
  String? thoiGianVeStr;
  int? thoiGianNghiGg;
  String? thoiGianNghiGgStr;
  int? thoiGianKetThucNghiGg;
  String? thoiGianKetThucNghiGgStr;
  int? gioCongToiThieu;
  bool? tangCa;

  factory CaLamViec.fromJson(Map<String, dynamic> json) => CaLamViec(
    ten: json["ten"],
    tuKhoa: json["tuKhoa"],
    kyHieu: json["kyHieu"],
    soCong: json["soCong"],
    thoiGianVao: json["thoiGianVao"],
    thoiGianVaoStr: json["thoiGianVaoStr"],
    thoiGianVe: json["thoiGianVe"],
    thoiGianVeStr: json["thoiGianVeStr"],
    thoiGianNghiGg: json["thoiGianNghiGG"],
    thoiGianNghiGgStr: json["thoiGianNghiGGStr"],
    thoiGianKetThucNghiGg: json["thoiGianKetThucNghiGG"],
    thoiGianKetThucNghiGgStr: json["thoiGianKetThucNghiGGStr"],
    gioCongToiThieu: json["gioCongToiThieu"],
    tangCa: json["tangCa"],
  );

  Map<String, dynamic> toJson() => {
    "ten": ten,
    "tuKhoa": tuKhoa,
    "kyHieu": kyHieu,
    "soCong": soCong,
    "thoiGianVao": thoiGianVao,
    "thoiGianVaoStr": thoiGianVaoStr,
    "thoiGianVe": thoiGianVe,
    "thoiGianVeStr": thoiGianVeStr,
    "thoiGianNghiGG": thoiGianNghiGg,
    "thoiGianNghiGGStr": thoiGianNghiGgStr,
    "thoiGianKetThucNghiGG": thoiGianKetThucNghiGg,
    "thoiGianKetThucNghiGGStr": thoiGianKetThucNghiGgStr,
    "gioCongToiThieu": gioCongToiThieu,
    "tangCa": tangCa,
  };
}

class ChamCong {
  ChamCong({
    this.id,
    this.idPhanCa,
    this.idCaLamViec,
    this.tenCa,
    this.thoiGianVaoCa,
    this.thoiGianVaoCaStr,
    this.thoiGianVeCa,
    this.thoiGianVeCaStr,
    this.thoiGianVao,
    this.thoiGianVaoStr,
    this.thoiGianVe,
    this.thoiGianVeStr,
    this.thoiGianDiMuon,
    this.thoiGianDiMuonStr,
    this.thoiGianVeSom,
    this.thoiGianVeSomStr,
    this.createdDate,
    this.createdBy,
    this.tenNhanVien,
  });

  int? id;
  int? idPhanCa;
  int? idCaLamViec;
  dynamic tenCa;
  int? thoiGianVaoCa;
  String? thoiGianVaoCaStr;
  int? thoiGianVeCa;
  String? thoiGianVeCaStr;
  int? thoiGianVao;
  String? thoiGianVaoStr;
  int? thoiGianVe;
  String? thoiGianVeStr;
  int? thoiGianDiMuon;
  String? thoiGianDiMuonStr;
  int? thoiGianVeSom;
  String? thoiGianVeSomStr;
  DateTime? createdDate;
  int? createdBy;
  dynamic tenNhanVien;

  factory ChamCong.fromJson(Map<String, dynamic> json) => ChamCong(
    id: json["id"],
    idPhanCa: json["id_PhanCa"],
    idCaLamViec: json["id_CaLamViec"],
    tenCa: json["tenCa"],
    thoiGianVaoCa: json["thoiGianVaoCa"],
    thoiGianVaoCaStr: json["thoiGianVaoCaStr"],
    thoiGianVeCa: json["thoiGianVeCa"],
    thoiGianVeCaStr: json["thoiGianVeCaStr"],
    thoiGianVao: json["thoiGianVao"],
    thoiGianVaoStr: json["thoiGianVaoStr"],
    thoiGianVe: json["thoiGianVe"],
    thoiGianVeStr: json["thoiGianVeStr"],
    thoiGianDiMuon: json["thoiGianDiMuon"],
    thoiGianDiMuonStr: json["thoiGianDiMuonStr"],
    thoiGianVeSom: json["thoiGianVeSom"],
    thoiGianVeSomStr: json["thoiGianVeSomStr"],
    createdDate: DateTime.parse(json["createdDate"]),
    createdBy: json["createdBy"],
    tenNhanVien: json["tenNhanVien"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_PhanCa": idPhanCa,
    "id_CaLamViec": idCaLamViec,
    "tenCa": tenCa,
    "thoiGianVaoCa": thoiGianVaoCa,
    "thoiGianVaoCaStr": thoiGianVaoCaStr,
    "thoiGianVeCa": thoiGianVeCa,
    "thoiGianVeCaStr": thoiGianVeCaStr,
    "thoiGianVao": thoiGianVao,
    "thoiGianVaoStr": thoiGianVaoStr,
    "thoiGianVe": thoiGianVe,
    "thoiGianVeStr": thoiGianVeStr,
    "thoiGianDiMuon": thoiGianDiMuon,
    "thoiGianDiMuonStr": thoiGianDiMuonStr,
    "thoiGianVeSom": thoiGianVeSom,
    "thoiGianVeSomStr": thoiGianVeSomStr,
    "createdDate": createdDate.toString(),
    "createdBy": createdBy,
    "tenNhanVien": tenNhanVien,
  };
}
