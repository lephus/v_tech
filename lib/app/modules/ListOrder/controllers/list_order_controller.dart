import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/models/StoreModel.dart';
import 'package:v_tech/app/modules/ListOrder/TrangThaiModel.dart';
import 'package:v_tech/app/modules/ListOrder/providers/list_order_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/modules/ListOrder/trangThaiGiaoHangModel.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';
import '../OrderModel.dart';
import 'package:image_picker/image_picker.dart';
class ListOrderController extends GetxController {
  List<String> menuCuaHang = ['Tất cả cửa hàng'];
  List<String> trangThaiGiaoHang = ["Chưa gửi", "Đang trên đường", "Hoàn thành"];
  var isLoadingMenuCuaHang = false.obs;
  var cuaHangSelected = 0.obs;

  var now = DateTime.now();
  final box = GetStorage();
  String startDate =  'Ngày bắt đầu';
  String endDate = 'Ngày kết thúc';

  var dateIsUpdate = false.obs;
  var doneFillTer = 0.obs;
  String? role;
  var totalRecord = 0.obs;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  RxList donHangList = [].obs;
  List<TrangThaiGiaoHangModel> trangThaiGiaoHangList = [];
  List<CuaHangModel> cuaHangList = [];
  List<DonHangHeader> headers = [];

  List<String> menuTrangThai = ['Chọn trạng thái'];
  var indexSelectMenuTrangThai = 0.obs;
  List<TrangThaiModel> trangThaiList = [];
  var reverse = false;

  var pageIndex = 1;
  var isLoadingListOrder = false.obs;
  var isLoadingTrangThai = false.obs;

  // ------------------ UPLOAD IMAGE -----------------
  var selectedImagePart = ''.obs;
  var selectedImageSize = ''.obs;

  //crop code
  var cropImagePart = "".obs;
  var cropImageSize = "".obs;

  // compress code
  var compressImagePart = "".obs;
  var compressImageSize = "".obs;


  @override
  void onInit() async{
    pageIndex = 1;
    var prevDay = new DateTime(now.year, now.month, now.day-3);
    startDate = '${prevDay.day}-${prevDay.month}-${prevDay.year}';
    endDate = '${now.day+1}-${now.month}-${now.year}';
    await GetListStore();
    await GetListStatusType();
    // await GetListOrder(startDate, endDate);
    super.onInit();
  }

  @override
  void onReady() async{
    await GetListOrder(startDate, endDate);
    super.onReady();
  }
@override
  void dispose() {
    startDate = 'Ngày bắt đầu';
    endDate = 'Ngày kết thúc';
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  void onClose() {}

  Future<void> UpdateStatusOrder(var id, var ma)async{
    ListOrderProvider().UpdateStatusOrder(id, ma).then((resp) async {
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        showSnackBarSuccess("Cập nhật thành công", "");
        await GetListOrder(startDate, endDate);
      }else{
        showSnackBarError("Cập nhật thất bại", "");
      }
    });
  }

  Future<void> GetListStatusType()async{
    isLoadingTrangThai.value = true;
    ListOrderProvider().GetListStatusType().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        trangThaiList.clear();
        menuTrangThai.clear();
        menuTrangThai.add('Chọn trạng thái');
        for(var element in resp.body["data"]){
          trangThaiList.add( TrangThaiModel.fromJson(element));
          menuTrangThai.add(element['ten']);
        }
      }else{
        showSnackBarError("Đã Xảy Ra Lỗi", "${resp.body["message"]}");
      }
      isLoadingTrangThai.value = false;
    });
  }

  Future<void> GetListStore()async{
    isLoadingMenuCuaHang.value = true;
    ListOrderProvider().GetListStore().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        for(var element in resp.body["data"]["data"]){
          cuaHangList.add( CuaHangModel.fromJson(element));
          menuCuaHang.add(element['ten']);
        }
      }else{
        showSnackBarError("Đã Xảy Ra Lỗi", "${resp.body["message"]}");
      }
     isLoadingMenuCuaHang.value = false;
    });
  }

  Future<void> GetListOrder(startDate, endDate)async{
    isLoadingListOrder.value = true;
    reverse = true;
    var idStore = "";
    cuaHangSelected.value > 0 ? idStore = cuaHangList[cuaHangSelected.value - 1].id.toString() : idStore = '';
    startDate == "Ngày bắt đầu" ? startDate == "" : startDate = startDate;
    endDate == "Ngày kết thúc" ? endDate == "" : endDate = endDate;
    var status = "";
    indexSelectMenuTrangThai.value > 0 ? status = trangThaiList[indexSelectMenuTrangThai.value - 1].ma.toString() : status = '';
    await ListOrderProvider().GetListTrangThaiGiaoHang(pageIndex).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true){
        trangThaiGiaoHangList.clear();
        print(resp.body);
        for(var e in resp.body['data']['data']){
          trangThaiGiaoHangList.add(new TrangThaiGiaoHangModel.fromJson(e));
        }
      }
    });

    await ListOrderProvider().GetListOrder(idStore, startDate, endDate, 1, status).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        donHangList.clear();
        headers.clear();
        var data = resp.body["data"];
        totalRecord.value = int.parse(data["totalRecords"].toString());
        List tmp =[];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length ; i++) {
         donHangList.add(new DonHangModel.fromJson(tmp[i]));
         headers.add(new DonHangHeader( tmp[i]["createdDate"].toString() , i, false));
        }
      }else{
        showSnackBarError("Lỗi kết nối", "${resp.body["message"]}");
      }
    }).onError((error, stackTrace){
      showSnackBarError("Đã Xảy Ra Lỗi", stackTrace.toString());
    });
    isLoadingListOrder.value = false;
  }

  Future<void> LoadMoreListOrder(startDate, endDate)async{
    var idStore = "";
    cuaHangSelected.value > 0 ? idStore = cuaHangList[cuaHangSelected.value - 1].id.toString() : idStore = '';
    startDate == "Ngày bắt đầu" ? startDate == "" : startDate = startDate;
    endDate == "Ngày kết thúc" ? endDate == "" : endDate = endDate;
    var status = "";
    indexSelectMenuTrangThai.value > 0 ? status = trangThaiList[indexSelectMenuTrangThai.value - 1].ma.toString() : status = '';
    ListOrderProvider().GetListOrder(idStore, startDate, endDate, pageIndex, status).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        var data = resp.body["data"];
        totalRecord.value += int.parse(data["totalRecords"].toString());
        List tmp =[];
        tmp.addAll(data["data"]);
        for (var i = 0; i < tmp.length ; i++) {
          donHangList.add(new DonHangModel.fromJson(tmp[i]));
          headers.add(new DonHangHeader( tmp[i]["createdDate"].toString() , i, false));
        }
        //print(resp.body["data"]["data"]);
      }else{
        showSnackBarError("Lỗi kết nối", "${resp.body["message"]}");
      }
    });
    isLoadingListOrder.value = false;
  }

  dynamic convertTrangThaiGiaoHang(var idDonHang){
    for(var e in trangThaiGiaoHangList){
      if(e.idDonHang == idDonHang){
        return e;
      }
    }
    return null;
  }

  void GetImage(ImageSource imageSource, var id) async
  {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null)
    {
      selectedImagePart.value = pickedFile.path;
      selectedImageSize.value = ((File(selectedImagePart.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
       final dir = await Directory.systemTemp;
       final targetPath = dir.absolute.path + "temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(selectedImagePart.value, targetPath, quality: 90);
      compressImagePart.value = compressedFile!.path;
      compressImageSize.value =  ((File(compressImagePart.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
      uploadImage(compressedFile, id);

    }
    else
    {
      Get.snackbar("Error", "No image selected",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }

  void uploadImage(File file, var id)
   async{
    Get.dialog(Center(child: CircularProgressIndicator(),),
      barrierDismissible: false,
    );
    await ListOrderProvider().UploadImage(file, id);
    await Future.delayed(Duration(milliseconds: 1000));
    await GetListOrder(startDate, endDate);
    Get.back();
    Get.snackbar("Thàng công", "Đang tải ảnh lên server...",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white
    );
  }


  void onRefresh() async{
    pageIndex = 1;
    await GetListOrder(startDate, endDate);
    refreshController.refreshCompleted();
  }

  void onLoadMore() async{
    pageIndex ++;
    await LoadMoreListOrder(startDate, endDate);
    isLoadingListOrder.value = true;
    isLoadingListOrder.value = false;
    refreshController.loadComplete();
  }

  Future<void> updateTrangThaiGiaoHang(var id,var idHoaDon,var idTrangThai)async{
    await ListOrderProvider().updateTrangThaiGiaoHang(id, idHoaDon, idTrangThai).then((resp) => {
       if (resp.statusCode == 200 && resp.body["success"] == true){
         GetListOrder(startDate, endDate)
       }else{
          showSnackBarError("Cập nhật thất bại", "")
       }
    });
  }


  // LOG
  Future<void> SaveLog(int id_HoaDon,int id_SanPham,int id_KhachHang)async{
    try{
      await ListOrderProvider().SaveLog(id_HoaDon, id_SanPham, id_KhachHang).then((resp){
        print(resp.body);
        if(resp.statusCode != 200){
          showSnackBarError("Error save log", "${resp.body['title']}");
        }
      });
      await GetListOrder(startDate, endDate);
    }catch(e){
      showSnackBarError("Error save log", "ID sản phẩm is null");
    }
  }
  Future<void> DeleteLog(var id)async{
    try{
      await ListOrderProvider().DeleteLog(id).then((resp){
        print(resp.body);
        if(resp.statusCode != 200){
          showSnackBarError("Error delete log", "${resp.body['title']}");
        }
      });
      await GetListOrder(startDate, endDate);
    }catch(e){
      showSnackBarError("Error delete log", "Id Log is null");
    }
  }

  showAlertDialog(BuildContext context, int id_HoaDon, int id) {
    Widget cancelButton = TextButton(
      child: Text("Hủy"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Xác nhận"),
      onPressed:  ()async{
        for(var element in donHangList){
          if(element.id == id_HoaDon){
            for(var t in element.sanPhamDichVu){
              if(t.id== id){
                await DeleteLog(t.lichSuThaoTacResponse['id']);
              }
            }
            break;
          }
        }
        Get.back();
        await Future.delayed(Duration(seconds: 1));
        Get.back();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("THÔNG BÁO !"),
      content: Text("Bạn chắc chắn muốn hủy Log này?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
class DonHangHeader {
  String? date;
  int? count;
  bool? isDisplay;
  DonHangHeader(String string, int i, bool bool, {this.date, this.count, this.isDisplay});
}
