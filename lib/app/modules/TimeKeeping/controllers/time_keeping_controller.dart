import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/modules/TimeKeeping/DivisionModel.dart';
import 'package:v_tech/app/modules/TimeKeeping/providers/time_keeping_provider.dart';
import 'package:v_tech/app/utils/notification_local.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

import '../HistoryTimeKeepingModel.dart';
import '../TimeKeepingModel.dart';

class TimeKeepingController extends GetxController {
  final box = GetStorage();
  var isAdmin = false.obs;
  var now = DateTime.now();
  List<Tab> myTabs = <Tab>[ Tab(text:"CHỜ DUYỆT"),Tab(text:"CHẤP THUẬN"), Tab(text:"TỪ CHỐI")];

  // CHOOSE TIME KEEPING
  RxList listChooseTimeKeeping = [].obs;
  Timer? timer;
  var userName = "Loading...".obs;
  var email = "".obs;
  var idPhanCa = "".obs;
  var NameDivision = "Vsofh time keeping".obs;
  var BoxDecorationIdPhanCa = Colors.green.obs;
  var statusPhanCa = "Loading...".obs;
  var Hour = DateTime.now().hour.obs;
  var Minute = DateTime.now().minute.obs;
  var NameShift = "".obs;
  var TimeShift = "".obs;
  var HourTimeShift = 0.obs;
  var MinuteTimeShift = 0.obs;
  var indexSelect = 0.obs;

  // HISTORY TIME KEEPING
  TextEditingController textControllerUserName = new TextEditingController();
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  var isLoadStaff = false.obs;
  List<String> NhanVienMenu = ["--Nhân viên--"];
  List<String> NhanViens = [];
  var indexNhanVien = 0.obs;
  var from = "".obs;
  var to = "".obs;
  var pageIndex = 1;
  RxList historyList = [].obs;
  var isLoadingHistory = true.obs;

  // MANAGER TIMEKEEPING
  RxList AwaitAcceptList = [].obs;
  var pageIndexAwaitAcceptList = 1;
  var fromAwaitAcceptList = "".obs;
  var toAwaitAcceptList = "".obs;
  var idLoadAwaitAcceptList = true.obs;
  ScrollController scrollControllerAwaitAccept = ScrollController();
  RefreshController refreshControllerAwaitAccept = RefreshController(initialRefresh: false);

  RxList AcceptedList = [].obs;
  var pageIndexAcceptedList = 1;
  var fromAcceptedList = "".obs;
  var toAcceptedList = "".obs;
  var idLoadAcceptedList = true.obs;
  ScrollController scrollControllerAccepted = ScrollController();
  RefreshController refreshControllerAccepted = RefreshController(initialRefresh: false);

  RxList RefuseAcceptList = [].obs;
  var pageIndexRefuseAcceptList = 1;
  var fromRefuseAcceptList = "".obs;
  var toRefuseAcceptList = "".obs;
  var idLoadRefuseAcceptList = true.obs;
  ScrollController scrollControllerRefuseAccept = ScrollController();
  RefreshController refreshControllerRefuseAccept = RefreshController(initialRefresh: false);

  var lengthAwaitAcceptList = 0.obs;
  var lengthAcceptedList = 0.obs;
  var lengthRefuseAcceptList = 0.obs;

  @override
  void onInit() async{
    indexSelect.value = -1;
    var prevDay = new DateTime(now.year, now.month-1, now.day);
    from.value = '${prevDay.day}-${prevDay.month}-${prevDay.year}';
    to.value = '${now.day+1}-${now.month}-${now.year}';
    fromAwaitAcceptList.value = from.value;
    toAwaitAcceptList.value = to.value;
    fromAcceptedList.value = from.value;
    toAcceptedList.value = to.value;
    fromRefuseAcceptList.value = from.value;
    toRefuseAcceptList.value = to.value;
    super.onInit();
  }

  @override
  void onReady() async{
    await checkDivision();
    await GetListDivision();
    await box.read('role') == "admin" ? isAdmin.value = true : isAdmin.value = false;
    GetAwaitAcceptList();
    GetAcceptedList();
    GetRefuseAcceptList();
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => UpdateTime());
    super.onReady();
  }

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    textControllerUserName.dispose();
    refreshControllerAwaitAccept.dispose();
    scrollControllerAwaitAccept.dispose();
    refreshControllerAccepted.dispose();
    scrollControllerAccepted.dispose();
    refreshControllerRefuseAccept.dispose();
    scrollControllerRefuseAccept.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    timer!.cancel();
  }
  // NOTIFICATION

  // CHOOSE TIME KEEPING
  Future<void> GetListDivision()async{
    TimeKeepingProvider().GetListDivision().then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        for(var element in resp.body['data']['data']){
          listChooseTimeKeeping.add(new DivisionModel.fromJson(element));
        }
      }else{
        showSnackBarError("Lỗi nhận danh sách phân ca", "");
      }
    });
  }
  Future<void> ChooseDivision()async{
    DivisionModel item = listChooseTimeKeeping[indexSelect.value];
    var id = item.id;
    await TimeKeepingProvider().ChooseDivision(id).then((resp)async{
      if(resp.statusCode == 200 && resp.body['success'] == true){
        NotificationLocal.showNotification(title: "Vào ca",body:  "${item.caLamViec!.ten} (${item.caLamViec!.thoiGianVaoStr} - ${item.caLamViec!.thoiGianVeStr})",payLoad: "");
        await box.write("idPhanCa", "${id}");
        await box.write("NameDivision", "${item.caLamViec!.ten} (${item.caLamViec!.thoiGianVaoStr} - ${item.caLamViec!.thoiGianVeStr})");
        idPhanCa.value = "$id";
        statusPhanCa.value = "Ra ca";
        NameDivision.value = " ${item.caLamViec!.ten} (${item.caLamViec!.thoiGianVaoStr} - ${item.caLamViec!.thoiGianVeStr})";
        BoxDecorationIdPhanCa.value = Colors.red;
        Get.back();
      }
    }).onError((error, stackTrace) => showSnackBarError("Lỗi yêu cầu", "Vui lòng thử lại!"));
  }
  Future<void> NextToChooseTimeKeeping()async{
    var tmp =  await box.read("idPhanCa") ?? "";
    String body = "${await box.read("NameDivision") ?? ''}";
    if(tmp!=""){ // DA CO CA LAM
      await TimeKeepingProvider().ChooseDivision(tmp).then((resp)async{
        if(resp.statusCode == 200 && resp.body['success'] == true){
          await NotificationLocal.showNotification(title: "Ra ca",body:  "${body}",payLoad: "");
          await box.remove("idPhanCa");
          await box.remove("NameDivision");
          statusPhanCa.value = "Vào ca";
          BoxDecorationIdPhanCa.value = Colors.green;
          NameDivision.value = "wish you good day!";
        }
      }).onError((error, stackTrace) => showSnackBarError("Lỗi yêu cầu", "Vui lòng thử lại!"));
    }else { // CHUA CO CA LAM
      Get.toNamed("/choose-time-keeping");
    }
  }
  Future<void> checkDivision()async{
    idPhanCa.value = await box.read("idPhanCa") ?? "";
    NameDivision.value = await box.read("NameDivision") ?? "wish you good day!";
    email.value = await box.read("email") ?? "";
    userName.value = await box.read("userName") ?? "";
    print("idPhanCa ${idPhanCa.value}");
    if(idPhanCa.value == ""){
      statusPhanCa.value = "Vào ca";
      BoxDecorationIdPhanCa.value = Colors.green;
    }else{
      statusPhanCa.value = "Ra ca";
      BoxDecorationIdPhanCa.value = Colors.red;
    }
  }
  void UpdateTime(){
   Hour.value = DateTime.now().hour;
   Minute.value = DateTime.now().minute;
 }

  // HISTORY TIME KEEPING
  Future<void> GetHistoryTimeKeeping()async{
    isLoadingHistory.value = true;
    pageIndex = 1;
    await TimeKeepingProvider().GetHistoryTimeKeeping(from.value, to.value, GetIDNhanVien(), pageIndex).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        historyList.clear();
        for(var element in resp.body['data']['data']){
          historyList.add( new HistoryTimeKeepingModel.fromJson(element));
        }
      }else{
        showSnackBarError("Bạn không có quyền!", "");
      }
    });
    isLoadingHistory.value = false;
  }
  Future<void> GetHistoryTimeKeepingLoadMore()async{
    await TimeKeepingProvider().GetHistoryTimeKeeping(from.value, to.value, GetIDNhanVien(), pageIndex).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        for(var element in resp.body['data']['data']){
          historyList.add( new HistoryTimeKeepingModel.fromJson(element));
        }
      }
    });
  }
  Future<void> GetStaff()async{
    isLoadStaff.value = true;
    await TimeKeepingProvider().GetStaff().then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        NhanVienMenu.clear();
        NhanVienMenu.add("--Nhân viên--");
        NhanViens.clear();
        for(var element in resp.body['data']['data']){
          NhanVienMenu.add(element['ten']);
          NhanViens.add(element['id'].toString());
        }
      }
    });
    isLoadStaff.value = false;
  }


  String GetIDNhanVien()=>indexNhanVien.value == 0 ? "" : NhanViens[indexNhanVien.value-1];


  void onRefreshHistory() async{
    await GetHistoryTimeKeeping();
    refreshController.refreshCompleted();
  }
  void onLoadMoreHistory() async{
    pageIndex++;
    await GetHistoryTimeKeepingLoadMore();
    refreshController.loadComplete();
  }

  // MANAGER TIME KEEPING
  // -------- AWAIT ACCEPT ---------------
  Future<void> GetAwaitAcceptList()async{
    pageIndexAwaitAcceptList = 1;
    idLoadAwaitAcceptList.value = true;
    await TimeKeepingProvider().ManagerTimeKeeping(fromAwaitAcceptList.value, toAwaitAcceptList.value,"cho_duyet", pageIndexAwaitAcceptList).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        AwaitAcceptList.clear();
        for(var element in resp.body['data']['data']){
          AwaitAcceptList.add( new TimeKeepingModel.fromJson(element));
        }
      }
      lengthAwaitAcceptList.value = AwaitAcceptList.length;
    });
    idLoadAwaitAcceptList.value = false;
  }
  Future<void> GetAwaitAcceptListLoadMore()async{
    pageIndexAwaitAcceptList++;
    await TimeKeepingProvider().ManagerTimeKeeping(fromAwaitAcceptList.value, toAwaitAcceptList.value,"cho_duyet", pageIndexAwaitAcceptList).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        for(var element in resp.body['data']['data']){
          AwaitAcceptList.add( new TimeKeepingModel.fromJson(element));
        }
        AwaitAcceptList.refresh();
      }
    });
  }
  void onRefreshAwaitAccept() async{
    await GetAwaitAcceptList();
    refreshControllerAwaitAccept.refreshCompleted();
  }
  void onLoadMoreAwaitAccept() async{
    await GetAwaitAcceptListLoadMore();
    refreshControllerAwaitAccept.loadComplete();
  }


  // -------- ACCEPTED ---------------
  Future<void> GetAcceptedList()async{
    pageIndexAcceptedList = 1;
    idLoadAcceptedList.value = true;
    await TimeKeepingProvider().ManagerTimeKeeping(fromAcceptedList.value, toAcceptedList.value,"chap_thuan", pageIndexAcceptedList).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        AcceptedList.clear();
        for(var element in resp.body['data']['data']){
          AcceptedList.add( new TimeKeepingModel.fromJson(element));
        }
      }
      lengthAcceptedList.value = AcceptedList.length;
    });
    idLoadAcceptedList.value = false;
  }
  Future<void> GetAcceptedListLoadMore()async{
    pageIndexAcceptedList++;
    await TimeKeepingProvider().ManagerTimeKeeping(fromAcceptedList.value, toAcceptedList.value,"chap_thuan", pageIndexAcceptedList).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        AcceptedList.clear();
        for(var element in resp.body['data']['data']){
          AcceptedList.add( new TimeKeepingModel.fromJson(element));
        }
      }
    });
  }
  void onRefreshAccepted() async{
    await GetAcceptedList();
    refreshControllerAccepted.refreshCompleted();
  }
  void onLoadMoreAccepted() async{
    await GetAcceptedListLoadMore();
    refreshControllerAccepted.loadComplete();
  }


  // -------- REFUSE ACCEPT ---------------
  Future<void> GetRefuseAcceptList()async{
    pageIndexRefuseAcceptList = 1;
    idLoadRefuseAcceptList.value = true;
    await TimeKeepingProvider().ManagerTimeKeeping(fromRefuseAcceptList.value, toRefuseAcceptList.value,"tu_choi", pageIndexRefuseAcceptList).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        RefuseAcceptList.clear();
        for(var element in resp.body['data']['data']){
          RefuseAcceptList.add( new TimeKeepingModel.fromJson(element));
        }
      }
      lengthRefuseAcceptList.value = RefuseAcceptList.length;
    });
    idLoadRefuseAcceptList.value = false;
  }
  Future<void> GetRefuseAcceptListLoadMore()async{
    pageIndexRefuseAcceptList++;
    await TimeKeepingProvider().ManagerTimeKeeping(fromRefuseAcceptList.value, toRefuseAcceptList.value,"tu_choi", pageIndexRefuseAcceptList).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        RefuseAcceptList.clear();
        for(var element in resp.body['data']['data']){
          RefuseAcceptList.add( new TimeKeepingModel.fromJson(element));
        }
      }
    });
  }
  void onRefreshRefuseAccept() async{
    await GetRefuseAcceptList();
    refreshControllerRefuseAccept.refreshCompleted();
  }
  void onLoadMoreRefuseAccept() async{
    await GetRefuseAcceptListLoadMore();
    refreshControllerRefuseAccept.loadComplete();
  }

}
