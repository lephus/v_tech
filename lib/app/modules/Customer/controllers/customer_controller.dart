import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/modules/Customer/CustomerModel.dart';
import 'package:v_tech/app/modules/Customer/HistoryOrderModel.dart';
import 'package:v_tech/app/modules/Customer/providers/customer_provider.dart';
import 'package:v_tech/app/modules/ListOrder/TrangThaiModel.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class CustomerController extends GetxController {
  var now = DateTime.now();
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  ScrollController scrollControllerDetail = ScrollController();
  RefreshController refreshControllerDetail = RefreshController(initialRefresh: false);
  TextEditingController textControllerSearch = new TextEditingController();

  RxList listCustomerModel = [].obs;
  RxList listOrder = [].obs;
  List<TrangThaiModel> trangThaiList = [];
  var reverse = false;
  var isLoadingListCustomerModel = false.obs;
  var isLoadingDetailCustomerOrder = false.obs;
  var pageIndex = 1;
  var totalRecords = 0.obs;
  var dateIsUpdate = false.obs;
  String startDate =  'Ngày bắt đầu';
  String endDate = 'Ngày kết thúc';
  var indexOrerDetail = 1;
  var ID_DETAIL = 0;
  var quaGioiHanCongNo = false.obs;
  @override
  void onInit() async{
    var prevDay = new DateTime(now.year, now.month-1, now.day);
    startDate = '${prevDay.day}-${prevDay.month}-${prevDay.year}';
    endDate = '${now.day+1}-${now.month}-${now.year}';
    await GetListStatusType();
    await GetListCustomerData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
@override
  void dispose() {
    scrollController.dispose();
    scrollControllerDetail.dispose();
    textControllerSearch.dispose();
    super.dispose();
  }
  @override
  void onClose() {}

  void onRefresh() async{
    refreshController.refreshCompleted();
  }

  void onLoadMore() async{
    pageIndex++;
    await GetListCustomerDataLoadMore(pageIndex);
    refreshController.loadComplete();
  }

  void onRefreshHistoryOrder(){
    refreshControllerDetail.refreshCompleted();
  }

  void onLoadMoreHistoryOrder()async{
    indexOrerDetail+=1;
    await GetDetailOrderDataLoadMore(ID_DETAIL);
    refreshControllerDetail.loadComplete();
  }
  void OnChangeQuaCongNo(){
    if(quaGioiHanCongNo.value == true){
      quaGioiHanCongNo.value = false;
    }else{
      quaGioiHanCongNo.value = true;
    }
  }
  String getStatus(String ma){
    for(TrangThaiModel element in trangThaiList){
      if(ma == element.ma) return element.ten!;
    }
    return "";
  }

  Future<void> GetListStatusType()async{
    CustomerProvider().GetListStatusType().then((resp){
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

  Future<void> GetListCustomerData()async {
    isLoadingListCustomerModel.value = true;
    CustomerProvider().GetListCustomer(1, false, "").then((resp){
      if(resp.body['success'] == true && resp.statusCode == 200){
        var data = resp.body["data"];
        totalRecords.value = int.parse(data['totalRecords'].toString());
        List tmp =[];
        listCustomerModel.clear();
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length ; i++) {
          listCustomerModel.add(new CustomerModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi kết nối", "${resp.body["message"]}");
      }
      isLoadingListCustomerModel.value = false;
    });
  }

  Future<void> GetListCustomerDataLoadMore(pageIndex)async {
    CustomerProvider().GetListCustomer(pageIndex, quaGioiHanCongNo.value, textControllerSearch.text).then((resp){
      if(resp.body['success'] == true && resp.statusCode == 200){
        var data = resp.body["data"];
        totalRecords.value += int.parse(data['totalRecords'].toString());
        List tmp =[];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length ; i++) {
          listCustomerModel.add(new CustomerModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi kết nối", "${resp.body["message"]}");
      }
    });
  }

  Future<void> GetDetailOrderData(var id)async {
    isLoadingDetailCustomerOrder.value = true;
    indexOrerDetail = 1;
    await CustomerProvider().GetDetailOrder(id, indexOrerDetail, startDate, endDate ).then((resp){
      print(resp.body);
      listOrder.clear();
      if(resp.body['success'] == true && resp.statusCode == 200) {
        var data = resp.body["data"];
        List tmp = [];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length; i++) {
          listOrder.add(new HistoryOrderModel.fromJson(tmp[i]));
        }
      }
      isLoadingDetailCustomerOrder.value = false;
    });
  }
  Future<void> GetDetailOrderDataLoadMore(var id)async {
    CustomerProvider().GetDetailOrder(id, indexOrerDetail, startDate, endDate ).then((resp){
      if(resp.body['success'] == true && resp.statusCode == 200) {
        var data = resp.body["data"];
        List tmp = [];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length; i++) {
          listOrder.add(new HistoryOrderModel.fromJson(tmp[i]));
        }
      }
    });
  }
}
