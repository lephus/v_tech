import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/data/constants/constants.dart';
import 'package:v_tech/app/modules/product/productInfo.dart';
import 'package:v_tech/app/modules/product/providers/product_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class ProductController extends GetxController {
  RxInt selected = 0.obs;
  TextEditingController textControllerSearchProduct = new TextEditingController();
  List listType = [{"id": -1 , "ten":"Tất cả"}];
  RxList listDataTable = [].obs;
  RxInt totalRecords = 0.obs;
  var textViewSearch = "Tìm kiếm".obs;
  var isLoading = true.obs;
  var pageIndex = 1;
  var pageSize = 20;
  var order = "";
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);



  @override
  void onInit()async{
    await GetListTypeProduct();
    await GetDataTableProduct("");
    super.onInit();
  }

  @override
  void dispose() {
    textControllerSearchProduct.dispose();
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }
  @override
  void onReady() async{
    super.onReady();
  }

  @override
  void onClose() {}

  setSelected(element) {
    selected.value = element;
  }

  Future<void> GetListTypeProduct()async {
    ProductProvider().GetListTypeProductProvider().then((resp){
      var message = resp.body["message"];
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        listType.addAll(resp.body["data"]);
      }else{
        showSnackBarError("Đã Xảy Ra Lỗi", "${message}");
      }
    }).onError((error, stackTrace) => showSnackBarError("Đã Xảy Ra Lỗi", ErrorMessage));
  }

  Future<void> GetDataTableProduct(var search)async{
    isLoading.value = true;
    var idTypeProduct = "";
    if(selected.value > 0){
      idTypeProduct = listType[selected.value - 1]['id'].toString();
    }
    ProductProvider().GetDataProduct(search, 1, pageSize, order, idTypeProduct).then((resp){
      var message = resp.body["message"];
      isLoading.value = false;
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        listDataTable.clear();
        var data = resp.body["data"];
        totalRecords.value = data['totalRecords'];
        List tmp =[];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length ; i++) {
          listDataTable.add(new ProductModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi kết nối", "${message}");
      }
    });
  }

  Future<void> GetDataTableProductLoadMore(var search)async{
    var idTypeProduct = "";
    if(selected.value > 0){
      idTypeProduct = listType[selected.value - 1]['id'].toString();
    }
    ProductProvider().GetDataProduct(search, pageIndex, pageSize, order, idTypeProduct).then((resp){
      var message = resp.body["message"];
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        var data = resp.body["data"];
        totalRecords.value = data['totalRecords'];
        List tmp =[];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length ; i++) {
          listDataTable.add(new ProductModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi kết nối", "${message}");
      }
    });
  }


  void onRefresh() async{
    pageIndex = 1;
    await GetDataTableProduct(textControllerSearchProduct.text);
    refreshController.refreshCompleted();
  }
  void onLoadMore() async{
    pageIndex ++;
    await GetDataTableProductLoadMore(textControllerSearchProduct.text);
    refreshController.loadComplete();
  }

  void onLoading() async{
    refreshController.loadComplete();
  }
}
