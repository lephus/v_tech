import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/OrderAssemble/AssembleModel.dart';
import 'package:v_tech/app/modules/permissions/controllers/permissions_controller.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

import '../controllers/order_assemble_controller.dart';
import 'AddAssemble.dart';
import 'UpdateAssemble.dart';

class OrderAssembleView extends GetView<OrderAssembleController> {
  PermissionsController permissionsController = new PermissionsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng lắp ráp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child:  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: GestureDetector(
                            onTap: () {_showSelectDV(context);},
                            child: Container(
                              height: 36.0,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black87, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: Get.width/3,
                                    child: Obx(()=>Text(
                                      '${controller.tenDichVu.value}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: ()async{
                        await controller.GetDataOrderAssemble();
                      },
                      icon: Icon(Icons.search),
                    )
                ),
              ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
                  alignment: Alignment.centerLeft,
                  child:Obx(()=>Text('${controller.totalRecords.value} đơn hàng',
                      style: Theme.of(context).textTheme.bodyText2))
              )
            ],
          ),
            Expanded(
                child: Obx(()=>
                  controller.isLoading.value ?
                    Center(child: CircularProgressIndicator(),):
                    Scrollbar(
                    child: RefreshingView(
                      controller: controller.refreshController,
                      onRefresh: controller.onRefresh,
                      onLoadmore: controller.onLoadMore,
                      child:
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.assembleList.length,
                        itemBuilder: (context, index) {
                          AssembleModel item = controller.assembleList[index];
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
                                          Container(
                                            width: Get.width/2,
                                            child: Text(
                                              'NV: ${item.tenNhanVien!}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontStyle: FontStyle.italic
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                            '${item.createdDate!.day}-${item.createdDate!.month}-${item.createdDate!.year}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: Get.width/2,
                                            child: Text(
                                              'ID: ${item.id!}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontStyle: FontStyle.italic
                                              ),
                                            ),
                                          ),
                                          ButtonEdit(item.id!),
                                          ButtonDelete(context, item.id),
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
                                              Text('${convertMoney(item.tongSoTien!)}'),

                                            ],
                                          ),
                                          Text(
                                            'Tổng SL: ${item.tongSoLuong!}',
                                            style: TextStyle(
                                              color: Colors.blue,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: item.lstTenDichVu!.length,
                                          itemBuilder: (context, i){
                                            String tenDV = item.lstTenDichVu![i].tenDichVu ?? "";
                                            int slDV = item.lstTenDichVu![i].soLuong ?? 0;
                                            return ListTile(
                                              leading: Icon(Icons.account_balance_wallet_outlined, color: Colors.blue,),
                                              title: Text('$tenDV'),
                                              trailing:  Text('SL: $slDV'),
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    ),
                  )
                )
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(permissionsController.CheckPermissionFunction(permissionsController.DON_HANG_LAP_RAP_CREATE_UPDATE)) {
            controller.cleanData();
            Get.dialog(AddAssembleView());
          }else{
            showSnackBarError("Vsofh từ chối yêu cầu.", "Bạn không có quyền thêm mới!");
          }
        },
        label: const Text('Thêm'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showSelectDV(BuildContext context){
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
            child: Column(
              children: [
                GestureDetector(
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
                          Text('Tất cả', style: TextStyle(color: CustomColor.titleTextColorBlue, fontSize: SizeText.sizeTitleText),),
                        ],
                      ),
                    ),
                    onTap: ()async{
                      controller.tenDichVu.value = "Tất cả";
                      Get.back();
                    }
                ),
                Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: controller.LapRaps.length,
                      itemBuilder: (context, index) {
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
                                  Text('${controller.LapRaps[index].tenDichVu}', style: TextStyle(color: CustomColor.titleTextColorBlue, fontSize: SizeText.sizeTitleText),),
                                ],
                              ),
                            ),
                            onTap: ()async{
                              controller.tenDichVu.value = controller.LapRaps[index].tenDichVu ?? "";
                              Get.back();
                            }
                        );
                      },
                    )
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget ButtonEdit(var id){
    if(permissionsController.CheckPermissionFunction(permissionsController.DON_HANG_LAP_RAP_CREATE_UPDATE)){
      return  IconButton(
          onPressed: ()async{
            controller.cleanData();
            controller.idUpdate = id;
            await controller.GetDetailOrderAssemble(id);
            Get.dialog(UpdateAssembleView());
          },
          icon: Icon(Icons.edit, color: Colors.green)
      );
    }
    return IconButton(
        onPressed: (){},
        icon: Icon(Icons.edit, color: Colors.grey)
    );
  }

  Widget ButtonDelete(BuildContext context, var id){
    if(permissionsController.CheckPermissionFunction(permissionsController.DON_HANG_LAP_RAP_CREATE_UPDATE)){
        return  IconButton(
          onPressed: (){
            showAlertDialog(context, id);
          },
          icon: Icon(Icons.delete, color: Colors.red,)
      );
    }
    return IconButton(
        onPressed: (){},
        icon: Icon(Icons.delete, color: Colors.grey)
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
                    Obx(()=>Text('${controller.dateIsUpdate.value ? controller.from : controller.from}')),
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
              onTap: () => controller.from == 'Ngày bắt đầu' ||
                  controller.from == ''
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
                    Obx(()=>Text('${controller.dateIsUpdate.value ? controller.to : controller.to}',
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
          var d = date.day.toString();
          if(date.day < 10){
            d = "0"+d;
          }
          controller.dateIsUpdate.value ? controller.dateIsUpdate.value = false : controller.dateIsUpdate.value = true;
          isStart
              ? controller.from = '${date.year}-${date.month}-${d}'
              : controller.to = '${date.year}-${date.month}-${d}';
        }, currentTime: DateTime.now());
  }

  showAlertDialog(BuildContext context, var id) {
    Widget cancelButton = TextButton(
      child: Text("Hủy"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("XÓA"),
      onPressed:  ()async{
        Get.back();
        await controller.DeleteOrderAssemble(id);
        await controller.GetDataOrderAssemble();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("XÓA ĐƠN HÀNG ID: ${id}"),
      content: Text("Bạn chắc chắn muốn xóa đơn hàng lắp ráp này?"),
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
