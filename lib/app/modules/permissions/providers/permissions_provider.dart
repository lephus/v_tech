import 'package:get/get.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class PermissionsProvider extends GetConnect {
  Future<Response<dynamic>> GetPermissionsByID(var id, String token)async{
    try{
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.GetPermissions}${id}', headers: header);
    }catch(exception){
      return await Future.error(exception.toString());
    }
  }
}
