import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class RepairProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetRepair(var pageIndex, var startDate,
      var endDate, var trangThai,  var loai, var IDKhachHang, var IDNCC
      )async{
    var token = await box.read('token');
    var cuaHang = await box.read('storeId');

    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetRepair}?'
          'pageIndex=${pageIndex}'
          '&id_CuaHang=${cuaHang}'
          '&fromDate=${startDate}'
          '&toDate=${endDate}'
          '&Id_KhachHang=${IDKhachHang}'
          '&Id_NhaCungCap=${IDNCC}'
          '&LoaiYeuCau=${loai}'
          '&TrangThai=${trangThai}'
          '&pageSize=20', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> GetDetailBillRepair(var id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDetailBillRepair}$id', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetNhaCungCap()async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetNhaCungCap}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetCustomer()async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <String, int>{ "pageIndex": 1, "pageSize": 99999999});
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetCustomer}',data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }


  // LIST DETAIL REPAIR
  Future<Response<dynamic>> GetDetailRepair(var pageIndex, var startDate,
      var endDate, var trangThai,  var loai, var IDKhachHang, var Id_NhaSuaChua,  var Imei
      )async{
    var token = await box.read('token');
    var cuaHang = await box.read('storeId');

    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetListDetailRepair}?'
          'pageIndex=${pageIndex}'
          '&FromDate=${startDate}'
          '&ToDate=${endDate}'
          '&Id_KhachHang=${IDKhachHang}'
          '&Id_NhaSuaChua=${Id_NhaSuaChua}'
          '&Imei=${Imei}'
          '&TrangThai=${trangThai}'
          '&LoaiYeuCau=${loai}'
          '&pageSize=20', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> UpdateDetailRepair(var id, var trangThai, var ghiChu)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <String, dynamic>{
            "idChiTietPhieu": id,
            "trangThai": "${trangThai}",
            "ghiChu": "${ghiChu}"
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.UpdateDetailRepair}',data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }


}
