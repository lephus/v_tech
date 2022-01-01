import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/modules/BillOfLadingHistory/BillOfLadingHistoryModel.dart';
import 'package:v_tech/app/modules/BillOfLadingHistory/providers/bill_of_lading_history_provider.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class BillOfLadingHistoryController extends GetxController {
  var now = DateTime.now();
  var from = "".obs;
  var to = "".obs;
  var indexPage = 1;
  TextEditingController tenKhachHang = new TextEditingController();
  TextEditingController tenNguoiTao = new TextEditingController();
  TextEditingController InputNumberKM = new TextEditingController();
  TextEditingController InputNote = new TextEditingController();

  var dateBillOfLadingHistory = "".obs;
  RxList listBillOfLadingHistory = [].obs;
  var isLoadBillOfLadingHistory = true.obs;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);


  @override
  void onInit() {
    from.value = '01-${now.month}-${now.year}';
    to.value = '${now.day+1}-${now.month}-${now.year}';

    super.onInit();
  }

  @override
  void onReady() async{
    await GetBillOfLadingHistory();
    super.onReady();
  }
  @override
  void dispose() {
    tenKhachHang.dispose();
    tenNguoiTao.dispose();
    InputNumberKM.dispose();
    InputNote.dispose();
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  void refreshDataEdit(){
    dateBillOfLadingHistory.value = '${now.day}-${now.month}-${now.year}';
    InputNote.text = "";
    InputNumberKM.text = "";
  }

  void setDataEdit(String date, String KM, String note){
    dateBillOfLadingHistory.value = date;
    InputNumberKM.text = KM;
    InputNote.text = note;
  }

  Future<void> GetBillOfLadingHistory()async{
    isLoadBillOfLadingHistory.value = true;
    indexPage = 1;
    await BillOfLadingHistoryProvider().GetBillOfLadingHistory(indexPage, from.value, to.value, tenKhachHang.text, tenNguoiTao.text).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        listBillOfLadingHistory.clear();
        List tmp = resp.body['data']['data'];
        for(int i=0; i< tmp.length ; i++){
          listBillOfLadingHistory.add(new BillOfLadingHistoryModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi lấy dữ liệu lịch sử vận đơn", "");
      }
    });
    isLoadBillOfLadingHistory.value = false;
  }

  Future<void> GetBillOfLadingHistoryLoadMore()async{
    await BillOfLadingHistoryProvider().GetBillOfLadingHistory(indexPage, from.value, to.value, tenKhachHang.text, tenNguoiTao.text).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        List tmp = resp.body['data']['data'];
        for(int i=0; i< tmp.length ; i++){
          listBillOfLadingHistory.add(new BillOfLadingHistoryModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi lấy dữ liệu lịch sử vận đơn", "");
      }
    });
  }

Future<void> EditBillOfLadingHistory(var id)async{
  await BillOfLadingHistoryProvider().EditBillOfLadingHistory(dateBillOfLadingHistory.value, InputNumberKM.text, InputNote.text, id).then((resp) async {
    if(resp.statusCode == 200 && resp.body['success'] == true){
      showSnackBarSuccess("Thành công", "Đã cập nhật lịch sử vận đơn!");
      await GetBillOfLadingHistory();
    }else{
      showSnackBarError("Thất bại", "Dữ liệu bạn nhận không đúng hoặc server từ chối yêu cầu!");
    }
  });
}

  Future<void> DeleteBillOfLadingHistory(var id)async{
    await BillOfLadingHistoryProvider().DeleteBillOfLadingHistory(id).then((resp) async {
      if(resp.statusCode == 200 && resp.body['success'] == true){
        showSnackBarSuccess("Xóa thành công", "");
        await GetBillOfLadingHistory();
      }else{
        showSnackBarError("Xóa thất bại", "");
      }
    });
  }

  void onRefresh() async{
    await GetBillOfLadingHistory();
    refreshController.refreshCompleted();
  }
  void onLoadMore() async{
    indexPage ++;
    await GetBillOfLadingHistoryLoadMore();
    refreshController.loadComplete();
  }
}
