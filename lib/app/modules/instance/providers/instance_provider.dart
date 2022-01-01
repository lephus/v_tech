import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class InstanceProvider extends GetConnect {
  final box = GetStorage();
  Future<Response<dynamic>> truncate(String password)async {
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.Truncate}$password',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
}
