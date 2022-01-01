import 'dart:convert';

LapRapModel lapRapModelFromJson(String str) => LapRapModel.fromJson(json.decode(str));

String lapRapModelToJson(LapRapModel data) => json.encode(data.toJson());

class LapRapModel {
  LapRapModel({
    this.tenDichVu,
    this.slDoNep,
    this.donGia,
    this.id,
    this.idDoanhNghiep,
    this.createdBy,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.deleteFlag,
  });

  String? tenDichVu;
  int? slDoNep;
  double? donGia;
  int? id;
  int? idDoanhNghiep;
  int? createdBy;
  DateTime? createdDate;
  int? lastUpdatedBy;
  DateTime? lastUpdatedDate;
  bool? deleteFlag;

  factory LapRapModel.fromJson(Map<String, dynamic> json) => LapRapModel(
    tenDichVu: json["tenDichVu"],
    slDoNep: json["slDoNep"],
    donGia: json["donGia"],
    id: json["id"],
    idDoanhNghiep: json["id_DoanhNghiep"],
    createdBy: json["createdBy"],
    createdDate: DateTime.parse(json["createdDate"]),
    lastUpdatedBy: json["lastUpdatedBy"],
    lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
    deleteFlag: json["deleteFlag"],
  );

  Map<String, dynamic> toJson() => {
    "tenDichVu": tenDichVu,
    "slDoNep": slDoNep,
    "donGia": donGia,
    "id": id,
    "id_DoanhNghiep": idDoanhNghiep,
    "createdBy": createdBy,
    "createdDate": createdDate.toString(),
    "lastUpdatedBy": lastUpdatedBy,
    "lastUpdatedDate": lastUpdatedDate.toString(),
    "deleteFlag": deleteFlag,
  };
}
