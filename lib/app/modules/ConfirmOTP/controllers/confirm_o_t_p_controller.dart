import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/ConfirmOTP/providers/confirm_o_t_p_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class ConfirmOTPController extends GetxController {
  TextEditingController textControllerOTP = new TextEditingController();
  var message = '';
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    textControllerOTP.dispose();
    super.dispose();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  
  Future<bool> ValidateOTP(var userName, var phoneNumber, var otp, var key)async{
    isLoading.value = true;
    var tmp = false;
    await ConfirmOTPProvider().ValidateOTP(userName, phoneNumber, otp, key).then((resp) async {
      print(resp.body);
      isLoading.value = false;
      message = resp.body["message"];
      if (resp.body["success"] == true) {
        tmp = true;
      }else{
        showSnackBarError('Lỗi xác thực', '${message}');
      }
    }).onError((error, stackTrace) {
      showSnackBarError('Lỗi xác thực', '${stackTrace.toString()}');
    });
    return tmp;
  }
}
