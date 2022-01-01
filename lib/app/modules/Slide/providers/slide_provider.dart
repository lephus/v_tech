import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/network/connect_to_server.dart';

class SlideProvider extends GetConnect {
  final box = GetStorage();
  var tokenFirebase = "";
  Future<Response<dynamic>> RemoveTokenFireBase()async {
    await FirebaseMessaging.instance.getToken().then((value)async{
      tokenFirebase = value.toString();
    });
    var token = await box.read('token');
    try {
      final header = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${token}",
      };
      return await get('${ConnectToServer.BaseUrl}${ConnectToServer.RemoveTokenFireBase}?token=$tokenFirebase',headers: header);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }
}
