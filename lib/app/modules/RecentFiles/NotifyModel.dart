import 'dart:convert';
NotifyModel notifyModelFromJson(String str) => NotifyModel.fromJson(json.decode(str));
String notifyModelToJson(NotifyModel data) => json.encode(data.toJson());

class NotifyModel {
  NotifyModel({
    this.id,
    this.ten,
    this.noiDung,
    this.createdDate,
  });

  int? id;
  String? ten;
  String? noiDung;
  DateTime? createdDate;

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
    id: json["id"],
    ten: json["ten"],
    noiDung: json["noiDung"],
    createdDate: DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ten": ten,
    "noiDung": noiDung,
    "createdDate": createdDate.toString(),
  };
}
