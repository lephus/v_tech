import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/instance/providers/instance_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class InstanceController extends GetxController {
  TextEditingController textEditingControllerPassword = TextEditingController();
  var isObscure = true.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    textEditingControllerPassword.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  Future<void> truncatePassword()async{
    if(textEditingControllerPassword.text == ""){
      showSnackBarError("Vui lòng điền mật khẩu.", "");
    }else{
      isLoading.value = true;
      await InstanceProvider().truncate(textEditingControllerPassword.text).then((resp) => {
        if(resp.body['status'] == "failed"){
          showSnackBarError("Không thành công.", resp.body['data']['msg'])
        }else{
          showSnackBarSuccess("Thành công.", resp.body['data']['msg'])
        }
      });
      isLoading.value = false;
    }
  }
}
