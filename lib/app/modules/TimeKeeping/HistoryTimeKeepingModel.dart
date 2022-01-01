import 'dart:convert';

HistoryTimeKeepingModel historyTimeKeepingModelFromJson(String str) => HistoryTimeKeepingModel.fromJson(json.decode(str));

String historyTimeKeepingModelToJson(HistoryTimeKeepingModel data) => json.encode(data.toJson());

class HistoryTimeKeepingModel {
  HistoryTimeKeepingModel({
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
  String? tenCa;
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
  String? tenNhanVien;

  factory HistoryTimeKeepingModel.fromJson(Map<String, dynamic> json) => HistoryTimeKeepingModel(
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
