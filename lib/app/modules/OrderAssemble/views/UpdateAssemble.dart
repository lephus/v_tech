import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/OrderAssemble/AddInforModel.dart';
import 'package:v_tech/app/utils/showSnackBar.dart';

import '../controllers/order_assemble_controller.dart';

class UpdateAssembleView extends GetView<OrderAssembleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật đơn hàng lắp ráp'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Obx(()=>
          controller.isLoadUpdateAssemble.value ?
          Center(
              child: CircularProgressIndicator()
          ):
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: _buildSelectDate(context)
                  ),
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
                              onTap: () {_showSelectProduct(context);},
                              child: Container(
                                height: 36.0,
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black87, width: 1.0),
                                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                child: Row(
                                  children: <Widget>[
                                    Obx(()=>Container(
                                      width: Get.width/3,
                                      child: Text(
                                        '${controller.nameProduct.value}',
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
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child:  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 3.0),
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
                                    Obx(()=>Container(
                                      width: Get.width/3,
                                      child: Text(
                                        '${controller.nameDV.value}',
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
                ],
              ),
              Expanded(
                  child: Obx(()=>
                  controller.ReLoadListAdd.value ?
                  Center(child: CircularProgressIndicator(),):
                  ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: controller.AddInfors.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: (){controller.removeAdd(controller.AddInfors[index].idLapRap!);},
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                            title: Text('${controller.AddInfors[index].name}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SL: ${controller.AddInfors[index].soLuong!}'),
                                Text('${convertMoney(controller.AddInfors[index].donGia!)}'),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: (){_showUpdateQualityAssemble(context, controller.AddInfors[index], index);},
                              icon: Icon(Icons.edit, color: Colors.blue),
                            )
                        ),
                      );
                    },
                  )
                  )
              )
            ],
          ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          Get.back();
          await controller.UpdateOrderAssemble();
          await controller.GetDataOrderAssemble();
        },
        label: const Text('Cập nhật'),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }


  Widget _buildSelectDate(BuildContext context) {
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
                    Obx(()=>Text('${controller.dateIsUpdateAdd.value ? controller.SelectDate : controller.SelectDate}')),
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
          controller.dateIsUpdateAdd.value ? controller.dateIsUpdateAdd.value = false : controller.dateIsUpdateAdd.value = true;
        }, onConfirm: (date) async{
          var d = date.day.toString();
          if(date.day < 10){
            d = "0"+d;
          }
          controller.dateIsUpdateAdd.value ? controller.dateIsUpdateAdd.value = false : controller.dateIsUpdateAdd.value = true;
          controller.SelectDate = '${date.year}-${date.month}-${d}';
        }, currentTime: DateTime.now());
  }

  void _showSelectProduct(BuildContext context){
    Get.dialog(
        Scaffold(
          appBar: AppBar(
            title: Text("Chọn sản phẩm"),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextField(
                    onChanged: (v){},
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: controller.textControllerSearchProduct,
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
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child:  ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: controller.Products.length,
                      itemBuilder: (context, index) {
                        if(controller.textControllerSearchProduct.text != ""){
                          if(controller.Products[index].ten.toString().contains(controller.textControllerSearchProduct.text)){
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
                                      Text('${controller.Products[index].ten}', style: TextStyle(color: CustomColor.titleTextColorBlue, fontSize: SizeText.sizeTitleText),),
                                    ],
                                  ),
                                ),
                                onTap: ()async{
                                  controller.textControllerSearchProduct.text = "";
                                  controller.nameProduct.value = '${controller.Products[index].ten}';
                                  controller.idProduct = controller.Products[index].id ?? 0;
                                  Get.back();
                                }
                            );
                          }
                          return GestureDetector(
                              child: Container(),
                              onTap: ()async{}
                          );
                        }else{
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
                                    Text('${controller.Products[index].ten}', style: TextStyle(color: CustomColor.titleTextColorBlue, fontSize: SizeText.sizeTitleText),),
                                  ],
                                ),
                              ),
                              onTap: ()async{
                                controller.textControllerSearchProduct.text = "";
                                controller.nameProduct.value = '${controller.Products[index].ten}';
                                controller.idProduct = controller.Products[index].id ?? 0;
                                Get.back();
                              }
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void _showSelectDV(BuildContext context){
    Get.dialog(
        Scaffold(
          appBar: AppBar(
            title: Text("Chọn dịch vụ"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 32.0),
                        child: TextField(
                          onChanged: (v){},
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          controller: controller.textControllerSearchLapRap,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.all_out),
                              hintText: 'Tên dịch vụ',
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
                      flex: 2,
                      child: IconButton(
                        onPressed: (){
                          controller.isInputSearchProduct.value = true;
                          controller.isInputSearchProduct.value = false;
                        },
                        icon: Icon(Icons.search, color: Colors.blue),
                      )
                    )
                  ],
                ),
                Expanded(
                    child: Obx(()=>
                    controller.isInputSearchLapRap.value ?
                      Center(child:CircularProgressIndicator()):
                      Scrollbar(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: controller.LapRaps.length,
                        itemBuilder: (context, index) {
                          if(controller.textControllerSearchLapRap.text != ""){
                            if(controller.LapRaps[index].tenDichVu.toString().contains(controller.textControllerSearchLapRap.text)){
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
                                    controller.textControllerSearchLapRap.text = "";
                                    controller.AddIn(
                                      double.parse(controller.LapRaps[index].donGia.toString()) * int.parse(controller.textControllerNumber.text),
                                      controller.LapRaps[index].id,
                                      int.parse(controller.textControllerNumber.text),
                                      controller.LapRaps[index].tenDichVu,
                                    );
                                    controller.nameDV.value = controller.LapRaps[index].tenDichVu!;
                                    Get.back();
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
                                    Text('${controller.LapRaps[index].tenDichVu}', style: TextStyle(color: CustomColor.titleTextColorBlue, fontSize: SizeText.sizeTitleText),),
                                  ],
                                ),
                              ),
                              onTap: ()async{
                                controller.textControllerSearchLapRap.text = "";
                                controller.AddIn(
                                  double.parse(controller.LapRaps[index].donGia.toString()) * int.parse(controller.textControllerNumber.text),
                                  controller.LapRaps[index].id,
                                  int.parse(controller.textControllerNumber.text),
                                  controller.LapRaps[index].tenDichVu,
                                );
                                controller.nameDV.value = controller.LapRaps[index].tenDichVu!;
                                Get.back();
                              }
                          );
                        },
                      ),
                    ))
                )
              ],
            ),
          ),
        )
    );
  }

  void _showUpdateQualityAssemble(BuildContext context, AddInforModel data, int index){
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
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: GradientText(
                          'Cập nhật ${data.name}',
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
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        onChanged: (value){},
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        controller: controller.textControllerUpdateQualityAssemble,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.height),
                            hintText: 'Số lượng',
                            hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: CustomColor.minHandEndColor)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                child: Text(
                                  'LƯU THAY ĐỔI',
                                  style: TextStyle(color: CustomColor.titleTextColorBlue),),
                                onPressed: () async{
                                  if(controller.textControllerUpdateQualityAssemble.text == "0"|| controller.textControllerUpdateQualityAssemble.text == ""){
                                    showSnackBarError("Số lượng sai", "Số lượng phải lớn hơn 0");
                                  }else{
                                    controller.ReLoadListAdd.value = true;
                                    double cont = (controller.AddInfors[index].donGia ?? 0) / (controller.AddInfors[index].soLuong ?? 1);
                                    controller.AddInfors[index].soLuong = int.parse( controller.textControllerUpdateQualityAssemble.text);
                                    controller.AddInfors[index].donGia = cont*(controller.AddInfors[index].soLuong ?? 1);
                                    controller.textControllerUpdateQualityAssemble.text = "";
                                    Get.back();
                                    controller.ReLoadListAdd.value = false;
                                  }
                                },
                              )
                            ],
                          )
                      )
                    ],
                  ),
                ],
              )
          ),
        )
    );
  }
}
