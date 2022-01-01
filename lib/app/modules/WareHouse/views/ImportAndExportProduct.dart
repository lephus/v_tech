import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/WareHouse/controllers/ware_house_controller.dart';

import '../ImportAndExportProductModel.dart';

class ImportAndExportProduct extends GetView<WareHouseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Obx(()=> controller.isLoadImportExportProduct.value ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              controller.listImportExportProduct.length == 0 ?
              Center(
                child: Text('Không có dữ liệu'),
              )  :
              Scrollbar(child: RefreshingView(
                controller: controller.refreshControllerImportExportProduct,
                onRefresh: controller.onRefreshImportExportProduct,
                onLoadmore: controller.onLoadMoreImportExportProduct,
                child:
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listImportExportProduct.length,
                    itemBuilder: (context, index) {
                      ImportAndExportProductModel item = controller.listImportExportProduct[index];
                      return StickyHeader(
                        header:
                        Container(
                          width: 0.0,
                          height: 0.0,
                        ),
                        content: InkWell(
                          onTap: ()async{
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
                                        'SL: ${item.soLuongSanPham}',
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
                                          Text('${item.tenCuaHang}'),
                                        ],
                                      ),
                                      LOAI_PHIEU('${item.loai}'),
                                    ],
                                  ),
                                Row(
                                  children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.api_sharp, color: Colors.grey,)
                                      ),
                                      Text('${item.tenSanPham}', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tổng: ${convertMoney(item.tongTien ?? 0.0)}', style: TextStyle(color: Colors.black),),
                                      Text('Tồn Kho: ${item.tonKho}', style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Ghi chú: ${item.ghiChu}',
                                      maxLines: 5,
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
        label: Obx(()=>Text('${controller.totalRecordsImportExportProduct.value} Record', style: TextStyle(color: Colors.white),),),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }

  Widget LOAI_PHIEU(var loaiPhieu){
    if(loaiPhieu == "Xuất kho"){
      return Icon(
        Icons.arrow_forward,
        color: Colors.red,
      );
    }
    if(loaiPhieu == "Trả hàng"){
      return Icon(
        Icons.refresh_sharp,
        color: Colors.yellow[800],
      );
    }
    return Icon(
      Icons.arrow_back,
      color: Colors.green,
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
              ? controller.startDateImportExportProduct.value = getDateFilter(date)
              : controller.endDateImportExportProduct.value = getDateFilter(date.add(Duration(days: 1)));
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
                    Obx(()=>Text('${controller.startDateImportExportProduct}')),
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
              onTap: () => controller.startDateImportExportProduct == 'Ngày bắt đầu' ||
                  controller.startDateImportExportProduct == ''
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
                    Obx(()=>Text('${controller.endDateImportExportProduct}',
                      style: TextStyle(
                          color: controller.startDateImportExportProduct == 'Ngày bắt đầu' ||
                              controller.startDateImportExportProduct == ''
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
    final NameCustomerTextField = TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerNameCustomer,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Tên khách hàng',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    );
    final ProductTextField = TextField(
      onChanged: (value){
      },
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller.textControllerProduct,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.ad_units),
          hintText: 'Tên sản phẩm',
          hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: CustomColor.minHandEndColor)
          )
      ),
    );

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
                      child:Obx(()=>ControlTypeDropDown(
                          menuList: controller.ListLoaiPhieu,
                          initPosition: controller.LoaiPhieuSelected.value,
                          onChange: (val) async {
                            controller.LoaiPhieuSelected.value = val;
                          },
                      )),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child:Obx(()=>ControlTypeDropDown(
                        menuList: controller.ListDoiTuong,
                        initPosition: controller.LoaiDoiTuongSelected.value,
                        onChange: (val) async {
                          controller.LoaiDoiTuongSelected.value = val;
                        },
                      )),
                    ),
                    NameCustomerTextField,
                    SizedBox(height: 8.0,),
                    ProductTextField,
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LỌC DỮ LIỆU',
                        style: TextStyle(
                            color: CustomColor.titleTextColorBlue),),
                      onPressed: () async {
                        await controller.GetDataImportAndExportProduct();
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
}