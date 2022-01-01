import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/TimeKeeping/HistoryTimeKeepingModel.dart';
import 'package:v_tech/app/modules/TimeKeeping/controllers/time_keeping_controller.dart';

class HistoryTimeKeeping extends GetView<TimeKeepingController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử chấm công"),
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
                Obx(()=>
                controller.isAdmin.value == false ?
                IconButton(
                  onPressed: (){controller.GetHistoryTimeKeeping();},
                  icon: Icon(Icons.search),
                ):Container()
                )
              ],
            ),
            Obx(()=>
            controller.isAdmin.value == true ?
            Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: TextButton(
                      onPressed: ()async{
                        await controller.GetStaff();
                        ShowSearchStaff();
                      },
                      child: Obx(()=>Text('${controller.NhanVienMenu[controller.indexNhanVien.value]}')),
                    )
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: (){controller.GetHistoryTimeKeeping();},
                      icon: Icon(Icons.search),
                    )
                ),
              ],
            ):
            Container()
            ),
            Expanded(
                child: Obx(()=>
                controller.isLoadingHistory.value ?
                Center(child: CircularProgressIndicator(),):
                controller.historyList.length == 0?
                Center(child: Text("Không có dữ liệu")):
                Scrollbar(
                  child: RefreshingView(
                      controller: controller.refreshController,
                      onRefresh: controller.onRefreshHistory,
                      onLoadmore: controller.onLoadMoreHistory,
                      child:
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.historyList.length,
                          itemBuilder: (context, index) {
                            HistoryTimeKeepingModel item = controller.historyList[index];
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
                                            Expanded(child: Container(
                                              child: Text(
                                                'ID: ${item.id!}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),),
                                            Text(
                                              '${item.createdDate!.day}-${item.createdDate!.month}-${item.createdDate!.year}',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.person, color: Colors.blueGrey,),
                                            Expanded(child: Container(
                                              child: Text(
                                                '${item.tenNhanVien!}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.timelapse, color: Colors.blue,),
                                            SizedBox(height: 16.0,),
                                            Expanded(child: Container(
                                              child: Text(
                                                'IN: ${item.thoiGianVaoStr}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),),
                                            Expanded(child: Container(
                                              child: Text(
                                                'OUT: ${item.thoiGianVeStr}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.warning_amber_rounded, color: Colors.yellow,),
                                            SizedBox(height: 16.0,),
                                            Expanded(child: Container(
                                              child: Text(
                                                'Đi muộn: ${item.thoiGianDiMuonStr}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                            ),),
                                            Expanded(child: Container(
                                              child: Text(
                                                'Về sớm: ${item.thoiGianVeSomStr}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                            ),),
                                          ],
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),
                                        Text("Tên ca: ${item.tenCa}"),
                                        SizedBox(height: 8.0,),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.timer, color: Colors.blue,),
                                            SizedBox(height: 16.0,),
                                            Expanded(
                                              child: Text(
                                                'IN: ${item.thoiGianVaoCaStr}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'OUT: ${item.thoiGianVeCaStr}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
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
                    Obx(()=>Text('${controller.from.value}')),
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
              onTap: () => controller.from.value == 'Ngày bắt đầu' ||
                  controller.from.value == ''
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
                    Obx(()=>Text('${controller.to.value}',
                      style: TextStyle(
                          color: controller.from.value == 'Ngày bắt đầu' ||
                              controller.from.value == ''
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

 void ShowSearchStaff(){
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  padding: const EdgeInsets.only(left: 32.0, top: 16.0),
                  child: TextField(
                    onChanged: (value){
                    },
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    controller: controller.textControllerUserName,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Tên đăng nhập',
                        hintStyle: TextStyle(fontSize: 13.0, color: CustomColor.pageDarkBackgroundColor),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: CustomColor.minHandEndColor)
                        )
                    ),
                  ),
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child:  IconButton(onPressed: (){
                    controller.isLoadStaff.value = true;
                    controller.isLoadStaff.value = false;
                  },
                      icon: Icon(Icons.person_search_outlined, color: Colors.blue,)
                  ),
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: showResultCustomer()
            )
          ],
        ),
      )
    );
 }

  Widget showResultCustomer(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Obx(()=>
        controller.isLoadStaff.value ?
        Center(child:CircularProgressIndicator()):
        Scrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.NhanVienMenu.length,
            itemBuilder: (context, index) {
              if(controller.textControllerUserName.text != ""){
                if(controller.NhanVienMenu[index].contains(controller.textControllerUserName.text)){
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
                              child: Text('${controller.NhanVienMenu[index]}',
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
                        controller.indexNhanVien.value = index;
                        controller.textControllerUserName.text = "";
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
                        Expanded(child: Container(
                          child: Text('${controller.NhanVienMenu[index]}',
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
                    controller.indexNhanVien.value = index;
                    controller.textControllerUserName.text = "";
                    Get.back();
                  }
              );
            },
          ),
        ))
      )
    );
  }
}