import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';
import 'package:http/http.dart' as http;
class ListOrderProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetListStore()async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetListStore}',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<Response<dynamic>> GetListOrder(var idStore, var startDate, var endDate, var pageIndex, var trangThai)async {
    var token = await box.read('token');
    if(startDate == "Ngày bắt đầu"){
      startDate = "";
    }
    if(endDate == "Ngày kết thúc"){
      endDate = "";
    }
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
     print('${ConnectToServer.BaseUrl}${ConnectToServer.GetListOrder}?idStore=${idStore}&startDate=${startDate}&endDate=${endDate}&pageIndex=${pageIndex}&PageSize=20&trangThai=$trangThai');
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetListOrder}?idStore=${idStore}&startDate=${startDate}&endDate=${endDate}&pageIndex=${pageIndex}&PageSize=20&trangThai=$trangThai',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> GetListTrangThaiGiaoHang(var pageIndex)async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{"filter": {}, "pageSize": 1000, "pageIndex": pageIndex});
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.getTrangThaiGiaoHang}',data, headers: header);
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

  Future<Response<dynamic>> UpdateStatusOrder(var id, var ma)async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <String, String>{});
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.UpdateStatusOrder}?id=$id&trangThai=$ma',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<void> UploadImage(File file,var orderId) async{
    var token = await box.read('token');
    final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      var request = http.MultipartRequest("POST", Uri.parse('${ConnectToServer.BaseUrl}${ConnectToServer.UploadImage}?orderId=$orderId'));
      //add text fields
      request.fields["files"] = '$orderId';
      //create multipart using filepath, string or bytes
      var pic = await http.MultipartFile.fromPath("files", file.path);
      //add multipart to request
      request.headers.addAll(header);
      request.files.add(pic);
      await request.send();
  }

    // LOG
  Future<Response<dynamic>> SaveLog(int id_HoaDon, int id_SanPham, int id_KhachHang)async{
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "id_HoaDon": id_HoaDon,
            "id_SanPham": id_SanPham,
            "id_ChuyenKho": 0,
            "id_KhachHang": id_KhachHang,
            "phanLoai":"don_hang"
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.SaveLog}', data, headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> DeleteLog(int id)async{
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}"
      };
      return await delete('${ConnectToServer.BaseUrl}${ConnectToServer.DeleteLog}$id', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  // END LOG

  // UPDATE TRANG THAI GIAO HANG
  Future<Response<dynamic>> updateTrangThaiGiaoHang(var id, var idHoaDon, var idTrangThai)async {
    var token = await box.read('token');
    int idTT = 0;
    if(idTrangThai == 0){
      idTT = 45;
    }
    if(idTrangThai == 1){
      idTT = 46;
    }
    if(idTrangThai == 2){
      idTT = 48;
    }
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <String, dynamic>{
            "id": id,
            "idDonHang": idHoaDon,
            "idTrangThai": idTT
          });
      return await post('${ConnectToServer.BaseUrl}${ConnectToServer.updateTrangThaiGiaoHang}',data, headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
}
