import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/modules/OrderAssemble/AssembleModel.dart';
import 'package:v_tech/app/modules/OrderAssemble/providers/order_assemble_provider.dart';
import 'package:v_tech/app/modules/product/productInfo.dart';
import 'package:v_tech/app/modules/profile/ProfileModel.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

import '../AddInforModel.dart';
import '../LapRapModel.dart';

class OrderAssembleController extends GetxController {
  var profile;
  var pageIndex = 1, from = "", to = "", tenDichVu = "Tên dịch vụ".obs;

  DateTime now = new DateTime.now();
  var dateIsUpdate = false.obs;
  RxList assembleList = [].obs;
  var totalRecords = 0.obs;
  var isLoading = true.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  // ADD ASSEMBLE
  TextEditingController textControllerNumber = new TextEditingController();
  TextEditingController textControllerSearchProduct = new TextEditingController();
  TextEditingController textControllerSearchLapRap = new TextEditingController();
  TextEditingController textControllerUpdateQualityAssemble = new TextEditingController();
  var isInputSearchProduct = false.obs;
  var isInputSearchLapRap = false.obs;
  var SelectDate = "";
  RxList LapRaps = [].obs;
  RxList Products = [].obs;
  var isLoadAddAssemble = true.obs;
  var dateIsUpdateAdd = false.obs;
  var nameProduct = "Tên sản phẩm".obs;
  var idProduct = -1;
  var nameDV = "Tên dịch vụ".obs;
  List<AddInforModel> AddInfors = [];
  var ReLoadListAdd = false.obs;

// UPDATE
  var idUpdate = -1;
  var isLoadUpdateAssemble = true.obs;

  @override
  void onInit() async{
    textControllerNumber.text = "1";
    from = '${now.year}-${now.month}-01';
    var d = (now.day+1).toString();
    if( (now.day+1) < 10){
      d = "0"+d;
    }
    var d2 = (now.day).toString();
    if( (now.day) < 10){
      d2 = "0"+d2;
    }
    to = '${now.year}-${now.month}-${d}';
    SelectDate = '${now.year}-${now.month}-${d2}';
    await GetProfile();
    super.onInit();
  }


  @override
  void onReady() async{
    await GetLapRap();
    await GetDataOrderAssemble();
    super.onReady();
  }

  @override
  void dispose() {
    refreshController.dispose();
    textControllerNumber.dispose();
    textControllerSearchProduct.dispose();
    textControllerSearchLapRap.dispose();
    textControllerUpdateQualityAssemble.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  void onRefresh() async{
    await GetDataOrderAssemble();
    refreshController.refreshCompleted();
  }

  void onLoadMore() async{
    pageIndex++;
    await GetDataOrderAssembleLoadmore();
    refreshController.loadComplete();
  }

  void AddIn(var donGia, var id, var sl, var name){
    ReLoadListAdd.value = true;
    AddInfors.add(
        new AddInforModel(
          donGia: donGia,
          idLapRap: id,
          name: name,
          soLuong: sl
        )
    );
    ReLoadListAdd.value = false;
  }

  void removeAdd(int id){
    ReLoadListAdd.value = true;
    for(int i=0;i<AddInfors.length; i++){
      if(AddInfors[i].idLapRap == id){
        AddInfors.removeAt(i);
      }
    }
    ReLoadListAdd.value = false;
  }

  Future<void> GetDataOrderAssemble()async{
    isLoading.value =  true;
    pageIndex = 1;
    var p = tenDichVu.value;
    if(tenDichVu.value == 'Tên dịch vụ' || tenDichVu.value == "Tất cả"){
      p = "";
    }
    await OrderAssembleProvider().GetDataOrderAssemble(profile, 1, from, to, p).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        var tmp = resp.body['data'];
        List data = tmp['data'];
        totalRecords.value = tmp['totalRecords'];
        assembleList.clear();
        for(int i =0; i< data.length; i++){
          assembleList.add(new AssembleModel.fromJson(data[i]));
        }
      }else{
        showSnackBarError("Đã xảy ra lỗi!", "Vui lòng thử lại sau!");
      }
    });
    isLoading.value =  false;
  }

  Future<void> GetDataOrderAssembleLoadmore()async{
    var p = tenDichVu.value;
    if(tenDichVu.value == 'Tên dịch vụ' || tenDichVu.value == "Tất cả"){
      p = "";
    }
    await OrderAssembleProvider().GetDataOrderAssemble(profile, pageIndex, from, to, p, ).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        var tmp = resp.body['data'];
        List data = tmp['data'];
        for(int i =0; i< data.length; i++){
          assembleList.add(new AssembleModel.fromJson(data[i]));
        }
      }else{
        showSnackBarError("Đã xảy ra lỗi!", "Vui lòng thử lại sau!");
      }
    });
  }

  Future<void> GetProfile()async{
    await OrderAssembleProvider().GetProfile().then((resp){
      profile = ProfileModel.fromJson(resp.body['data']);
    });
  }

  Future<void> GetLapRap()async{
    isLoadAddAssemble.value = true;
    await GetProduct();
    await OrderAssembleProvider().GetLapRap(profile).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        var tmp = resp.body['data'];
        List data = tmp['data'];
        for(int i =0; i< data.length; i++){
          LapRaps.add(new LapRapModel.fromJson(data[i]));
        }
      }
    });
    isLoadAddAssemble.value = false;
  }

  Future<void> GetProduct()async{
    await OrderAssembleProvider().GetProduct().then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        var tmp = resp.body['data'];
        List data = tmp['data'];
        for(int i =0; i< data.length; i++){
          Products.add(new ProductModel.fromJson(data[i]));
        }
      }
    });
  }

  Future<void> AddOrderAssemble()async{
    ReLoadListAdd.value = true;
    if(idProduct == -1){
      showSnackBarError("Thêm thất bại", 'dữ liệu bạn nhập không hợp lệ!');
    }else {
      await OrderAssembleProvider().AddOrderAssemble(
          AddInfors, idProduct, SelectDate).then((resp) {
        if (resp.statusCode == 200 && resp.body['success'] == true) {
          showSnackBarSuccess("Thêm thành công!", "");
        } else {
          showSnackBarError("Thêm thất bại", 'dữ liệu bạn nhập không hợp lệ!');
        }
      });
    }
    nameProduct.value = "Tên sản phẩm";
    idProduct = -1;
    nameDV.value = "Tên dịch vụ";
    AddInfors.clear();
    ReLoadListAdd.value = false;
  }

  Future<void> DeleteOrderAssemble(var id)async{
      await OrderAssembleProvider().DeleleOrderAssemble(
          id).then((resp) {
        if (resp.statusCode == 200 && resp.body['success'] == true) {
          showSnackBarSuccess("Xóa thành công!", "");
        } else {
          showSnackBarError("Xóa thất bại", '');
        }
      });
  }

  Future<void> GetDetailOrderAssemble(var id)async{
    isLoadUpdateAssemble.value = true;
    await OrderAssembleProvider().GetDetailOrderAssemble(
        id).then((resp) {
      if (resp.statusCode == 200 && resp.body['success'] == true) {
        AddInfors.clear();
        var data = resp.body['data'];
        nameProduct.value = data['tenDichVu'];
        idProduct= data['id_SanPham'];
        List tmp = [];
        tmp = data['chiTiets'];
        for(int i=0;i<tmp.length; i++){
          AddInfors.add(new AddInforModel(
            soLuong: tmp[i]['soLuong'],
            idLapRap: tmp[i]['id_LapRap'],
            donGia: tmp[i]['donGia'],
            name: tmp[i]['tenDichVu'],
          ));
        }
      }
    });
    isLoadUpdateAssemble.value = false;
  }

  Future<void> UpdateOrderAssemble()async{
    await OrderAssembleProvider().UpdateOrderAssemble(
        AddInfors, idProduct, SelectDate, idUpdate).then((resp) {
      if (resp.statusCode == 200 && resp.body['success'] == true) {
        showSnackBarSuccess("Cập nhật thành công", 'dữ liệu bạn nhập không hợp lệ!');
      } else {
        showSnackBarError("Cập nhật thất bại", 'dữ liệu bạn nhập không hợp lệ!');
      }
    });
    nameProduct.value = "Tên sản phẩm";
    idProduct = -1;
    nameDV.value = "Tên dịch vụ";
  }

  void cleanData(){
    AddInfors.clear();
    nameProduct.value = "Tên sản phẩm";
    idProduct = -1;
    nameDV.value = "Tên dịch vụ";
  }


}
