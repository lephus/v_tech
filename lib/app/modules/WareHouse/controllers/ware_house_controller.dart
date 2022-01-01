import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:v_tech/app/models/StoreModel.dart';
import 'package:v_tech/app/modules/WareHouse/BillOrderModel.dart';
import 'package:v_tech/app/modules/WareHouse/DetailBillOrderModel.dart';
import 'package:v_tech/app/modules/WareHouse/DetailTransferModel.dart';
import 'package:v_tech/app/modules/WareHouse/ImportAndExportProductModel.dart';
import 'package:v_tech/app/modules/WareHouse/ProductAreComingModel.dart';
import 'package:v_tech/app/modules/WareHouse/TransferModel.dart';
import 'package:v_tech/app/modules/WareHouse/providers/ware_house_provider.dart';
import 'package:v_tech/app/modules/permissions/controllers/permissions_controller.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

class WareHouseController extends GetxController {
  List<Tab> myTabs = <Tab>[];
  PermissionsController permissionsController = new PermissionsController();

  RxList listTransfer = [].obs;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  var now = DateTime.now();

  var startDate = "".obs;
  var endDate = "".obs;
  var pageIndex = 1;
  var isLoadTransfer = false.obs;
  var totalRecords = 0.obs;

  // PRODUCT ARE COMING
  var productAreComing;
  ScrollController scrollControllerProductAreComing = ScrollController();
  RefreshController refreshControllerProductAreComing = RefreshController(initialRefresh: false);
  var startDateProductAreComing = "".obs;
  var endDateProductAreComing = "".obs;
  var pageIndexProductAreComing = 1;
  var isLoadProductAreComing = false.obs;
  var trangThaiPhieu = false.obs;
  var totalRecordsProductAreComing = 0.obs;
  List<String> menuTrangThaiPhieu = ['Chưa hoàn thành', "Hoàn thành"];
  var menuTrangThaiPhieuSelect = 0.obs;
  TextEditingController textControllerInputProduct = new TextEditingController();
  RxList dataProductAreComing = [].obs;

  // FILLTER TRANSFER
  RxList checkTransfer = [].obs;
  var detailTransferModel;
  List<String> menuCuaHangXuat = ['Cửa hàng xuất'];
  List<String> menuCuaHangNhap = ['Cửa hàng nhập'];
  List<String> trangThaiDuyet = ['Trạng thái duyệt', 'Đã duyệt', 'Chưa chuyệt'];
  List<String> trangThaiNhap = ['Chưa xác nhận', 'Đã xác nhận'];
  List<CuaHangModel> cuaHangList = [];
  var isLoadingMenuCuaHang = false.obs;
  var isLoadingDetailTransfer = false.obs;
  var cuaHangXuatSelected = 0.obs;
  var cuaHangNhapSelected = 0.obs;
  var trangThaiDuyetSelected = 1.obs;
  var trangThaiNhapSelected = 0.obs;

  // ------------------ UPLOAD IMAGE -----------------
  var selectedImagePart = ''.obs;
  var selectedImageSize = ''.obs;

  //crop code
  var cropImagePart = "".obs;
  var cropImageSize = "".obs;

  // compress code
  var compressImagePart = "".obs;
  var compressImageSize = "".obs;

  // IMPORT AND EXPORT PRODUCT
  var isLoadImportExportProduct = true.obs;
  var startDateImportExportProduct = "".obs;
  var endDateImportExportProduct = "".obs;
  var pageIndexImportExportProduct = 1;
  var totalRecordsImportExportProduct = 0.obs;
  RxList listImportExportProduct = [].obs;
  ScrollController scrollControllerImportExportProduct = ScrollController();
  RefreshController refreshControllerImportExportProduct = RefreshController(initialRefresh: false);
  List<String> ListLoaiPhieu = ['Loại phiếu', 'Xuất kho', 'Nhập kho', 'Trả hàng'];
  var LoaiPhieuSelected = 0.obs;
  List<String> ListDoiTuong = ['Loại đối tượng', 'Nhà cung cấp', 'Khách hàng', 'Hủy', 'Khác', 'Chuyển kho'];
  var LoaiDoiTuongSelected = 0.obs;
  TextEditingController textControllerNameCustomer = new TextEditingController();
  TextEditingController textControllerProduct = new TextEditingController();

  // ------------------ BILL ORDER PHIEU DAT HANG ------------------------
  RxList listBillOrder = [].obs;
  var isLoadingBillOrder = true.obs;
  var totalRecordsBillOrder = 0.obs;
  var startDateBillOrder = "".obs;
  var endDateBillOrder = "".obs;
  var trangThaiPhieuBillOrder = 0.obs;
  var cuaHangBillOrder= 0.obs;
  var pageIndexBillOrder = 1;
  var indexNCC = 0.obs;
  List<String> trangThaiBillOrder = ['Trạng thái phiếu', 'Đã hoàn thành', 'Chưa hoàn thành'];
  List<String> DataStringNCC = ["Tên NCC"];
  ScrollController scrollControllerBillOrder = ScrollController();
  RefreshController refreshControllerBillOrder = RefreshController(initialRefresh: false);
  var isLoadingDetailBillOrderModel = false.obs;
  var DataDetailBillOrder;
  var isLoadingAlbumImageBillOrder = false.obs;
  List<String> AlbumImageBillOrder = [];
  var selectedImagePartBillOrder = "".obs;

  Future<void> PermissionWareHouse()async{
    if(permissionsController.CheckPermissionFunction(permissionsController.CHUYEN_KHO_)){
      myTabs.add(Tab(text: 'CHUYỂN KHO', ),);
    }
    if(permissionsController.CheckPermissionFunction(permissionsController.PHIEU_DAT_HANG)){
      myTabs.add( Tab(text: 'PHIẾU ĐẶT HÀNG'));
    }
    if(permissionsController.CheckPermissionFunction(permissionsController.HANG_DANG_VE)){
      myTabs.add( Tab(text: 'HÀNG ĐANG VỀ'));
    }
    if(permissionsController.CheckPermissionFunction(permissionsController.PHIEU_XNK)){
      myTabs.add( Tab(text: 'SP XUẤT NHẬP KHO'));
    }
  }

  @override
  void onInit() async{
    var prevDay = new DateTime(now.year, now.month, now.day - 15);
    startDate.value = '${prevDay.day}-${prevDay.month}-${prevDay.year}';
    endDate.value = '${now.day+1}-${now.month}-${now.year}';

    startDateProductAreComing.value = startDate.value;
    endDateProductAreComing.value = endDate.value;

    startDateImportExportProduct.value = startDate.value;
    endDateImportExportProduct.value = endDate.value;

    startDateBillOrder.value = startDate.value;
    endDateBillOrder.value = endDate.value;

    PermissionWareHouse();
    super.onInit();
  }

  @override
  void onReady()async{
    await GetListStore();
    await GetNCC();
    await GetTransfer();
    await GetProductAreComing();
    await GetDataImportAndExportProduct();
    await GetBillOrder();
    super.onReady();
  }
  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    scrollControllerProductAreComing.dispose();
    refreshControllerProductAreComing.dispose();
    textControllerInputProduct.dispose();
    refreshControllerImportExportProduct.dispose();
    scrollControllerImportExportProduct.dispose();
    textControllerProduct.dispose();
    textControllerNameCustomer.dispose();
    refreshControllerBillOrder.dispose();
    super.dispose();
  }
  @override
  void onClose() {}

  void onRefresh() async{
    refreshController.refreshCompleted();
  }
  void onLoadMore() async{
    pageIndex++;
    await GetTransferLoadMore();
    refreshController.loadComplete();
  }


  int getDateTime(String data, int index){
    var s = data.split("-");
    return int.parse(s[index].toString());
  }

  Future<void> GetTransfer()async {
    isLoadTransfer.value = true;
    bool duyet = true;
    if(trangThaiDuyetSelected.value == 2){
      duyet = false;
    }
    var xacNhan = false;
    if(trangThaiNhapSelected.value == 1){
      xacNhan = true;
    }

    var id_CuaHangNhap = "";
    var id_CuaHangXuat = "";
    if(cuaHangNhapSelected.value > 0){
      id_CuaHangNhap = cuaHangList[cuaHangNhapSelected.value - 1].id.toString();
    }
    if(cuaHangXuatSelected.value > 0){
      id_CuaHangXuat = cuaHangList[cuaHangXuatSelected.value - 1].id.toString();
    }

    WareHouseProvider().GetTransfer(id_CuaHangNhap, id_CuaHangXuat,
        startDate.value, endDate.value, duyet, xacNhan, 1).then((resp){
        var data = resp.body["data"];
        listTransfer.clear();
        totalRecords.value = data["totalRecords"];
        if (resp.statusCode == 200 && resp.body["success"] == true) {
          for(var element in data["data"]){
            listTransfer.add(new TransferModel.fromJson(element));
          }
        }else{
          showSnackBarError("Lỗi kết nối server", resp.body["message"]);
        }
    });
    isLoadTransfer.value = false;
  }
  Future<void> GetTransferLoadMore()async {
    isLoadTransfer.value = true;
    bool duyet = true;
    if(trangThaiDuyetSelected.value == 2){
      duyet = false;
    }
    var xacNhan = false;
    if(trangThaiNhapSelected.value == 1){
      xacNhan = true;
    }
    var id_CuaHangNhap = "";
    var id_CuaHangXuat = "";
    if(cuaHangNhapSelected.value > 0){
      id_CuaHangNhap = cuaHangList[cuaHangNhapSelected.value - 1].id.toString();
    }
    if(cuaHangXuatSelected.value > 0){
      id_CuaHangXuat = cuaHangList[cuaHangXuatSelected.value - 1].id.toString();
    }
    WareHouseProvider().GetTransfer(id_CuaHangNhap, id_CuaHangXuat,
        startDate.value, endDate.value, duyet, xacNhan, pageIndex).then((resp){
      var data = resp.body["data"];
      totalRecords.value = data["totalRecords"];
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        for(var element in data["data"]){
          listTransfer.add(new TransferModel.fromJson(element));
        }
      }else{
        showSnackBarError("Lỗi kết nối server", resp.body["message"]);
      }
    });
    isLoadTransfer.value = false;
  }
  Future<void> ConfirmTransfer(var id)async {
    isLoadTransfer.value = true;
    WareHouseProvider().ConfirmTransfer(id).then((resp){
      //print(resp.body);
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        showSnackBarSuccess('Xác nhận thành công!', "");

      }else{
        showSnackBarError("Lỗi kết nối server", resp.body["message"]);
      }
    });
    isLoadTransfer.value = false;
  }
  Future<void> AccessTransfer(var id)async {
    isLoadTransfer.value = true;
    WareHouseProvider().AccessTransfer(id).then((resp){
      print(resp.body);
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        showSnackBarSuccess('Duyệt thành công!', "");
      }else{
        showSnackBarError("Lỗi kết nối server", resp.body["message"]);
      }
    });
    isLoadTransfer.value = false;
  }



  Future<void> GetListStore()async{
    isLoadingMenuCuaHang.value = true;
    WareHouseProvider().GetListStore().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        for(var element in resp.body["data"]["data"]){
          cuaHangList.add( CuaHangModel.fromJson(element));
          menuCuaHangNhap.add(element['ten']);
          menuCuaHangXuat.add(element['ten']);
        }
      }else{
        showSnackBarError("Đã Xảy Ra Lỗi", "${resp.body["message"]}");
      }
      isLoadingMenuCuaHang.value = false;
    });
  }
  Future<void> GetDetailTransfer(id)async{
    isLoadingDetailTransfer.value = true;
    WareHouseProvider().GetDetailTransfer(id).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        detailTransferModel = new DetailTransferModel.fromJson(resp.body["data"]);
        isLoadingDetailTransfer.value = false;
      }else{
        showSnackBarError("Đã Xảy Ra Lỗi", "${resp.body["message"]}");
        isLoadingDetailTransfer.value = false;
      }
    });
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
    await WareHouseProvider().UploadImage(file, id);
    await Future.delayed(Duration(milliseconds: 1000));
    await GetTransfer();
    Get.back();
    Get.snackbar("Thàng công", "Đang tải ảnh lên server...",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white
    );
  }




  // PRODUCT ARE COMING
void onRefreshProductAreComing() async{
    await GetProductAreComing();
  refreshControllerProductAreComing.refreshCompleted();
}
void onLoadMoreProductAreComing() async{
  pageIndexProductAreComing++;
  await GetProductAreComingLoadMore();
  refreshControllerProductAreComing.loadComplete();
}
Future<void> GetProductAreComing()async{
  isLoadProductAreComing.value = true;
  pageIndexProductAreComing = 1;
  WareHouseProvider().GetProductAreComing
    (textControllerInputProduct.text, startDateProductAreComing.value, endDateProductAreComing.value
      , trangThaiPhieu.value, pageIndexProductAreComing).then((resp){
        if (resp.statusCode == 200 && resp.body["success"] == true) {
          dataProductAreComing.clear();
          productAreComing =  ProductAreComingModel.fromJson(resp.body["data"]);
          totalRecordsProductAreComing.value = productAreComing.totalRecords;
          dataProductAreComing.addAll(productAreComing.data);
          isLoadProductAreComing.value = false;
        }else{
          showSnackBarError("Lỗi kết nối server", resp.body["message"]);
        }
  });
}
Future<void> GetProductAreComingLoadMore()async{
  print(textControllerInputProduct.text);
  WareHouseProvider().GetProductAreComing
    (textControllerInputProduct.text, startDateProductAreComing.value, endDateProductAreComing.value
      , trangThaiPhieu.value, pageIndexProductAreComing).then((resp){
    if (resp.statusCode == 200 && resp.body["success"] == true) {
      productAreComing =  ProductAreComingModel.fromJson(resp.body["data"]);
      dataProductAreComing.addAll(productAreComing.data);
      print(productAreComing.data.length);
    }else{
      showSnackBarError("Lỗi kết nối server", resp.body["message"]);
    }
  });
}

  // IMPORT AND EXPORT PRODUCT
Future<void> GetDataImportAndExportProduct()async{
    isLoadImportExportProduct.value = true;
    pageIndexImportExportProduct = 1;
    await WareHouseProvider().GetImportAndExportProduct(getNameLoaiPhieu(), startDateImportExportProduct.value, endDateImportExportProduct.value, textControllerProduct.text, pageIndexImportExportProduct, textControllerNameCustomer.text, getNameDoiTuong()).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        listImportExportProduct.clear();
        var data = resp.body['data'];
        totalRecordsImportExportProduct.value = data['totalRecords'];
        List tmp = data['data'];
        for(int i = 0; i<tmp.length; i++){
          listImportExportProduct.add(new ImportAndExportProductModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi kết nối server", resp.body["message"]);
      }
      isLoadImportExportProduct.value = false;
    });
}
Future<void> GetDataImportAndExportProductLoadMore()async{
    await WareHouseProvider().GetImportAndExportProduct(getNameLoaiPhieu(), startDateImportExportProduct.value, endDateImportExportProduct.value, textControllerProduct.text, pageIndexImportExportProduct, textControllerNameCustomer.text, getNameDoiTuong()).then((resp){
      if(resp.statusCode == 200 && resp.body['success'] == true){
        var data = resp.body['data'];
        totalRecordsImportExportProduct.value = data['totalRecords'];
        List tmp = data['data'];
        for(int i = 0; i<tmp.length; i++){
          listImportExportProduct.add(new ImportAndExportProductModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi kết nối server", resp.body["message"]);
      }
    });
  }
String getNameDoiTuong(){
    //'Loại đối tượng', 'Nhà cung cấp', 'Khách hàng', 'Hủy', 'Khác', 'Chuyển kho'
    if(LoaiDoiTuongSelected.value == 0){
      return "";
    }
    if(LoaiDoiTuongSelected.value == 1){
      return "nha_cung_cap";
    }
    if(LoaiDoiTuongSelected.value == 2){
      return "khach_hang";
    }
    if(LoaiDoiTuongSelected.value == 3){
      return "huy";
    }
    if(LoaiDoiTuongSelected.value == 4){
      return "khac";
    }
    return "chuyen_kho";
}
String getNameLoaiPhieu(){
    if(LoaiPhieuSelected.value == 0){
      return "";
    }
    return ListLoaiPhieu[LoaiPhieuSelected.value];
  }


  void onRefreshImportExportProduct() async{
    refreshControllerImportExportProduct.refreshCompleted();
  }
  void onLoadMoreImportExportProduct() async{
    pageIndexImportExportProduct++;
    await GetDataImportAndExportProductLoadMore();
    refreshControllerImportExportProduct.loadComplete();
  }



  // -- BILL ORDER PHIEU DAT HANG --
  Future<void> GetBillOrder() async{
    isLoadingBillOrder.value = true;
    pageIndexBillOrder = 1;
    var id_CuaHangNhap = "";
    if(cuaHangBillOrder.value > 0){
      id_CuaHangNhap = cuaHangList[cuaHangBillOrder.value - 1].id.toString();
    }
    await WareHouseProvider().GetBillOrder(startDateBillOrder.value, endDateBillOrder.value, getTrangThaiPhieuBillOrder(), pageIndexBillOrder, GetIdNCC(), id_CuaHangNhap).then((resp){
      if(resp.statusCode == 200 && resp.body["success"]){
        listBillOrder.clear();
        var data =  resp.body["data"];
        List tmp = data["data"];
        totalRecordsBillOrder.value = data["totalRecords"];
        for(int i = 0; i<tmp.length; i++){
          listBillOrder.add(new BillOrderModel.fromJson(tmp[i]));
        }
      }else{
        showSnackBarError("Lỗi lấy dữ liệu phiếu đặt hàng", "");
      }
    });
    isLoadingBillOrder.value = false;
  }
  Future<void> GetBillOrderLoadMore() async{
    var id_CuaHangNhap = "";
    if(cuaHangBillOrder.value > 0){
      id_CuaHangNhap = cuaHangList[cuaHangBillOrder.value - 1].id.toString();
    }
    await WareHouseProvider().GetBillOrder(startDateBillOrder.value, endDateBillOrder.value, getTrangThaiPhieuBillOrder(), pageIndexBillOrder, GetIdNCC(), id_CuaHangNhap).then((resp){
      if(resp.statusCode == 200 && resp.body["success"]){
        var data =  resp.body["data"];
        List tmp = data["data"];
        for(int i = 0; i<tmp.length; i++){
          listBillOrder.add(new BillOrderModel.fromJson(tmp[i]));
        }
      }
    });
  }
  Future<void> GetDetailDetailBillOrder(int id)async{
    isLoadingDetailBillOrderModel.value = true;
    await WareHouseProvider().GetDetailDetailBillOrder(id).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        DataDetailBillOrder = new DetailBillOrderModel.fromJson(resp.body["data"]);
      }else{
        showSnackBarError("Không tìm thấy dữ liệu","");
      }
    });
    isLoadingDetailBillOrderModel.value = false;
  }
  Future<void> GetAlbumImageDetailBillOrder(int id)async{
    isLoadingAlbumImageBillOrder.value = true;
    AlbumImageBillOrder.clear();
    await WareHouseProvider().GetAlbumImageBillOrder(id).then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        for(var element in resp.body["data"]){
          AlbumImageBillOrder.add(element['url']);
        }
      }
    });
    isLoadingAlbumImageBillOrder.value = false;
  }
  Future<void> GetNCC()async{
    isLoadingMenuCuaHang.value = true;
    WareHouseProvider().GetNhaCungCap().then((resp){
      if (resp.statusCode == 200 && resp.body["success"] == true) {
        for(var element in resp.body["data"]["data"]){
          DataStringNCC.add(element['ten']);
        }
      }
    });
    isLoadingMenuCuaHang.value = false;
  }
  String GetIdNCC(){
    if(indexNCC.value == 0){
      return "";
    }
    return DataStringNCC[indexNCC.value];
  }
  void onRefreshBillOrder() async{
    await GetBillOrder();
    refreshControllerBillOrder.refreshCompleted();
  }
  void onLoadMoreBillOrder() async{
    pageIndexBillOrder++;
    await GetBillOrderLoadMore();
    refreshControllerBillOrder.loadComplete();
  }
  void GetImageBillOrder(ImageSource imageSource, var id) async
  {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null)
    {
      selectedImagePartBillOrder.value = pickedFile.path;
      selectedImageSize.value = ((File(selectedImagePartBillOrder.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
      final dir = await Directory.systemTemp;
      final targetPath = dir.absolute.path + "temp.jpg";
      var compressedFile = await FlutterImageCompress.compressAndGetFile(selectedImagePartBillOrder.value, targetPath, quality: 90);
      compressImagePart.value = compressedFile!.path;
      compressImageSize.value =  ((File(compressImagePart.value)).lengthSync()/1024/1024).toStringAsFixed(2)+" Mb";
      uploadImageBillOrder(compressedFile, id);
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

  void uploadImageBillOrder(File file, var id) async{
    Get.dialog(Center(child: CircularProgressIndicator(),),
      barrierDismissible: false,
    );
    await WareHouseProvider().UploadImageBillOrder(file, id);
    await Future.delayed(Duration(milliseconds: 1000));
    Get.back();
    Get.snackbar("Thàng công", "Đang tải ảnh lên server...",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white
    );
  }


  String getTrangThaiPhieuBillOrder(){
    if(trangThaiPhieuBillOrder.value == 0){
      return "";
    }
    if(trangThaiPhieuBillOrder.value == 1){
      return "true";
    }
    return "false";
  }


  // LOG
  Future<void> SaveLog(id_ChuyenKho, id_SanPham, id_KhachHang)async{
    print('${id_ChuyenKho} ${id_SanPham} ${id_KhachHang}');
    try{
      await WareHouseProvider().SaveLog(id_ChuyenKho, id_SanPham, id_KhachHang).then((resp){
        print(resp.body);
        if(resp.statusCode != 200){
          showSnackBarError("Error save log", "${resp.body['title']}");
        }
      });
    }catch(e){
      showSnackBarError("Error save log", "ID sản phẩm is null");
    }
  }
  Future<void> DeleteLog(var id)async{
    try{
      await WareHouseProvider().DeleteLog(id).then((resp){
        print(resp.body);
        if(resp.statusCode != 200){
          showSnackBarError("Error delete log", "${resp.body['title']}");
        }
      });
    }catch(e){
      showSnackBarError("Error delete log", "Id log is null");
    }
  }

  showAlertDialog(BuildContext context, int id, var idChiTiet) {
    Widget cancelButton = TextButton(
      child: Text("Hủy"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Xác nhận"),
      onPressed:  ()async{
        await DeleteLog(id);
        Get.back();
        await GetDetailTransfer(idChiTiet);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("THÔNG BÁO !"),
      content: Text("Bạn chắc chắn muốn hủy log này?"),
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
