import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class WareHouseProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetTransfer(var id_CuaHangNhap, var id_CuaHangXuat, var startDate,
      var endDate, bool duyet, bool xacNhan, int pageIndex
      )async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetTransfer}?'
          'id_CuaHangNhap=${id_CuaHangNhap}'
          '&id_CuaHangXuat=${id_CuaHangXuat}'
          '&startDate=${startDate}'
          '&endDate=${endDate}'
          '&duyet=${duyet}'
          '&xacNhan=${xacNhan}'
          '&pageIndex=${pageIndex}'
          '&pageSize=20', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> ConfirmTransfer(var id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.ConfirmTransfer}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> AccessTransfer(var id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.AccessTransfer}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }


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
  Future<Response<dynamic>> GetDetailTransfer(var id)async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDetailTransfer}${id}',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  Future<void> UploadImage(File file,var idTransfer) async{
    var token = await box.read('token');
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${token}",
    };
    var request = http.MultipartRequest("POST", Uri.parse('${ConnectToServer.BaseUrl}${ConnectToServer.PostImageTransfer}?id=$idTransfer'));
    //add text fields
    request.fields["files"] = '$idTransfer';
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("files", file.path);
    //add multipart to request
    request.headers.addAll(header);
    request.files.add(pic);
    await request.send();
  }

 // product are coming
  Future<Response<dynamic>> GetProductAreComing(var tenSanPham, var startDate,
      var endDate, bool trangThaiPhieu, var pageIndex
      )async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetProductAreComing}?'
          'tenSanPham=${tenSanPham}'
          '&daXacNhan=${trangThaiPhieu}'
          '&startDate=${startDate}'
          '&endDate=${endDate}'
          '&pageIndex=${pageIndex}'
          '&pageSize=20', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  // import and export product
  Future<Response<dynamic>> GetImportAndExportProduct(var loaiPhieu, var startDate,
      var endDate, var nameProduct, var pageIndex, var tenKhachHang, var loaiDoiTuong
      )async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDataImportAndExportProduct}?'
          'loai=${loaiPhieu}'
          '&ten_SanPham=${nameProduct}'
          '&startDate=${startDate}'
          '&endDate=${endDate}'
          '&pageIndex=${pageIndex}'
          '&ten_KhachHang=${tenKhachHang}'
          '&loaiDoiTuong=${loaiDoiTuong}'
          '&pageSize=20', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }

  // BillOrder
  Future<Response<dynamic>> GetBillOrder(var startDate,
      var endDate, String trangThaiPhieu, var pageIndex, var TenNCC, var cuaHang
      )async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      startDate = ymd(startDate);
      endDate = ymd(endDate);
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetBillOrder}?'
          'tenSanPham=${TenNCC}'
          '&daXacNhan=${trangThaiPhieu}'
          '&id_CuaHang=${cuaHang}'
          '&startDate=${startDate}'
          '&endDate=${endDate}'
          '&pageIndex=${pageIndex}'
          '&pageSize=20', headers: header);
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
  Future<Response<dynamic>> GetDetailDetailBillOrder(int id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDetailDetailBillOrder}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> GetAlbumImageBillOrder(int id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetImageDetailBillOrder}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<void> UploadImageBillOrder(File file,var id) async{
    var token = await box.read('token');
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer ${token}",
    };
    var request = http.MultipartRequest("POST", Uri.parse('${ConnectToServer.BaseUrl}${ConnectToServer.PostImageDetailBillOrder}$id'));
    //add text fields
    request.fields["files"] = '$id';
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("files", file.path);
    //add multipart to request
    request.headers.addAll(header);
    request.files.add(pic);
    await request.send();
  }

  // LOG
  Future<Response<dynamic>> SaveLog(int id_ChuyenKho, int id_SanPham, int id_KhachHang)async{
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      final data = jsonEncode(
          <dynamic, dynamic>{
            "id_HoaDon": 0,
            "id_SanPham": id_SanPham,
            "id_ChuyenKho": id_ChuyenKho,
            "id_KhachHang": id_KhachHang,
            "phanLoai":"chuyen_kho"
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

}
