import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/WareHouse/DetailTransferModel.dart';
import 'package:v_tech/app/modules/WareHouse/TransferModel.dart';
import '../controllers/ware_house_controller.dart';

class Transfer extends GetView<WareHouseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Obx(()=> controller.isLoadTransfer.value ?
                Center(
                  child: CircularProgressIndicator(),
                ) :
                    controller.listTransfer.length == 0 ?
                    Center(
                      child: Text('Không có dữ liệu'),
                    )  :
                Scrollbar(child: RefreshingView(
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoadmore: controller.onLoadMore,
                  child:
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listTransfer.length,
                      itemBuilder: (context, index) {
                        TransferModel item = controller.listTransfer[index];
                        return StickyHeader(
                          header:
                          Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                          content: InkWell(
                            onTap: ()async{
                              controller.checkTransfer.clear();
                              await controller.GetDetailTransfer(item.id);
                              await showDetailTransfer(context, item.id);
                            },
                            child: Card(
                              elevation: 3.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              'ID: ${item.id}',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              '${item.createdDate!.day}-${item.createdDate!.month}-${item.createdDate!.year}',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'SL: ${item.tongSoLuongSanPham}',
                                          style: TextStyle(
                                              color: Colors.black,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Name
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){},
                                                icon: Icon(Icons.account_balance_outlined, color: Colors.grey,)),
                                            Text('${item.tenCuaHangXuat}'),
                                          ],
                                        ),
                                        item.album!.length == 0 ? IconButton(
                                            onPressed: (){
                                            },
                                            icon: Icon(Icons.image, color: Colors.grey[200],)):
                                        IconButton(
                                            onPressed: (){
                                              ShowImageAlbum(context, item.album!);
                                            },
                                            icon: Icon(Icons.image, color: Colors.blue,)),
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: (){},
                                              icon: Icon(Icons.send, color: Colors.grey,)
                                          ),
                                          Text('${item.tenCuaHangNhap}', style: TextStyle(color: Colors.black),),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: (){
                                            UploadImage(context, item.id);
                                          },
                                          icon: Icon(Icons.upload_outlined, color: Colors.blue,)),
                                    ]
                                  ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Ngày xác nhận: ${item.ngayXacNhan != null ? item.ngayXacNhan.day.toString()+"-"+item.ngayXacNhan.month.toString()+"-"+item.ngayXacNhan.year.toString() : ""}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(width: 16.0,),
                                        item.ngayDuyet == null ?
                                        OutlinedButton(
                                          onPressed: (){showMyDialogAccessTransfer(context, item.id);},
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                          ),
                                          child: Text("DUYỆT"),
                                        ) :
                                        item.ngayXacNhan == null ?
                                        OutlinedButton(
                                          onPressed: (){showMyDialogConfirmTransfer(context, item.id);},
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                          ),
                                          child: Text("XÁC NHẬN"),
                                        ) : Container()
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Ghi chú: ${item.ghiChu ?? ""}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ))
                )
            )
          ],
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          displayFillTer(context);
      },
      label: Obx(()=>Text('${controller.totalRecords.value} Record', style: TextStyle(color: Colors.white),)),
      icon: const Icon(Icons.search),
      backgroundColor: Colors.blue,
      ),
    );
  }

  void _showDatePicker(BuildContext context, bool isStart) async {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
            backgroundColor: Colors.white,
            cancelStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.cyan),
            doneStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.cyan)),
        locale: LocaleType.vi,
        showTitleActions: true,
        maxTime: DateTime.now().add(Duration(days: 30)),
        onChanged: (date) {
        }, onConfirm: (date) async{
          isStart
              ? controller.startDate.value = getDateFilter(date)
              : controller.endDate.value = getDateFilter(date.add(Duration(days: 1)));
        }, currentTime: DateTime.now());
  }

  Widget _buildStartDate(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 13,
            child: GestureDetector(
              onTap: () => _showDatePicker(context, true),
              child: Container(
                height: 36.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black87, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Row(
                  children: <Widget>[
                    Obx(()=>Text('${controller.startDate}')),
                    Spacer(),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEndDate(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 13,
            child: GestureDetector(
              onTap: () => controller.startDate == 'Ngày bắt đầu' ||
                  controller.startDate == ''
                  ? null
                  : _showDatePicker(context, false),
              child: Container(
                height: 36.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black87, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Row(
                  children: <Widget>[
                    Obx(()=>Text('${controller.endDate}',
                      style: TextStyle(
                          color: controller.startDate == 'Ngày bắt đầu' ||
                              controller.startDate == ''
                              ? Colors.grey
                              : Colors.black),
                    )),
                    Spacer(),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialogAccessTransfer(BuildContext context, var id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DUYỆT ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn duyệt yêu cầu này không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('DUYỆT', style: TextStyle(color: Colors.blue),),
              onPressed: () async{
                await controller.AccessTransfer(id);
                await controller.GetTransfer();
                controller.isLoadTransfer.value = true;
                controller.isLoadTransfer.value = false;
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialogConfirmTransfer(BuildContext context, var id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('XÁC NHẬN'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn xác nhận yêu cầu này không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Xác nhận', style: TextStyle(color: Colors.blue),),
              onPressed: () async{
                await controller.ConfirmTransfer(id);
                await controller.GetTransfer();
                controller.isLoadTransfer.value = true;
                controller.isLoadTransfer.value = false;
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void displayFillTer(BuildContext context) {
    Get.bottomSheet(
      Container(
          height: Get.height / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: GradientText(
                        'TÙY CHỌN',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                        colors: [
                          CustomColor.minHandEndColor,
                          CustomColor.minHandStatColor,
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: _buildStartDate(context)),
                        Expanded(child: _buildEndDate(context)),
                      ],
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Obx(() =>
                      controller.isLoadingMenuCuaHang.value ?
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHangXuat,
                        initPosition: controller.cuaHangXuatSelected.value,
                        onChange: (val) {},
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHangXuat,
                        initPosition: controller.cuaHangXuatSelected.value,
                        onChange: (val) async {
                          controller.cuaHangXuatSelected.value = val;
                        },
                      )),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Obx(() =>
                      controller.isLoadingMenuCuaHang.value ?
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHangNhap,
                        initPosition: controller.cuaHangNhapSelected.value,
                        onChange: (val) {},
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHangNhap,
                        initPosition: controller.cuaHangNhapSelected.value,
                        onChange: (val) async {
                          controller.cuaHangNhapSelected.value = val;
                        },
                      )),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Obx(() =>
                      ControlTypeDropDown(
                        menuList: controller.trangThaiDuyet,
                        initPosition: controller.trangThaiDuyetSelected.value,
                        onChange: (val) async {
                          controller.trangThaiDuyetSelected.value = val;
                        },
                      )),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Obx(() =>
                      ControlTypeDropDown(
                        menuList: controller.trangThaiNhap,
                        initPosition: controller.trangThaiNhapSelected.value,
                        onChange: (val) async {
                          controller.trangThaiNhapSelected.value = val;
                        },
                      )),
                    ),
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LỌC DỮ LIỆU',
                        style: TextStyle(
                            color: CustomColor.titleTextColorBlue),),
                      onPressed: () async {
                        await controller.GetTransfer();
                        Get.back();
                      },
                    )
                  ],
                ),
              )
          )
      ),
    );
  }

  Future<void> showDetailTransfer(BuildContext context,var ID)async{
    Get.dialog(
      Scaffold(
        appBar: AppBar(
          title: Text('CHUYỂN KHO ID ${ID}'),
        ),
        body: SafeArea(
          child:  Obx(()=>
          controller.isLoadingDetailTransfer.value == true ?
            Center(child: CircularProgressIndicator(),):
          Scrollbar(
            child:
              ListView.builder(
              itemCount: controller.detailTransferModel.saveChiTietYeuCauInput!.length,
              itemBuilder: (context, index) {
                SaveChiTietYeuCauInput chiTietYeuCauInput = controller.detailTransferModel.saveChiTietYeuCauInput![index];
                return ListTile(
                  onTap: ()async{
                    await tabListTitleTransfer(context, index, chiTietYeuCauInput, ID);
                  },
                  leading: chiTietYeuCauInput.lichSuThaoTacResponse != null ?
                    Icon(Icons.check_box,color: Colors.green,):
                    Icon(Icons.check_box_outline_blank,color: Colors.blue,),
                  trailing: Text('SL: ${chiTietYeuCauInput.soLuong}'),
                  title: Text('${chiTietYeuCauInput.tenSanPham}'),
                  focusColor: Colors.grey,
                );
              }
            ),
          ),
        ),
      ))
    );
  }

  Future<void> tabListTitleTransfer(BuildContext context,int index, SaveChiTietYeuCauInput item, var ID)async{
    if(item.lichSuThaoTacResponse == null){
      await controller.SaveLog(ID, item.idSanPham, 0);
      await controller.GetDetailTransfer(ID);
    }else{
      await controller.showAlertDialog(context ,item.lichSuThaoTacResponse['id'], ID);
    }
  }

  void UploadImage(BuildContext context, var id) {
    Get.dialog(
      Container(
          height: Get.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 36),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: ScreenSize.width,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        child: Text("Quay lại", style: TextStyle(color: Colors.grey),),
                        onPressed: (){
                          Get.back();
                        }
                    ),
                  ),
                  SizedBox(
                    height: 26.0,
                  ),
                  Obx(()=>controller.selectedImagePart.value == "" ?
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/noimage.png'),
                  )
                      : Image.file(File(controller.selectedImagePart.value), width: 1050,
                    height: 350,fit: BoxFit.cover,)
                  ),
                  SizedBox(
                    height: 26.0,
                  ),
                  // ignore: deprecated_member_use
                  Container(
                    width: ScreenSize.width,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        child: Text("Camera", style: TextStyle(color: Colors.blue),),
                        onPressed: (){
                          controller.GetImage(ImageSource.camera, id);
                        }
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  // ignore: deprecated_member_use
                  Container(
                    width: ScreenSize.width,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        child: Text("Thư viện", style: TextStyle(color: Colors.blue),),
                        onPressed: (){
                          controller.GetImage(ImageSource.gallery, id);
                        }
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  void ShowImageAlbum(BuildContext context, List<Album> imageList) {
    Get.dialog(
      Container(
          padding: const EdgeInsets.only(left: 26, right: 26, top: 36),
          height: Get.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(

              children: [
                Container(
                  width: ScreenSize.width,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      child: Text("Quay lại", style: TextStyle(color: Colors.grey),),
                      onPressed: (){
                        Get.back();
                      }
                  ),
                ),
                SizedBox(
                  height: 26.0,
                ),
                Center(
                    child: imageList.length == 0 ?
                    Image.network('https://cdn.dribbble.com/users/252114/screenshots/3840347/mong03b.gif') :
                    CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                      ),
                      items: imageList.map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.network(e.url!,
                              width: Get.width,
                              height: 350,
                              fit: BoxFit.cover,)
                          ],
                        ) ,
                      )).toList(),
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}
