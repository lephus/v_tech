import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class TimeKeepingProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetListDivision()async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
              "filter": {
                "hienThiCaTrongNgay": true
              },
              "pageSize": 10000000,
              "pageIndex": 1
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetListDivision}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> ChooseDivision(var id)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{});
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.ChooseDivision}$id',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  // HISTORY TIME KEEPING
  Future<Response<dynamic>> GetHistoryTimeKeeping(var from, var to, var idNhanVien ,var pageIndex)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      from = ymd(from);
      to = ymd(to);
      var data = jsonEncode(
          <dynamic, dynamic> {
            "filter": {
              "from": "${from}",
              "to": "${to}"
            },
            "pageSize": 20,
            "pageIndex": pageIndex
          }
      );
      if (idNhanVien != ""){
        data = jsonEncode(
            <dynamic, dynamic> {
              "filter": {
                "from": "${from}",
                "to": "${to}",
                "id_NhanVien": int.parse(idNhanVien)
              },
              "pageSize": 20,
              "pageIndex": pageIndex
            }
        );
      }
      print(data);
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetHistoryTimeKeeping}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> GetStaff()async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetListStaff}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  // MANAGER TIME KEEPING
  // HISTORY TIME KEEPING
  Future<Response<dynamic>> ManagerTimeKeeping(var from, var to, var Status ,var pageIndex)async {
    try {
      var token = await box.read('token');
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      from = ymd(from);
      to = ymd(to);
      var data = jsonEncode(
          <dynamic, dynamic> {
            "filter": {
              "from": "${from}",
              "to": "${to}",
              "status": "${Status}"
            },
            "pageSize": 20,
            "pageIndex": pageIndex
          }
      );
      print(data);
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.GetTimeKeeping}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

}
