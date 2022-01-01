import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class CustomerProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetListCustomer(var pageIndex, bool quaGioiHanCongNo, var name)async {
    var token = await box.read('token');
    var id_DoanhNghiep = await box.read('enterpriseId');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <String, dynamic>{
              "id_DoanhNghiep": id_DoanhNghiep,
              "pageIndex": pageIndex,
              "pageSize": 20,
              "keyword":  name,
              "quaGioiHanConNo": quaGioiHanCongNo,
          });
      print(data);
      print('${ConnectToServer.BaseUrl}${ConnectToServer.GetListCustomer}');
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetListCustomer}',data,headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetDetailOrder(var id,var pageIndex, var startDate, var endDate)async {
    startDate = ymd(startDate);
    endDate = ymd(endDate);
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDetailOrder}?id=$id&pageIndex=$pageIndex&pageSize=500&from=$startDate&to=$endDate',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetListStatusType()async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetListStatusType}',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

}
