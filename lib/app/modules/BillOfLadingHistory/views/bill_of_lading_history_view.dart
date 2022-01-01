import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/BillOfLadingHistory/BillOfLadingHistoryModel.dart';

import '../controllers/bill_of_lading_history_controller.dart';

class BillOfLadingHistoryView extends GetView<BillOfLadingHistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử vận đơn'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){displayFillTer(context);}, icon: Icon(Icons.filter_list_alt)),
        ],
      ),
      body: SafeArea(
        child:Center(
          child:  Obx(()=>
          controller.isLoadBillOfLadingHistory.value ?
          CircularProgressIndicator():
          controller.listBillOfLadingHistory.length == 0 ?
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
                itemCount: controller.listBillOfLadingHistory.length,
                itemBuilder: (context, index) {
                  BillOfLadingHistoryModel item = controller.listBillOfLadingHistory[index];
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
                                  Row(
                                    children: [
                                      Text("Số KM: "),
                                      Text(
                                        '${item.soKm}',
                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              // Name
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.person, color: Colors.grey,)),
                                      Container(
                                        width: Get.width/2,
                                        child: Text('${item.nguoiTaoDon}', overflow: TextOverflow.ellipsis,),
                                      )
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              controller.setDataEdit(
                                                '${item.createdDate!.day}-${item.createdDate!.month}-${item.createdDate!.year}',
                                                '${item.soKm}',
                                                '${item.ghiChu}'
                                              );
                                              addBillOfLadingHistory(context, item.id, "${item.id}");
                                            },
                                            icon: Icon(Icons.edit, color: Colors.deepPurple,)
                                        ),
                                        IconButton(
                                            onPressed: (){
                                              showConfirmDelete(context, item.id);
                                            },
                                            icon: Icon(Icons.delete, color: Colors.red,)
                                        ),
                                      ]
                                  ),

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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.refreshDataEdit();
          addBillOfLadingHistory(context, 0, "");
        },
        label: Text('Thêm', style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add),
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
              ? controller.from.value = getDateFilter(date)
              : controller.to.value = getDateFilter(date.add(Duration(days: 1)));
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
                    Obx(()=>Text('${controller.from}')),
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
              onTap: () => controller.from == 'Ngày bắt đầu' ||
                  controller.from == ''
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
                    Obx(()=>Text('${controller.to}',
                      style: TextStyle(
                          color: controller.from == 'Ngày bắt đầu' ||
                              controller.from == ''
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

  Widget _buildDateEdit(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 13,
            child: GestureDetector(
              onTap: () =>  DatePicker.showDatePicker(context,
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
                  }, onConfirm: (date) async{
                     controller.dateBillOfLadingHistory.value = getDateFilter(date);
                  },
                  currentTime: DateTime.now()),
              child: Container(
                height: 36.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black87, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Row(
                  children: <Widget>[
                    Obx(()=>Text('${controller.dateBillOfLadingHistory.value}',
                      style: TextStyle(
                          color: Colors.black),
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
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: TextField(
                        onChanged: (value){
                        },
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.tenNguoiTao,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add),
                            hintText: 'Tên người tạo',
                            hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: CustomColor.minHandEndColor)
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: TextField(
                        onChanged: (value){
                        },
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.tenKhachHang,
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
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LỌC DỮ LIỆU',
                        style: TextStyle(
                            color: CustomColor.titleTextColorBlue),),
                      onPressed: () async {
                        await controller.GetBillOfLadingHistory();
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

  void addBillOfLadingHistory(BuildContext context, var id, String title){
    String t = "Tạo mới lịch sử vận đơn";
    if(title == ""){
      t = "Sửa lịch sử vận đơn ${title}";
    }
    Get.dialog(
      Scaffold(
        appBar: AppBar(
          title: Text('${t}'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildDateEdit(context),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    onChanged: (value){
                    },
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    controller: controller.InputNumberKM,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.rowing),
                        hintText: 'Nhập số km',
                        hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CustomColor.minHandEndColor)
                        )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    onChanged: (value){
                    },
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: controller.InputNote,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Nhập ghi chú....',
                        hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CustomColor.minHandEndColor)
                        )
                    ),
                  ),
                ),
                SizedBox(height: 24.0,),
                Container(
                    width: ScreenSize.width,
                    margin: const EdgeInsets.symmetric(horizontal: 32.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: new LinearGradient(
                        colors: GradientColors.sea,
                        begin: FractionalOffset.centerRight,
                        end: FractionalOffset.centerLeft,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child:Text('LƯU', style: TextStyle(color: CustomColor.titleTextColorWhite),),
                      onPressed: ()async{
                        Get.back();
                        await controller.EditBillOfLadingHistory(id);
                      },
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmDelete(BuildContext context, var id){
    Widget cancelButton = TextButton(
      child: Text("Quay lại"),
      onPressed:  () {Get.back();},
    );
    Widget continueButton = TextButton(
      child: Text("Xóa"),
      onPressed:  () async{Get.back(); await controller.DeleteBillOfLadingHistory(id);},
    );
    AlertDialog alert = AlertDialog(
      title: Text("Xóa lịch sử vận đơn?"),
      content: Text("Bạn chắn chắn muốn xóa lịch sử vận đơn có ID: ${id}"),
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
