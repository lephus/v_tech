import 'dart:convert';

import 'package:get/get.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class ConfirmOTPProvider extends GetConnect {
  Future<Response<dynamic>> ValidateOTP(var userName, var phoneNumber, var otp, var key)async{
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final data = jsonEncode(
          <String, String>{'userName': userName, 'phoneNumber': phoneNumber,'otp': otp, 'key': key});
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.ValidateOTP}', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
}
