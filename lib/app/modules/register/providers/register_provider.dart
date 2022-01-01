import 'dart:convert';

import 'package:get/get.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class RegisterProvider extends GetConnect {
  Future<Response<dynamic>> actionRegister(var userName, var password, var confirmPassword, var phone, var email, var nameShop)async{
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final data = jsonEncode(
          <String, dynamic>{
              "taiKhoan": userName,
              "matKhau": password,
              "nhapLaiMatKhau": confirmPassword,
              "dienThoai": phone,
              "email": email,
              "tenCuaHang": nameShop,
              "id_DoanhNghiep": 0,
              "roleId": 0
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.RegisterURL}', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
}
