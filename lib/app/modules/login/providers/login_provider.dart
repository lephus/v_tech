import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class LoginProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> actionLogin(var userName, var password)async{
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final data = jsonEncode(
          <String, String>{'taiKhoan': userName, 'matKhau': password});
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.LoginURL}', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> autoLogin(var token,var userID, var email)async{
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.autoLoginURL}?token=${token}&email=${email}&uid=${userID}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> postTokenFireBase(var id, var t)async {
    var isApp = "";
    if (Platform.isAndroid) {
      isApp = "Android";
    } else if (Platform.isIOS) {
      isApp = "IOS";
    }
    String token = "";
    await FirebaseMessaging.instance.getToken().then((value)async{
      token = value.toString();
    });
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${t}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "userId": id,
            "app": isApp.toString(),
            "token": token,
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.PostTokenApi}',data, headers: header);
    } catch (exception) {
      print(exception.toString());
      return await Future.error(exception.toString());
    }
  }

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
}
