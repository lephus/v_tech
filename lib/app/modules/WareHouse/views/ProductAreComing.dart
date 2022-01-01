import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';

import '../ProductAreComingModel.dart';
import '../controllers/ware_house_controller.dart';

class ProductAreComing extends GetView<WareHouseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Obx(()=> controller.isLoadProductAreComing.value ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              Scrollbar(child: RefreshingView(
                controller: controller.refreshControllerProductAreComing,
                onRefresh: controller.onRefreshProductAreComing,
                onLoadmore: controller.onLoadMoreProductAreComing,
                child:
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.dataProductAreComing.length,
                    itemBuilder: (context, index) {
                      Datum dataProduct = controller.dataProductAreComing[index];
                      return Card(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: ListTile(
                              leading:Text("${index+1}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
                              title: Text("${dataProduct.tenSanPham}"),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ghi chú: ${dataProduct.moTa ?? ""}",  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),),
                                ],
                              ),
                              trailing:  Text("${dataProduct.soLuongDuyet} / ${dataProduct.soLuongYeuCau}"),
                          ),
                        )
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
        label: Obx(()=>Text('${controller.totalRecordsProductAreComing.value} Record', style: TextStyle(color: Colors.white),)),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.green,
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
              ? controller.startDateProductAreComing.value = getDateFilter(date)
              : controller.endDateProductAreComing.value = getDateFilter(date.add(Duration(days: 1)));
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
                    Obx(()=>Text('${controller.startDateProductAreComing}')),
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
                    Obx(()=>Text('${controller.endDateProductAreComing}',
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
                      controller.trangThaiPhieu.value ?
                      ControlTypeDropDown(
                        menuList: controller.menuTrangThaiPhieu,
                        initPosition: controller.menuTrangThaiPhieuSelect.value,
                        onChange: (val) {
                          controller.trangThaiPhieu.value = false;
                          controller.menuTrangThaiPhieuSelect.value = 0;
                        },
                      ) :
                      ControlTypeDropDown(
                        menuList: controller.menuTrangThaiPhieu,
                        initPosition: controller.menuTrangThaiPhieuSelect.value,
                        onChange: (val) async {
                          controller.trangThaiPhieu.value = true;
                          controller.menuTrangThaiPhieuSelect.value = 1;
                        },
                      )),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: TextField(
                        onChanged: (value){
                        },
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.textControllerInputProduct,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search_off_outlined),
                            hintText: 'Tên sản phẩm',
                            hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: CustomColor.minHandEndColor)
                            )
                        ),
                      )
                    ),
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LỌC DỮ LIỆU',
                        style: TextStyle(
                            color: CustomColor.titleTextColorBlue),),
                      onPressed: () async {
                        await controller.GetProductAreComing();
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
