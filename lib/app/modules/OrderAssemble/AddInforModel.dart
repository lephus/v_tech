// To parse this JSON data, do
//
//     final addInforModel = addInforModelFromJson(jsonString);

import 'dart:convert';

AddInforModel addInforModelFromJson(String str) => AddInforModel.fromJson(json.decode(str));

String addInforModelToJson(AddInforModel data) => json.encode(data.toJson());

class AddInforModel {
  AddInforModel({
    this.idLapRap,
    this.soLuong,
    this.name,
    this.donGia,
  });

  int? idLapRap;
  int? soLuong;
  String? name;
  double? donGia;

  factory AddInforModel.fromJson(Map<String, dynamic> json) => AddInforModel(
    idLapRap: json["id_LapRap"],
    soLuong: json["soLuong"],
    name: json["name"],
    donGia: json["donGia"],
  );

  Map<String, dynamic> toJson() => {
    "id_LapRap": idLapRap,
    "soLuong": soLuong,
    "donGia": donGia,
  };
}
