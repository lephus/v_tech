import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/WareHouse/BillOrderModel.dart';
import 'package:v_tech/app/modules/WareHouse/DetailBillOrderModel.dart';
import 'package:v_tech/app/modules/WareHouse/controllers/ware_house_controller.dart';

class BillOrder extends GetView<WareHouseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
          child: Obx(()=>
              controller.isLoadingBillOrder.value ?
              Center(
                child: CircularProgressIndicator(),
              ):
              controller.totalRecordsBillOrder.value == 0 ?
              Center(
                child: Text("Không có dữ liệu"),
              ):
              RefreshingView(
                controller: controller.refreshControllerBillOrder,
                onRefresh: controller.onRefreshBillOrder,
                onLoadmore: controller.onLoadMoreBillOrder,
                child:
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listBillOrder.length,
                    itemBuilder: (context, index) {
                      BillOrderModel item = controller.listBillOrder[index];
                      return StickyHeader(
                        header:
                        Container(),
                        content: InkWell(
                          onTap: ()async{
                            await controller.GetDetailDetailBillOrder(item.id ?? 0);
                            ShowDetailBillOrder(context);
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
                                        '${item.soLuongSanPham} | Tổng SL: ${item.tongSoLuongSanPham}',
                                        style: TextStyle(
                                            color: Colors.black,
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
                                              icon: Icon(Icons.arrow_right, color: Colors.grey,)),
                                          Text('${item.tenCuaHang}'),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: ()async{
                                          await controller.GetAlbumImageDetailBillOrder(item.id ?? 0);
                                          ShowImageAlbum(context, controller.AlbumImageBillOrder);
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
                                                icon: Icon(Icons.account_balance_outlined, color: Colors.grey,)
                                            ),
                                            Container(
                                              width: Get.width - 160,
                                              child:Text(
                                                '${item.tenNhaCungCap}',
                                                style: TextStyle(color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            )
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: (){UploadImage(context, item.id);},
                                          icon: Icon(Icons.upload_outlined, color: Colors.blue,)),
                                      ]
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Tổng tiền: ', style: TextStyle(color: Colors.grey),),
                                        Text('${convertMoney(item.tongTien ?? 0.0)}', style: TextStyle(color: Colors.black),),
                                      ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Người lập: ', style: TextStyle(color: Colors.grey),),
                                      Text('${item.tenCreatedBy}', style: TextStyle(color: Colors.black),),
                                    ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Trạng thái duyệt:", style: TextStyle(color: Colors.grey),),
                                      Text("${item.tongSoLuongDuyet} / ${item.tongSoLuongSanPham}")
                                    ],
                                  ),
                                  Text(
                                    'Ngày xác nhận: ${item.ngayXacNhan != null ? item.ngayXacNhan!.day.toString()+"-"+item.ngayXacNhan!.month.toString()+"-"+item.ngayXacNhan!.year.toString() : ""}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic),
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
              )
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          displayFillTer(context);
        },
        label: Obx(()=>Text('${controller.totalRecordsBillOrder.value} Record', style: TextStyle(color: Colors.white),)),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.teal,
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
              ? controller.startDateBillOrder.value = getDateFilter(date)
              : controller.endDateBillOrder.value = getDateFilter(date.add(Duration(days: 1)));
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
                    Obx(()=>Text('${controller.startDateBillOrder}')),
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
              onTap: () => controller.startDateBillOrder == 'Ngày bắt đầu' ||
                  controller.startDateBillOrder == ''
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
                    Obx(()=>Text('${controller.endDateBillOrder}',
                      style: TextStyle(
                          color: controller.startDateBillOrder == 'Ngày bắt đầu' ||
                              controller.startDateBillOrder == ''
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
                        menuList: controller.DataStringNCC,
                        initPosition: controller.indexNCC.value,
                        onChange: (val) {},
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.DataStringNCC,
                        initPosition: controller.indexNCC.value,
                        onChange: (val) async {
                          controller.indexNCC.value = val;
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
                        initPosition: controller.cuaHangBillOrder.value,
                        onChange: (val) {},
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHangNhap,
                        initPosition: controller.cuaHangBillOrder.value,
                        onChange: (val) async {
                          controller.cuaHangBillOrder.value = val;
                        },
                      )),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Obx(() =>
                          ControlTypeDropDown(
                            menuList: controller.trangThaiBillOrder,
                            initPosition: controller.trangThaiPhieuBillOrder.value,
                            onChange: (val) async {
                              controller.trangThaiPhieuBillOrder.value = val;
                            },
                          )),
                    ),
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LỌC DỮ LIỆU',
                        style: TextStyle(color: CustomColor.titleTextColorBlue),),
                      onPressed: () async {
                        Get.back();
                        await controller.GetBillOrder();
                      },
                    )
                  ],
                ),
              )
          )
      ),
    );
  }

  void ShowDetailBillOrder(BuildContext context){
    Get.dialog(
      Scaffold(
        appBar: AppBar(
          title: Text("Thông tin phiếu nhập kho"),
          centerTitle: true,
        ),
        body: controller.isLoadingDetailBillOrderModel.value ?
        Center(child: CircularProgressIndicator(),):
        ListView.builder(
            itemCount: controller.DataDetailBillOrder.chiTietSanPham.length,
            itemBuilder:  (context, index) {
              ChiTietSanPham data =  controller.DataDetailBillOrder.chiTietSanPham[index];
              return Card(
                child: ListTile(
                  leading: Icon(Icons.all_inbox_rounded, color:Colors.blue),
                  title: Text("${data.tenSanPham}"),
                  subtitle: Text('${convertMoney(data.giaYeuCau)}'),
                  trailing: Text("SL: ${data.soLuong}"),
                ),
              );
            }
        )
      )
    );
  }

  void ShowImageAlbum(BuildContext context, List<String> imageList) {
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
                controller.isLoadingAlbumImageBillOrder.value ?
                Center(child: CircularProgressIndicator()):
                Center(
                    child: controller.AlbumImageBillOrder.length == 0 ?
                    Image.network('https://cdn.dribbble.com/users/252114/screenshots/3840347/mong03b.gif') :
                    CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                      ),
                      items: controller.AlbumImageBillOrder.map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.network(e,
                              width: Get.width,
                              height: 350,
                              fit: BoxFit.cover,)
                          ],
                        ) ,
                      )).toList(),
                    )
                )
              ],
            ),
          )
      ),
    );
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
                  Obx(()=>controller.selectedImagePartBillOrder.value == "" ?
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/noimage.png'),
                  )
                      : Image.file(File(controller.selectedImagePartBillOrder.value), width: 1050,
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
                          controller.GetImageBillOrder(ImageSource.camera, id);
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
                          controller.GetImageBillOrder(ImageSource.gallery, id);
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
}