import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/inforProduct/productInfor.dart';
import 'package:v_tech/app/modules/inforProduct/providers/infor_product_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class InforProductController extends GetxController{
  List<Tab> myTabs = <Tab>[
    Tab(text: 'TỒN KHO'),
    Tab(text: 'THÔNG TIN'),
  ];
  var id = Get.parameters['id'];
  ProductInfor? Product;
  var tongTon = 0.obs;
  List<LoModel> loList = [];
  List<SPDetailModel>listTonKho = [];
  var isLoadingTonKho = false.obs;
  var isLoadingInformation = false.obs;
  @override
  void onInit()async{
    await getInformationProductByID(id);
    super.onInit();
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> getInformationProductByID(var id)async {
    isLoadingInformation.value = true;
    InforProductProvider().GetProductByID(id).then((resp){
      print(resp.body);
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        Product = ProductInfor.fromJson(resp.body['data']);

        print(resp.body['data']);
      }else{
        showSnackBarError("Lỗi kết nối server", resp.body["message"]);
      }
      isLoadingInformation.value = false;
    });
  }

}
