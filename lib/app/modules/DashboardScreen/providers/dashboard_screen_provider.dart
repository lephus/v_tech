import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:v_tech/app/data/network/connect_to_server.dart';

class DashboardScreenProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> getDataDashboard(var storeID, var fromDate, var toDate, var enterpriseId)async{
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Authorization': "Bearer ${token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final data = jsonEncode(
          <String, String>{
            "storeId": storeID,
            "fromDate": fromDate,
            "toDate": toDate,
            "enterpriseId": enterpriseId
          });
      return await post('http://103.124.95.142:8181/api/Dashboard/get-data-dashboard', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
}
