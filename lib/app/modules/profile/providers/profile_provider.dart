import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';
import 'package:v_tech/app/modules/profile/ProfileModel.dart';

class ProfileProvider extends GetConnect {
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

  Future<Response<dynamic>> UpdateProfile(ProfileModel p, var ma)async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      List<Role>? r = p.roles;
      List<dynamic> t = [];
      for(int i=0; i<r!.length; i++){
        t.add(r[i].toJson());
      }
      final data = jsonEncode(
          <dynamic, dynamic>{
              "id": p.id,
              "ten": p.ten,
              "dienThoai": p.dienThoai,
              "email": p.email,
              "trangThaiHoaDonMacDinh": p.trangThaiHoaDonMacDinh,
              "hinhThucVanChuyenMacDinh": p.hinhThucVanChuyenMacDinh,
              "trangThaiHoaDonDichVuMacDinh": ma,
              "updatedBy": 0,
              "roles": t,
              "id_CuaHang": p.idCuaHang,
          });
      return await put('${ConnectToServer.BaseUrl}${ConnectToServer.UpdateProfile}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> UpdatePass(var OldPass, var NewPass, var id)async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
              "id": id,
              "oldPass": "${OldPass}",
              "newPass": "${NewPass}"
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.UpdatePassword}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
}
