import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:v_tech/app/data/constants/constants.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/ListOrder/OrderModel.dart';
import 'package:v_tech/app/modules/permissions/controllers/permissions_controller.dart';
import '../TrangThaiModel.dart';
import '../controllers/list_order_controller.dart';
import 'DetailOrder.dart';

class ListOrderView extends GetView<ListOrderController> {
  final permisssionsController = new PermissionsController();
  @override
  Widget build(BuildContext context) {
       return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('Danh sách đơn hàng'),
          actions: [
            IconButton(
                onPressed: (){displayFillTer(context);},
                icon: Icon(Icons.filter_list_alt)),
          ],
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin:
                    const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                    alignment: Alignment.centerLeft,
                    child: Obx(()=>Text('${controller.totalRecord.value} đơn hàng',
                        style: Theme.of(context).textTheme.bodyText2))
                ),
                Container(
                    margin:
                    const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                    alignment: Alignment.centerLeft,
                    child:Obx(()=>controller.doneFillTer.value > 0 ?
                    Text('${controller.startDate} - ${controller.endDate}   ',
                        style: Theme.of(context).textTheme.bodyText2) :
                    Text('${controller.startDate} - ${controller.endDate}   ',
                        style: Theme.of(context).textTheme.bodyText2)
                    )
                ),
              ],
            ),
            Expanded(
              child: Obx(()=>
                controller.isLoadingListOrder.value ?
                Center(child: CircularProgressIndicator()) :
                Scrollbar(child: RefreshingView(
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoadmore: controller.onLoadMore,
                  child:
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.donHangList.length,
                      itemBuilder: (context, index) {
                        DonHangModel item = controller.donHangList[index];
                        var giaoHang = controller.convertTrangThaiGiaoHang(item.id);
                        var _ID = 0;
                        var _TT = "Trạng thái";
                        if(giaoHang != null){
                          _TT = giaoHang.trangThai.toString();
                          _ID = giaoHang.id;
                        }
                        return StickyHeader(
                          header:controller.headers.length == 0 ?
                          Container(
                            color: Colors.grey[400],
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 16.0),
                            child: Row(
                              children: <Widget>[
                                Text('Không lấy được dữ liệu'),
                                Spacer(),
                              ],
                            ),
                          ):
                          Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                          content: InkWell(
                            onTap: (){ShowDetailOrder(item, controller);},
                            child: Card(
                              elevation: 3.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '#${item.id.toString()}: (${handleCreatedDateTime(context, item.createdDate.toString())})',
                                          style: TextStyle(
                                              color: Colors.grey[400]),
                                        ),
                                        _buildStatus(context, item, controller.trangThaiList),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Giao hàng: $_ID"),
                                           _buildStatusGiaHang(context, item, _TT, _ID)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child:Text(' by: ${item.lastUpdatedByName}',style: TextStyle( color: Colors.grey[400]),),
                                    ),
                                    // Name
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            controller.role != ROLE_KH
                                                ? IconButton(
                                                onPressed: (){},
                                                icon: Icon(Icons.person, color: Colors.blue,))
                                                : Container(
                                              width: 0,
                                              height: 0,
                                            ),
                                            Container(
                                              width: Get.width/2 + 10,
                                              child: Text(
                                                item.tenKhachHang != null
                                                    ? item.tenKhachHang!
                                                    : '',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            item.album!.length == 0 ? IconButton(
                                                onPressed: (){
                                                },
                                                icon: Icon(Icons.image, color: Colors.grey[200],)):
                                            IconButton(
                                                onPressed: (){
                                                  ShowImageAlbum(context, item.album!);
                                                },
                                                icon: Icon(Icons.image, color: Colors.blue,)),
                                            IconButton(
                                                onPressed: (){UploadImage(context, item.id );},
                                                icon: Icon(Icons.upload_rounded, color: Colors.blue,))
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 50.0,
                                        ),
                                        Text(
                                          item.sdtKhachHang != null
                                              ? 'SĐT: ' +
                                              item.sdtKhachHang!
                                              : '',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(width: 16.0,),
                                        Text('SL: ${item.sanPhamDichVu!.length}',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Đã thanh toán\n${convertMoney(item.tienChuyenKhoan! + item.tienMat! + item.tienDatCoc!)}',
                                          textAlign: TextAlign.center,
                                        ),
                                        item.tongTienHoaDon! -
                                            item.tienChuyenKhoan! -
                                            item.tienMat! -
                                            item.tienDatCoc! !=
                                            0
                                            ? Text(
                                          'Nợ\n${convertMoney(item.tongTienHoaDon! - item.tienChuyenKhoan! - item.tienMat! - item.tienDatCoc!)}',
                                          textAlign: TextAlign.center,
                                        )
                                            : Container(
                                          width: 0.0,
                                          height: 0.0,
                                        ),
                                        Text(
                                          'Tổng\n${convertMoney(item.tongTienHoaDon!)}',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Ghi chú: ${item.ghiChuKhachHang}", style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),),
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
            ),
          ],
        ),
      )
    );
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
                    Obx(()=>Text('${controller.dateIsUpdate.value ? controller.startDate : controller.startDate}')),
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
                      Obx(()=>Text('${controller.dateIsUpdate.value ? controller.endDate : controller.endDate}',
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
          controller.dateIsUpdate.value ? controller.dateIsUpdate.value = false : controller.dateIsUpdate.value = true;
        }, onConfirm: (date) async{
            controller.dateIsUpdate.value ? controller.dateIsUpdate.value = false : controller.dateIsUpdate.value = true;
            isStart
                ? controller.startDate = getDateFilter(date)
                : controller.endDate = getDateFilter(date.add(Duration(days: 1)));
        }, currentTime: DateTime.now());
  }

  Widget _buildStatus(BuildContext context, DonHangModel item, List<TrangThaiModel> lst) {
    String res = "";
    for(int i = 0; i< lst.length; i++){
      if(item.trangThai == lst[i].ma){
        res = lst[i].ten!;
      }
    }
    if(permisssionsController.CheckPermissionFunction(permisssionsController.HOA_DON_UPDATE_STATUS)){
      return Flexible(
        child: OutlinedButton(
          onPressed: (){displayStatusType(item.trangThai!, item.id ?? 0);},
          style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        ),
        child: Text("${res}"),
        )
      );
    }else{
      return Text("${item.trangThai}");
    }
  }

  Widget _buildStatusGiaHang(BuildContext context, DonHangModel item, String _TT, int _ID) {
    return Flexible(
        child: OutlinedButton(
          onPressed: (){displayStatusGiaoHang(item, _ID);},
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
          ),
          child: Text(_TT),
        )
    );
  }
  void displayStatusGiaoHang(DonHangModel item, var _ID, ) {
    Get.bottomSheet(
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView.builder(
                  itemCount: controller.trangThaiGiaoHang.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Icon(
                          Icons.keyboard_arrow_right
                      ),
                      title: Text(
                          "${controller.trangThaiGiaoHang[index]}"
                      ),
                      onTap: ()async{
                        controller.updateTrangThaiGiaoHang(_ID, item.id, index);
                        Get.back();
                      },
                    );
                  }
              )
          )
      ),
    );
  }


  void displayStatusType(String ma, int id) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView.builder(
                itemCount: controller.trangThaiList.length,
                itemBuilder: (context, index){
                  if(ma == controller.trangThaiList[index].ma){
                    return ListTile(
                      leading: Icon(
                          Icons.keyboard_arrow_right,
                        color: Colors.cyanAccent[400],
                      ),
                      title: Text(
                          "${controller.trangThaiList[index].ten}",
                        style: TextStyle(fontWeight: FontWeight.bold,  color: Colors.cyanAccent[400]),
                      ),
                      onTap: (){Get.back();},
                    );
                  }
                  return ListTile(
                    leading: Icon(
                      Icons.keyboard_arrow_right
                    ),
                    title: Text(
                      "${controller.trangThaiList[index].ten}"
                    ),
                    onTap: ()async{
                        await controller.UpdateStatusOrder(id, controller.trangThaiList[index].ma);
                        Get.back();
                    },
                  );
                }
            )
           )
        ),
      );
  }

  void displayFillTer(BuildContext context) {
    Get.bottomSheet(
      Container(
          height: Get.height/2,
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
                        'TÙY CHỌN NHÂN CAO',
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
                   Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Obx(()=>
                      controller.isLoadingMenuCuaHang.value ?
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHang,
                        initPosition: controller.cuaHangSelected.value,
                        onChange: (val){
                        },
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.menuCuaHang,
                        initPosition: controller.cuaHangSelected.value,
                        onChange: (val)async{
                          controller.cuaHangSelected.value = val;
                        },
                      )),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: _buildStartDate(context)),
                        Expanded(child: _buildEndDate(context)),
                      ],
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Obx(()=>
                      controller.isLoadingTrangThai.value ?
                      ControlTypeDropDown(
                        menuList: controller.menuTrangThai,
                        initPosition: controller.indexSelectMenuTrangThai.value,
                        onChange: (val) async{

                        },
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.menuTrangThai,
                        initPosition: controller.indexSelectMenuTrangThai.value,
                        onChange: (val)async{
                          controller.indexSelectMenuTrangThai.value = val;
                        },
                      )),
                    ),
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LỌC DỮ LIỆU',
                        style: TextStyle(color: CustomColor.titleTextColorBlue),),
                      onPressed: () async{
                        controller.doneFillTer.value++;
                        await controller.GetListOrder(controller.startDate, controller.endDate);
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

  void ShowImageAlbum(BuildContext context, List<dynamic> imageList) {
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
                            Image.network(e['url'],
                              width: 1050,
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

  void ShowDetailOrder(DonHangModel item, ListOrderController controller){
    Get.bottomSheet(
        Container(
              height: Get.height,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
          ),
          color: Colors.white,
          ),
          child: Center(
            child: DetailOrder(donHangModel: item,controller: controller,),
          )
        )
    );
  }

}
