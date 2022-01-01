import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/modules/Slide/providers/slide_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class SlideController extends GetxController {
  final box = GetStorage();
  bool ok = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> logOut()async{
    await box.remove('token');
    await box.remove('userID');
    await box.remove('email');
    await box.remove('userName');
    await box.remove('storeId');
    await box.remove('enterpriseId');
    await box.remove('role');
  }

  Future<bool> RemoveTokenFirebase()async{
    await SlideProvider().RemoveTokenFireBase().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        ok = true;
      }else{
        showSnackBarError("Lỗi Đăng Xuất mã: OUT035!", "Server đang bận, hãy thử lại sau vài giây.");
        ok = false;
      }
    });
    if(ok == true){
      await logOut();
    }
    return ok;
  }
}
