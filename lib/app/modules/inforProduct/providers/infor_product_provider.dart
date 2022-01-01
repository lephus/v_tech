import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class InforProductProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> GetProductByID(var id)async{
    var token = await box.read('token');
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetProductByID}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
}
