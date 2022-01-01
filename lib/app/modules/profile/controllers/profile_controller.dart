import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/ListOrder/TrangThaiModel.dart';
import 'package:v_tech/app/modules/profile/ProfileModel.dart';
import 'package:v_tech/app/modules/profile/providers/profile_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  TextEditingController textControllerPasswordNew = new TextEditingController();
  TextEditingController textControllerConfirmPasswordNew = new TextEditingController();
  TextEditingController textControllerPasswordOld = new TextEditingController();
  TextEditingController textControllerPasswordTextInput = new TextEditingController();
  List<TrangThaiModel> trangThaiList = [];
  var indexSelectStatus = 0.obs;
  var isLoading = true.obs;
  var profileModel;

  @override
  void onInit() async{
    await GetListStatusType();

    super.onInit();
  }

  @override
  void onReady() async{
    await GetProfile();
    super.onReady();
  }

  @override
  void dispose() {
    textControllerPasswordNew.dispose();
    textControllerConfirmPasswordNew.dispose();
    textControllerPasswordOld.dispose();
    textControllerPasswordTextInput.dispose();
    super.dispose();
  }
  @override
  void onClose() {}

  Future<void> GetListStatusType()async{
    ProfileProvider().GetListStatusType().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        trangThaiList.clear();
        for(var element in resp.body["data"]){
          trangThaiList.add( TrangThaiModel.fromJson(element));
        }
      }else{
        showSnackBarError("Đã Xảy Ra Lỗi", "${resp.body["message"]}");
      }
    });
  }

  Future<void>UpdateProfile(ProfileModel p , var ma)async{
    Get.back();
    await ProfileProvider().UpdateProfile(p, ma).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        showSnackBarSuccess("Cập nhật thành công","đã thay đổi trạng thái dịch vụ!");
      }else{
        showSnackBarError("Lỗi truy vấn!","vui lòng thử lại sau vài phút!");
      }
    });
    await GetProfile();

  }
  Future<void>UpdatePass()async{
    Get.back();
    if(textControllerPasswordNew.text != textControllerConfirmPasswordNew.text){
      showSnackBarError("Nhập lại mật khẩu sai!","vui lòng nhập lại thông tin!");
    }else{
      var OldPass = textControllerPasswordOld.text;
      var NewPass = textControllerPasswordNew.text;
      var id = profileModel.id;
      textControllerConfirmPasswordNew.text = "";
      textControllerPasswordNew.text = "";
      textControllerPasswordOld.text = "";
      ProfileProvider().UpdatePass(OldPass, NewPass, id).then((resp){
        if (resp.statusCode == 200 && resp.body["success"] == true) {
          showSnackBarSuccess("Cập nhật thành công","đã thay đổi mật khẩu!");
        }else{
          showSnackBarError("Lỗi truy vấn!","vui lòng thử lại sau vài phút!");
        }
      });
    }
  }


  Future<void>GetProfile()async{
    isLoading.value = true;
    await ProfileProvider().GetProfile().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        profileModel = ProfileModel.fromJson(resp.body["data"]);
      }else{
        showSnackBarError("Lỗi truy vấn!","vui lòng thử lại sau vài phút!");
      }
    });
    if(profileModel != null){
      isLoading.value = false;
    }
  }
}
