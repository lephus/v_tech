import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class ProductProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetListTypeProductProvider()async{
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetListTypeProduct}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
  Future<Response<dynamic>> GetDataProduct(var search, var pageIndex, var pageSize, var order, var idTypeProduct)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
     // print('${ConnectToServer.BaseUrl}${ConnectToServer.GetDataTableProduct}?txtSearch=${search}&pageIndex=${pageIndex}&pageSize=${pageSize}&order=${order}&id_LoaiSanPham=${idTypeProduct}');
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetDataTableProduct}?txtSearch=${search}&pageIndex=${pageIndex}&pageSize=${pageSize}&order=${order}&id_LoaiSanPham=${idTypeProduct}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
  }
}

}
