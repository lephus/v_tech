import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/constants/constants.dart';
import 'package:v_tech/app/modules/register/providers/register_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class RegisterController extends GetxController {
  TextEditingController textControllerUserName = new TextEditingController();
  TextEditingController textControllerEmail = new TextEditingController();
  TextEditingController textControllerPassword = new TextEditingController();
  TextEditingController textControllerConfirmPassword = new TextEditingController();
  TextEditingController textControllerPhone = new TextEditingController();
  TextEditingController textControllerNameShop = new TextEditingController();
  var isObscure = true.obs;
  var isObscureConfirm = true.obs;
  var isLoading = false.obs;
  var accessRegister = false.obs;
  var message = "";
  @override
  void onInit() {
    super.onInit();
  }
@override
  void dispose() {
    textControllerUserName.dispose();
    textControllerEmail.dispose();
    textControllerPassword.dispose();
    textControllerConfirmPassword.dispose();
    textControllerPhone.dispose();
    textControllerNameShop.dispose();
    super.dispose();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> Register() async{
    if(
      textControllerUserName.text==""||
      textControllerPassword.text==""||
      textControllerConfirmPassword.text==""||
      textControllerPhone.text==""||
      textControllerEmail.text==""||
      textControllerNameShop.text==""
    ){
      showSnackBarError('Thiếu thông tin', 'Vui lòng điền đủ các thông tin phía dưới!');
      return;
    }else {
      if (textControllerPassword.text != textControllerConfirmPassword.text) {
        showSnackBarError('Xác thực thất bại', 'Nhập lại mật khẩu không đúng!');
      } else {
        message = "";
        isLoading.value = true;
        RegisterProvider().actionRegister(
            textControllerUserName.text,
            textControllerPassword.text,
            textControllerConfirmPassword.text,
            textControllerPhone.text,
            textControllerEmail.text,
            textControllerNameShop.text
        ).then((resp) {
          print(resp.body);
          resp.body['message'] == null ? message = "" : message = resp.body['message'];
          if (resp.statusCode == 200 && resp.body["success"] == true) {
            showSnackBarSuccess('Đăng ký thành công','Vui lòng kiểm tra Email để xác nhận tài khoản VTECH !');
            accessRegister.value = true;
            Get.toNamed('/confirm-o-t-p', arguments: [textControllerUserName.text, textControllerPhone.text, resp.body['data']['key']]);
          } else {
            showSnackBarError('Đăng ký thất bại', '${message}');
          }
        }).onError((error, stackTrace) => showSnackBarError("Đã Xảy Ra Lỗi", ErrorMessage));
      }
    }
    isLoading.value = false;
  }
}
