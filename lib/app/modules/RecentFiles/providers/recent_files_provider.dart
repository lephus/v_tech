import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class RecentFilesProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetNotifySystem()async {
    var token = await box.read('token');
    var idDoanhNghiep = await box.read('enterpriseId');
    var idCuaHang = await box.read('storeId');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "pageIndex": 1,
            "pageSize": 5000,
            "id_DoanhNghiep": idDoanhNghiep,
            "id_CuaHang": idCuaHang
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.SystemNotify}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
}
