import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class MyFileProvider extends GetConnect {
  final box = GetStorage();

  Future<Response<dynamic>> getOverviewData(var fromDate, var toDate) async {
    try {
      var token = await box.read('token');
      var userID = await box.read('userID');
      var enterpriseId = await box.read('enterpriseId');
      var storeId = await box.read('storeId');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "storeId": storeId,
            "fromDate": fromDate, //"2021-10-11T12:26:05.974Z",
            "toDate": toDate, //"2021-10-11T12:26:05.974Z",
            "enterpriseId": enterpriseId,
            "userId": userID
          });
      print(
          """
        "storeId": $storeId,
        "fromDate": $fromDate,
        "toDate": $toDate',
        "enterpriseId": $enterpriseId,
        "userId": $userID
        """
      );
      return await post(
          '${ConnectToServer.BaseUrl}${ConnectToServer.GetOverviewData}', data,
          headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }


  Future<Response<dynamic>> GetRevenue(var fromDate, var toDate) async {
    try {
      var token = await box.read('token');
      var userID = await box.read('userID');
      var enterpriseId = await box.read('enterpriseId');
      var storeId = await box.read('storeId');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "storeId": storeId,
            "fromDate": fromDate, //"2021-10-11T12:26:05.974Z",
            "toDate": toDate, //"2021-10-11T12:26:05.974Z",
            "enterpriseId": enterpriseId,
            "userId": userID
          });
      return await post(
          '${ConnectToServer.BaseUrl}${ConnectToServer.GetRevenue}', data,
          headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
}