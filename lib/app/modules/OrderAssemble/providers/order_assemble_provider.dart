import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';
import 'package:v_tech/app/modules/profile/ProfileModel.dart';

class OrderAssembleProvider extends GetConnect {
  final box = GetStorage();

  Future<Response<dynamic>> GetProfile()async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetProfile}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetDataOrderAssemble(ProfileModel profile,int index, var from, var to, var tenDichVu)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "order": "",
              "filter": {
                "nguoiTao": "${profile.ten}",
                "tenDichVu": "${tenDichVu}",
                "from": "${from}",
                "to": "${to}"
              },
              "pageSize": 20,
              "pageIndex": index,
              "id_DoanhNghiep": profile.idDoanhNghiep,
              "id": profile.id,
              "taiKhoan": "${profile.taiKhoan}",
              "ten": "${profile.ten}",
              "dienThoai": "${profile.dienThoai}",
              "email": "${profile.email}",
              "trangThaiHoaDonMacDinh": "${profile.trangThaiHoaDonMacDinh}",
              "token": profile.token,
              "roles": profile.roles,
              "createdDate": "${profile.createdDate}",
              "id_CuaHang": profile.idCuaHang,
              "tenCuaHang": "${profile.tenCuaHang}",
              "id_KhachHang": profile.idKhachHang,
              "id_ChucVu": profile.idChucVu,
              "export": true
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetOrderAssemble}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetLapRap(ProfileModel profile,)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "filter": {
            },
            "pageSize": 999999,
            "pageIndex": 1,
            "id_DoanhNghiep": profile.idDoanhNghiep,
            "id": profile.id,
            "taiKhoan": "${profile.taiKhoan}",
            "ten": "${profile.ten}",
            "dienThoai": "${profile.dienThoai}",
            "email": "${profile.email}",
            "trangThaiHoaDonMacDinh": "${profile.trangThaiHoaDonMacDinh}",
            "token": profile.token,
            "roles": profile.roles,
            "createdDate": "${profile.createdDate}",
            "id_CuaHang": profile.idCuaHang,
            "tenCuaHang": "${profile.tenCuaHang}",
            "id_KhachHang": profile.idKhachHang,
            "id_ChucVu": profile.idChucVu,
            "export": true
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetLapRap}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetProduct()async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "filter": {
            },
            "pageSize": 999999,
            "pageIndex": 1,
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetProduct}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> AddOrderAssemble(var AddInfors, var idSP, var da)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
              "id": 0,
              "id_SanPham": idSP,
              "ngayLam": "${da}",
              "lstDichVu": AddInfors
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.AddOrderAssemble}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> UpdateOrderAssemble(var AddInfors, var idSP, var da, var id)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "id": id,
            "id_SanPham": idSP,
            "ngayLam": "${da}",
            "lstDichVu": AddInfors
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.AddOrderAssemble}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> DeleleOrderAssemble(var id)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await delete('${ConnectToServer.BaseUrl}${ConnectToServer.DeleteOrderAssemble}?id=${id}', headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetDetailOrderAssemble(var id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDetailOrderAssemble}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }


}
