import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/Repair/controllers/repair_controller.dart';

class SearchDetailRepair extends GetView<RepairController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tùy chọn"),
      ),
      body: Column(
        children: [
          Column(
            children: [
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
                    ControlTypeDropDown(
                      menuList: controller.LoaiYeuCauMenu,
                      initPosition: controller.indexLoaiYeuCau.value,
                      onChange: (val) async {
                        controller.indexLoaiYeuCau.value = val;
                      },
                    )),
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16),
                child: Obx(() =>
                    ControlTypeDropDown(
                      menuList: controller.TrangThaiPhieuMenu,
                      initPosition: controller.indexTrangThaiPhieu.value,
                      onChange: (val) async {
                        controller.indexTrangThaiPhieu.value = val;
                      },
                    )),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:  Container(
                      height: 60,
                      margin: const EdgeInsets.only(left: 32.0, right: 32.0),
                      child: TextField(
                        onChanged: (v){},
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.ImeiRepair,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.qr_code),
                            hintText: 'IMEI code...',
                            hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: CustomColor.minHandEndColor)
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:  Container(
                      height: 60,
                      margin: const EdgeInsets.only(left: 32.0),
                      child: TextField(
                        onChanged: (v){},
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.inputNameCustomer,
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
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          controller.showCustomerOrNCC.value = 0;
                          controller.isInputNameCustomer.value = true;
                          showResultCustomer();
                          controller.isInputNameCustomer.value = false;
                        },
                        icon: Icon(Icons.arrow_forward, color:Colors.blue),
                      )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:  Container(
                      height: 60,
                      margin: const EdgeInsets.only(left: 32.0),
                      child: TextField(
                        onChanged: (v){},
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.inputNameNCC,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.add_business_outlined),
                            hintText: 'Nhà cung cấp',
                            hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: CustomColor.minHandEndColor)
                            )
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){
                          controller.showCustomerOrNCC.value = 1;
                          controller.isInputNameNCC.value = true;
                          showResultNCC();
                          controller.isInputNameNCC.value = false;
                        },
                        icon: Icon(Icons.arrow_forward, color:Colors.blue),
                      )
                  )
                ],
              ),
            ],
          ),
          Expanded(
              child: Obx(()=>
              controller.showCustomerOrNCC.value == 0 ?
              showResultCustomer():showResultNCC()
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          if(controller.inputNameCustomer.text == ""){
            controller.indexKhachHang.value = 0;
          }
          if(controller.inputNameNCC.text == ""){
            controller.indexNCC.value = 0;
          }
          await controller.GetDetailRepair();
          Get.back();
        },
        label: const Text('Lọc dữ liệu'),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.blueGrey,
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
              ? controller.startDateRepair.value = getDateFilter(date)
              : controller.endDateRepair.value = getDateFilter(date.add(Duration(days: 1)));
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
                    Obx(()=>Text('${controller.startDateRepair}')),
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
              onTap: () => controller.startDateRepair == 'Ngày bắt đầu' ||
                  controller.startDateRepair == ''
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
                    Obx(()=>Text('${controller.endDateRepair}',
                      style: TextStyle(
                          color: controller.startDateRepair == 'Ngày bắt đầu' ||
                              controller.startDateRepair == ''
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

  Widget showResultCustomer(){
    return Container(
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
            child: Obx(()=>
            controller.isInputNameCustomer.value ?
            Center(child:CircularProgressIndicator()):
            Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.KhachHangMenu.length,
                itemBuilder: (context, index) {
                  if(controller.inputNameCustomer.text != ""){
                    if(controller.KhachHangMenu[index].contains(controller.inputNameCustomer.text)){
                      return GestureDetector(
                          child: Container(
                            decoration: new BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Icon(Icons.send, color: CustomColor.titleTextColorBlue, size: SizeText.sizeTitleText,),
                                SizedBox(width: 16.0,),
                                Expanded(child: Container(
                                  child: Text('${controller.KhachHangMenu[index]}',
                                    style: TextStyle(
                                        color: CustomColor.titleTextColorBlue,
                                        fontSize: SizeText.sizeTitleText),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          onTap: ()async{
                            controller.indexKhachHang.value = index;
                            controller.inputNameCustomer.text = controller.KhachHangMenu[index];
                          }
                      );
                    }else{
                      return GestureDetector(
                          child: Container(),
                          onTap: (){}
                      );
                    }
                  }
                  return GestureDetector(
                      child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Icon(Icons.send, color: CustomColor.titleTextColorBlue, size: SizeText.sizeTitleText,),
                            SizedBox(width: 16.0,),
                            Expanded(child: Container(
                              child: Text('${controller.KhachHangMenu[index]}',
                                style: TextStyle(
                                    color: CustomColor.titleTextColorBlue,
                                    fontSize: SizeText.sizeTitleText),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                          ],
                        ),
                      ),
                      onTap: ()async{
                        controller.indexKhachHang.value = index;
                        controller.inputNameCustomer.text = controller.KhachHangMenu[index];
                      }
                  );
                },
              ),
            ))
        )
    );
  }
  Widget showResultNCC(){
    return Container(
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
            child: Obx(()=>
            controller.isInputNameNCC.value ?
            Center(child:CircularProgressIndicator()):
            Scrollbar(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.DataStringNCC.length,
                itemBuilder: (context, index) {
                  if(controller.inputNameNCC.text != ""){
                    if(controller.DataStringNCC[index].contains(controller.inputNameNCC.text)){
                      return GestureDetector(
                          child: Container(
                            decoration: new BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: [
                                Icon(Icons.send, color: CustomColor.titleTextColorBlue, size: SizeText.sizeTitleText,),
                                SizedBox(width: 16.0,),
                                Expanded(child: Container(
                                  child: Text('${controller.DataStringNCC[index]}',
                                    style: TextStyle(
                                        color: CustomColor.titleTextColorBlue,
                                        fontSize: SizeText.sizeTitleText),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          onTap: ()async{
                            controller.indexNCC.value = index;
                            controller.inputNameNCC.text = controller.DataStringNCC[index];
                          }
                      );
                    }else{
                      return GestureDetector(
                          child: Container(),
                          onTap: (){}
                      );
                    }
                  }
                  return GestureDetector(
                      child: Container(
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Icon(Icons.send, color: CustomColor.titleTextColorBlue, size: SizeText.sizeTitleText,),
                            SizedBox(width: 16.0,),
                            Expanded(child: Container(
                              child: Text('${controller.DataStringNCC[index]}',
                                style: TextStyle(
                                    color: CustomColor.titleTextColorBlue,
                                    fontSize: SizeText.sizeTitleText),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                          ],
                        ),
                      ),
                      onTap: ()async{
                        controller.indexNCC.value = index;
                        controller.inputNameNCC.text = controller.DataStringNCC[index];
                      }
                  );
                },
              ),
            ))
        )
    );
  }
}