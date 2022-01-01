
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/constants/constants.dart';
// import 'package:v_tech/app/data/database/user_database.dart';
import 'package:v_tech/app/models/user.dart';
import 'package:v_tech/app/modules/login/providers/login_provider.dart';
import 'package:v_tech/app/modules/permissions/controllers/permissions_controller.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';


class LoginController extends GetxController {
  // VTECHDatabase _userDatabase = VTECHDatabase();
  final permissionsController = new PermissionsController();
  var year = DateTime.now().year;
  final box = GetStorage();
  TextEditingController textControllerUserName = new TextEditingController();
  TextEditingController textControllerEmail = new TextEditingController();
  TextEditingController textControllerPassword = new TextEditingController();
  var isObscure = true.obs;
  var isLoading = false.obs;
  var isAutoLogin = false.obs;
  var acceptLogin = false.obs;
  var checkConnectInternet = true.obs;
  User? dataUser;
  @override
  void onInit(){
    super.onInit();
  }

  @override
  void dispose() {
    textControllerUserName.dispose();
    textControllerPassword.dispose();
    textControllerEmail.dispose();
    isObscure.value = true;
    acceptLogin.value = false;
    isAutoLogin.value = true;
    isLoading.value = false;
    super.dispose();
  }
  @override
  void onReady() async{
    await autoLogin();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<bool> postTokenFirebase()async{
    bool check = false;
    var t = await box.read('token');
    var id = await box.read('userID');
    LoginProvider().postTokenFireBase(id, t).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        check = true;
        print("OK TOKEN FIREBASE");
      }else{
        print("TOKEN FIREBASE NO ACCESS");
      }
    }).onError((error, stackTrace) { print(stackTrace.toString());});
    return check;
  }


 Future<bool> actionControllerLogin() async => LoginProvider().actionLogin(textControllerUserName.text.trim(), textControllerPassword.text.trim()).then((resp) async {
    if (resp.statusCode == 200 && resp.body["success"] == true) {
        print(resp.body["data"]);
        dataUser = User.fromJson(resp.body["data"]);
        await box.write('token', '${dataUser!.token}');
        await box.write('userID', dataUser!.id);
        await box.write('email', '${dataUser!.email}');
        await box.write('userName', '${dataUser!.ten}');
        await box.write('storeId', dataUser!.storeId);
        await box.write('enterpriseId', dataUser!.idDoanhNghiep);
        await box.write('role', "");
        for(var e in dataUser!.role!){
          if(e.ten == "admin"){
            await box.remove('role');
            await box.write('role', "admin");
            break;
          }
        }
        await permissionsController.GetPermissionsByID(dataUser!.id ?? "", dataUser!.token ?? "" );
        return true;
      } else {
        var message = resp.body["message"];
        showSnackBarError("Lỗi đăng nhập", 'Thông tin: ${message!}');
        return false;
      }
    }).onError((error, stackTrace){showSnackBarError("Đã Xảy Ra Lỗi", ErrorMessage); return false;});

  Future<void> autoLogin() async{
    isAutoLogin.value = true;
    var token = await box.read('token');
    var userID = await box.read('userID');
    var email = await box.read('email');
    print('token ${token}');
    print('userID ${userID}');
    print('email ${email}');
    await Future.delayed(Duration(milliseconds: 1000));
    await permissionsController.GetPermissionsByID(userID ?? "", token ?? "");
    if(token != null && token != ''){
      LoginProvider().GetProfile().then((resp){
        if(resp.statusCode == 200){
          isAutoLogin.value = false;
          Get.offAndToNamed('/home');
        }else{
          if(resp.statusCode == 401){
            isAutoLogin.value = false;
          }else{
            checkConnectInternet.value = false;
          }
        }
      }).onError((error, stackTrace){checkConnectInternet.value = false;});
    }
    isAutoLogin.value = false;
  }

  Future<bool> actionLogin()async{
    isLoading.value = true;
    if( textControllerUserName.text == ''){
      showSnackBarError("Tên đăng nhập rỗng", 'vui lòng điền tên đăng nhập!');
      isLoading.value = false;
      return false;
    }
    if( textControllerPassword.text == ''){
      showSnackBarError("Mật khẩu rỗng", 'vui lòng điền mật khẩu!');
      isLoading.value = false;
      return false;
    }
    var check = await actionControllerLogin();
    isLoading.value = false;
    return check;
  }

}
