import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/modules/Repair/DetailRepairModel.dart';
import 'package:v_tech/app/modules/Repair/RepairModel.dart';
import 'package:v_tech/app/modules/Repair/providers/repair_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class RepairController extends GetxController {
  var now = DateTime.now();
  List<Tab> myTabs = <Tab>[];
  // REPAIR
  var pageIndex = 1;
  var startDate = "".obs;
  var endDate = "".obs;
  var isLoadingRepair = true.obs;
  var isLoadingMenuNCC = true.obs;
  var totalRecordsRepair = 0.obs;
  var indexNCC = 0.obs;
  List<String> DataStringNCC = ["--Tên nhà cung cấp--"];
  List<int> IDNCC = [];
  var indexTrangThaiPhieu = 0.obs;
  List<String> TrangThaiPhieuMenu = ["--Trạng thái--", "Đang sửa", "Đã hoàn thành", "Chưa có vật tư", "Đã có vật tư"];
  List<String> TrangThaiPhieu = ["", "DANG_SUA", "DA_HOAN_THANH", "CHUA_CO_VAT_TU", "DA_CO_VAT_TU"];
  List<String> TrangThaiPhieuUpdate = ["", "Dang_Sua", "Da_Hoan_Thanh", "Chua_Co_Vat_Tu", "Da_Co_Vat_Tu"];

  var indexLoaiYeuCau = 0.obs;
  List<String> LoaiYeuCauMenu = ["--Loại yêu cầu--", "Sửa chữa", "Bảo hành", "Lỗi"];
  List<String> LoaiYeuCau = ["", "SUA_CHUA", "BAO_HANH", "LOI"];
  RxList listRepair = [].obs;
  ScrollController scrollControllerRepair = ScrollController();
  RefreshController refreshControllerRepair = RefreshController(initialRefresh: false);
  List<String> KhachHangMenu = ["--Khách hàng--"];
  List<String> KhachHang = [];
  var indexKhachHang = 0.obs;
  TextEditingController inputNameCustomer = new TextEditingController();
  TextEditingController inputNameNCC = new TextEditingController();
  var isInputNameCustomer = false.obs;
  var isInputNameNCC = false.obs;
  var showCustomerOrNCC = 0.obs;
  var isLoadDetailBillRepair = false.obs;
  var detailBillRepairData;

  // LIST DETAIL REPAIR
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  var totalRecords = 0.obs;
  RxList detailRepairs = [].obs;
  var pageIndexRepair = 1;
  var startDateRepair = "".obs;
  var endDateRepair = "".obs;
  var trangThaiUpdate = 0.obs;
  TextEditingController TextEditingControllerghiChuUpdate = new TextEditingController();
  TextEditingController ImeiRepair = new TextEditingController();


  @override
  void onInit() {
    myTabs.add(Tab(text: 'PHIẾU SỬA CHỮA'));
    myTabs.add(Tab(text: 'CHI TIẾT SỬA CHỮA'));
    var prevDay = new DateTime(now.year, now.month, now.day - 15);
    startDate.value = '${prevDay.day}-${prevDay.month}-${prevDay.year}';
    endDate.value = '${now.day+1}-${now.month}-${now.year}';
    startDateRepair.value = startDate.value;
    endDateRepair.value = endDate.value;
    super.onInit();
  }

  @override
  void onReady() async{
    await GetNCC();
    await GetKhachHang();
    await GetRepair();
    await GetDetailRepair();
    super.onReady();
  }

  @override
  void dispose() {
    refreshControllerRepair.dispose();
    scrollControllerRepair.dispose();
    inputNameCustomer.dispose();
    inputNameNCC.dispose();
    refreshController.dispose();
    scrollController.dispose();
    TextEditingControllerghiChuUpdate.dispose();
    ImeiRepair.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  Future<void> GetRepair()async{
    isLoadingRepair.value = true;
    pageIndex = 1;
    await RepairProvider().GetRepair(pageIndex, startDate.value, endDate.value, TrangThaiPhieu[indexTrangThaiPhieu.value], LoaiYeuCau[indexLoaiYeuCau.value], GetIDKhachHang(), GetIdNCC()).then((resp){
      if(resp.statusCode == 200 && resp.body['success']  == true){
        var data = resp.body['data'];
        totalRecordsRepair.value = data['totalRecords'];
        List tmp = data['data'];
        listRepair.clear();
        for(int i=0; i<tmp.length; i++){
          listRepair.add(new RepairModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi truy vấn dữ liệu", "");
      }
    });
    isLoadingRepair.value = false;
  }
  Future<void> GetRepairLoadMore()async{
    await RepairProvider().GetRepair(pageIndex, startDate.value, endDate.value, TrangThaiPhieu[indexTrangThaiPhieu.value], LoaiYeuCau[indexLoaiYeuCau.value], GetIDKhachHang(), GetIdNCC()).then((resp){
      if(resp.statusCode == 200 && resp.body['success']  == true){
        var data = resp.body['data'];
        List tmp = data['data'];
        totalRecordsRepair.value += int.parse(data['totalRecords'].toString());
        for(int i=0; i<tmp.length; i++){
          listRepair.add(new RepairModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi truy vấn dữ liệu", "");
      }
    });
  }
  void onRefreshRepair() async{
    await GetRepair();
    refreshControllerRepair.refreshCompleted();
  }
  void onLoadMoreRepair() async{
    pageIndex++;
    await GetRepairLoadMore();
    refreshControllerRepair.loadComplete();
  }
  Future<void> GetNCC()async{
    isLoadingMenuNCC.value = true;
    await RepairProvider().GetNhaCungCap().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        IDNCC.clear();
        for(var element in resp.body["data"]["data"]){
          DataStringNCC.add(element['ten']);
          IDNCC.add(element['id']);
        }
      }
    });
    isLoadingMenuNCC.value = false;
  }
  Future<void> GetKhachHang()async{
    isLoadingMenuNCC.value = true;
    await RepairProvider().GetCustomer().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        for(var element in resp.body["data"]["data"]){
          KhachHangMenu.add(element['tenDayDu']);
          KhachHang.add(element['id'].toString());
        }
      }
    });
    isLoadingMenuNCC.value = false;
  }
  String GetIdNCC(){
    if(indexNCC.value == 0){
      return "";
    }
    return IDNCC[indexNCC.value - 1].toString();
  }
  String GetIDKhachHang(){
    if(indexKhachHang.value == 0){
      return "";
    }
    return KhachHang[indexKhachHang.value - 1].toString();
  }
  String convertTrangThai(String s){
    for(int i = 1 ; i < TrangThaiPhieu.length ; i++){
      if(s.toUpperCase() == TrangThaiPhieu[i]){
        return TrangThaiPhieuMenu[i];
      }
    }
    return "";
  }
  String convertLoai(String s){
    for(int i = 1 ; i < LoaiYeuCau.length ; i++){
      if(s.toUpperCase() == LoaiYeuCau[i]){
        return LoaiYeuCauMenu[i];
      }
    }
    return "";
  }

  Future<void> GetDetailBillRepair(var id)async{
    isLoadDetailBillRepair.value = true;
    await RepairProvider().GetDetailBillRepair(id).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        detailBillRepairData = resp.body['data'];
      }
    });
    isLoadDetailBillRepair.value = false;
  }

  void ConverTrangThaiToID(String trangthai){
    for(int i = 0 ; i < TrangThaiPhieu.length ; i++){
      if(trangthai.toUpperCase() == TrangThaiPhieu[i]){
        trangThaiUpdate.value = i;
      }
    }
  }


  // LIST DETAIL REPAIR

  Future<void> GetDetailRepair()async{
    pageIndexRepair = 1;
    await RepairProvider().GetDetailRepair(pageIndexRepair, startDateRepair.value, endDateRepair.value, TrangThaiPhieuUpdate[indexTrangThaiPhieu.value], LoaiYeuCau[indexLoaiYeuCau.value], GetIDKhachHang(), GetIdNCC(), ImeiRepair.text).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        totalRecords.value =  resp.body["data"]["totalRecords"] ?? 0;
        detailRepairs.clear();
        for(var element in resp.body["data"]["data"]){
          detailRepairs.add(new DetailRepairModel.fromJson(element));
        }
      }
    });
  }
  Future<void> GetDetailRepairLoadMore()async{
    await RepairProvider().GetDetailRepair(pageIndexRepair, startDateRepair.value, endDateRepair.value, TrangThaiPhieuUpdate[indexTrangThaiPhieu.value], LoaiYeuCau[indexLoaiYeuCau.value], GetIDKhachHang(), GetIdNCC(), ImeiRepair.text).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        totalRecords.value +=  int.parse(resp.body["data"]["totalRecords"].toString());
        for(var element in resp.body["data"]["data"]){
          detailRepairs.add(new DetailRepairModel.fromJson(element));
        }
      }
    });
  }


  Future<void> UpdateDetailRepair(var id)async{
    await RepairProvider().UpdateDetailRepair(id, TrangThaiPhieuUpdate[trangThaiUpdate.value], TextEditingControllerghiChuUpdate.text).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        showSnackBarSuccess("Cập nhật thành công", "");
      }else{
        showSnackBarError("Cập nhật thất bại", "");
      }
    });
    await GetDetailRepair();
  }



  void onRefresh() async{
    await GetDetailRepair();
    refreshController.refreshCompleted();
  }
  void onLoadMore() async{
    await pageIndexRepair++;
    await GetDetailRepairLoadMore();
    refreshController.loadComplete();
  }

}
