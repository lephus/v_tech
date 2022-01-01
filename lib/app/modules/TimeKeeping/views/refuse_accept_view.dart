import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/modules/TimeKeeping/TimeKeepingModel.dart';
import 'package:v_tech/app/modules/TimeKeeping/controllers/time_keeping_controller.dart';

class RefuseAcceptView extends GetView<TimeKeepingController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                IconButton(onPressed: (){controller.GetRefuseAcceptList();}, icon: Icon(Icons.search))
              ],
            ),
            Expanded(
                child: Obx(()=>
                controller.idLoadRefuseAcceptList.value?
                Center(child:CircularProgressIndicator()):
                controller.RefuseAcceptList.length == 0?
                Center(child: Text("Không có dữ liệu")):
                Scrollbar(
                  child: RefreshingView(
                      controller: controller.refreshControllerRefuseAccept,
                      onRefresh: controller.onRefreshRefuseAccept,
                      onLoadmore: controller.onLoadMoreRefuseAccept,
                      child:
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.RefuseAcceptList.length,
                          itemBuilder: (context, index) {
                            TimeKeepingModel item = controller.RefuseAcceptList[index];
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
                                                'ID: ${item.idChamCong}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),),
                                            Text(
                                              'Từ chối',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.label_important, color: Colors.red,),
                                            Expanded(child: Container(
                                              child: Text(
                                                '${item.tenCaLamViec ?? ""}',
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
                                        SizedBox(height: 4.0,),
                                        Divider(
                                            color: Colors.black
                                        ),
                                        SizedBox(height: 4.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(Icons.whatshot_outlined, color: Colors.red,),
                                            SizedBox(height: 16.0,),
                                            Expanded(child: Container(
                                              child: Text(
                                                'Nghỉ GG: ${item.thoiGianNghiGgStr}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                            ),),
                                            Expanded(child: Container(
                                              child: Text(
                                                'Kết thúc : ${item.thoiGianKetThucNghiGgStr}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.deepPurple,
                                                ),
                                              ),
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Ghi chú: ${item.ghiChu}"),
                                        ),
                                        SizedBox(height: 8.0,),
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
              ? controller.fromRefuseAcceptList.value = getDateFilter(date)
              : controller.toRefuseAcceptList.value = getDateFilter(date.add(Duration(days: 1)));
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
                    Obx(()=>Text('${controller.fromRefuseAcceptList.value}')),
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
              onTap: () => controller.fromRefuseAcceptList.value == 'Ngày bắt đầu' ||
                  controller.fromRefuseAcceptList.value == ''
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
                    Obx(()=>Text('${controller.toRefuseAcceptList.value}',
                      style: TextStyle(
                          color: controller.fromRefuseAcceptList.value == 'Ngày bắt đầu' ||
                              controller.fromRefuseAcceptList.value == ''
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

}