import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/Customer/HistoryOrderModel.dart';

import '../CustomerModel.dart';
import '../controllers/customer_controller.dart';

// ignore: must_be_immutable
class CustomerView extends GetView<CustomerController> {
  // ignore: unused_local_variable
  Future<void>? launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Khách hàng'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()async{await controller.GetListCustomerData();}, icon: Icon(Icons.repeat))
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: controller.textControllerSearch,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Tên, sđt, key...',
                        hintStyle: TextStyle(
                            fontSize: 12.0, color: CustomColor.pageDarkBackgroundColor),
                        contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CustomColor.subTextColorBlue)
                        )
                    ),
                  )
              ),
              Expanded(
                flex: 2,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async{
                      controller.totalRecords.value = 0;
                      controller.listCustomerModel.clear();
                      await controller.GetListCustomerDataLoadMore(1);
                    },
                    child:Text('Lọc dữ liệu', style: TextStyle(color: Colors.blue),)
                  ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal:  16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 4,
                    child: Text('Quá giới hạn công nợ:', style: TextStyle(color: Colors.black),)
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        controller.OnChangeQuaCongNo();
                      },
                      child:Obx(()=>Text('${controller.quaGioiHanCongNo.value}', style: TextStyle(color: Colors.blue),))
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                  alignment: Alignment.centerLeft,
                  child: Obx(()=> Text('${controller.totalRecords.value} khách hàng',
                      style: Theme.of(context).textTheme.bodyText2))
              ),
            ],
          ),
          Expanded(
              child: Obx(()=> controller.isLoadingListCustomerModel.value ?
                Center(
                  child: CircularProgressIndicator(),
                ) :
                Scrollbar(child: RefreshingView(
                  controller: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoadmore: controller.onLoadMore,
                  child:
                  ListView.builder(
                      reverse: controller.reverse,
                      shrinkWrap: true,
                      itemCount: controller.listCustomerModel.length,
                      itemBuilder: (context, index) {
                        CustomerModel item = controller.listCustomerModel[index];
                        return StickyHeader(
                          header:
                          Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                          content: InkWell(
                            onTap: ()async{
                              controller.ID_DETAIL = item.id!;
                              await controller.GetDetailOrderData(item.id);
                              ShowBottomSheetHistoryOrder(context, item);
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
                                        Text(
                                          'ID: ${item.id}',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          '${item.tenLoaiKhachHang}',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                    // Name
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){},
                                                icon: Icon(Icons.person, color: Colors.blue,)),
                                            Container(
                                              width: Get.width/2-20,
                                              child: Text('${item.tenDayDu}',  overflow: TextOverflow.ellipsis,),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('${item.soDienThoai}', style: TextStyle(color: Colors.blue),),
                                            IconButton(
                                                onPressed: (){
                                                  launched = _makePhoneCall('tel:${item.soDienThoai}');
                                                },
                                                icon: Icon(Icons.phone, color: Colors.blue,))
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          ' Số lần mua: ${item.soLanMua}',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(width: 16.0,),
                                        Text('GH C.Nợ: ${convertMoney(item.gioiHanCongNo ?? 0)}',
                                          style: TextStyle(
                                              color: Colors.grey[600],
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
                                        TextCongNo(context, item.congNo ?? 0.0 , item.gioiHanCongNo ?? 0.0)
                                      ],
                                    ),
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
    );
  }

  Widget TextCongNo(BuildContext context, double d, double GHCN){
    if(d < 0.0){
      return Text(
          'Công nợ: ${convertMoney((d))}',
          style: TextStyle(color: Colors.blue),
          textAlign: TextAlign.center,
        );
    }if(d > GHCN){
      return Text(
        'Công nợ: ${convertMoney((d))}',
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      );
    }
    return Text(
      'Công nợ: ${convertMoney((d))}',
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  void ShowBottomSheetHistoryOrder(BuildContext context, CustomerModel customerModel){
    Get.dialog(
       Scaffold(
         appBar: AppBar(
           title: Text("${customerModel.tenDayDu}"),
         ),
         body:  SafeArea(
           child:Column(
             children: [
               Row(
                 children: <Widget>[
                   Expanded(
                       flex: 1,
                       child: _buildStartDate(context)
                   ),
                   Expanded(
                       flex: 1,
                       child: _buildEndDate(context)
                   ),
                   Expanded(
                     flex: 0,
                       child: IconButton(
                         onPressed: ()async{
                           await controller.GetDetailOrderData(controller.ID_DETAIL);
                         },
                         icon: Icon(Icons.search),
                       )
                   )
                 ],
               ),
                Expanded(
                    child: Obx(()=>
                    controller.isLoadingDetailCustomerOrder.value ?
                    Center(
                      child: CircularProgressIndicator(),
                    ) :
                    controller.listOrder.length == 0 ?
                    Center(
                      child: Text("Không có dữ liệu"),
                    ):
                    Scrollbar(
                        child: RefreshingView(
                          controller: controller.refreshControllerDetail,
                          onRefresh: controller.onRefreshHistoryOrder,
                          onLoadmore: controller.onLoadMoreHistoryOrder,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.listOrder.length,
                              itemBuilder: (context, index) {
                                HistoryOrderModel item = controller.listOrder[index];
                                return StickyHeader(
                                  header:
                                  Container(
                                    width: 0.0,
                                    height: 0.0,
                                  ),
                                  content: InkWell(
                                    onTap: (){},
                                    child: Card(
                                      elevation: 3.0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'ID: ${item.id}',
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                  '${item.createdDate!.day}-${item.createdDate!.month}-${item.createdDate!.year} ${item.createdDate!.hour}:${item.createdDate!.minute}',
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                              ],
                                            ),
                                            // Name
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: (){},
                                                        icon: Icon(Icons.label_important, color: Colors.blue,)),
                                                    Text('${convertMoney(item.tongTienHoaDon!)}'),

                                                  ],
                                                ),
                                                Text(
                                                  '${controller.getStatus(item.trangThai!)}',
                                                  style: TextStyle(
                                                    color: Colors.blue,),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Cửa hàng: ${item.cuaHangInfo!.ten}',
                                                  style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontStyle: FontStyle.italic
                                                  ),
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
                                                Container(
                                                  width: Get.width-50,
                                                  child: Text(
                                                    'Ghi chú: ${item.ghiChuKhachHang}',
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            ListView.builder(
                                                physics: ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: item.chiTiet!.length,
                                                itemBuilder: (context, i){
                                                  ChiTiet chiTiet = item.chiTiet![i];
                                                  return ListTile(
                                                    trailing:
                                                    chiTiet.album!.length == 0 ?
                                                    IconButton(
                                                      onPressed: (){},
                                                      icon: Icon(Icons.image, color: Colors.grey,),
                                                    ):
                                                    IconButton(
                                                      onPressed: (){
                                                        ShowImageAlbum(chiTiet.album!);
                                                      },
                                                      icon: Icon(Icons.image, color: Colors.blue,),
                                                    ),
                                                    leading: Icon(Icons.account_balance_wallet_outlined, color: Colors.blue,),
                                                    title: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: Get.width/3,
                                                          child: Text('${chiTiet.tenSanPham}',
                                                            maxLines: 2,
                                                            softWrap: true,
                                                            overflow: TextOverflow.ellipsis,),
                                                        ),
                                                        Text('SL: ${chiTiet.soLuong}'),
                                                      ],
                                                    ),
                                                    subtitle: Text('Giá: ${convertMoney(chiTiet.gia ?? 0.0)}'),
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                    )
                  )
                )
             ],
           )
         )
       )
    );
  }

  Widget _buildStartDate(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
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
      margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
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
                alignment: Alignment.center,
                height: 36.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
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
        onChanged: (date) {
          controller.dateIsUpdate.value ? controller.dateIsUpdate.value = false : controller.dateIsUpdate.value = true;
        }, onConfirm: (date) async{
          controller.dateIsUpdate.value ? controller.dateIsUpdate.value = false : controller.dateIsUpdate.value = true;
          isStart
              ? controller.startDate = getDateFilter(date)
              : controller.endDate = getDateFilter(date);
        }, currentTime: DateTime.now());
  }

  void ShowImageAlbum(List<dynamic> imageList) {
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
                            Image.network(e["url"],
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
}
