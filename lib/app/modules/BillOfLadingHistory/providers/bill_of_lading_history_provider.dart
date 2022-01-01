import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class BillOfLadingHistoryProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetBillOfLadingHistory(var indexPage, var from, var to, var tenKhachHang,var tenNguoiTao)async{
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      from = ymd(from);
      to = ymd(to);
      final data = jsonEncode(
          <dynamic, dynamic>{
            "filter": {
              "from": "${from}",
              "to": "${to}",
              "tenKhachHang": "${tenKhachHang}",
              "tenNguoiTao": "${tenNguoiTao}"
            },
            "pageSize": 20,
            "pageIndex": indexPage,
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetBillOfLadingHistory}', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> EditBillOfLadingHistory(var ngayVanDon, var soKM, var Note, var id)async{
    var token = await box.read('token');
    var userID =  await box.read('userID');
    var enterpriseId = await box.read('enterpriseId');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      ngayVanDon = ymd(ngayVanDon);
      final data = jsonEncode(
          <dynamic, dynamic>{
              "ngayVanDon": "${ngayVanDon}",
              "soKm": int.parse(soKM),
              "userId": userID,
              "id": id,
              "enterpriseId": enterpriseId,
              "ghiChu": "${Note}"
          });
      print(data);
      print('${ConnectToServer.BaseUrl}${ConnectToServer.EditBillOfLadingHistory}');
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.EditBillOfLadingHistory}', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> DeleteBillOfLadingHistory(var id)async{
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await delete('${ConnectToServer.BaseUrl}${ConnectToServer.DeleteBillOfLadingHistory}$id', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
}
