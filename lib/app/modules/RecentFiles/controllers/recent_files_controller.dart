import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/RecentFiles/NotifyModel.dart';
import 'package:v_tech/app/modules/RecentFiles/providers/recent_files_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class RecentFilesController extends GetxController {
  var isLoading = true.obs;
  List<NotifyModel> notifyList = [];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async{
    await GetNotify();
    super.onReady();
  }

  @override
  void onClose() {}

Future<void> GetNotify()async{
    isLoading.value = true;
    await RecentFilesProvider().GetNotifySystem().then((resp){
      print(resp);
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        List tmp =[];
        tmp.addAll(resp.body["data"]);
        notifyList.clear();
        for (var i = 0; i < tmp.length ; i++) {
          notifyList.add(new NotifyModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi nhận thông báo", "");
      }
      isLoading.value = false;
    });
}
}
