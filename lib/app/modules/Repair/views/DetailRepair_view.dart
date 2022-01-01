import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import '../DetailRepairModel.dart';
import '../controllers/repair_controller.dart';

class DetailRepairView extends GetView<RepairController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child:Obx(()=>Scrollbar(child: RefreshingView(
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoadmore: controller.onLoadMore,
          child:
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.detailRepairs.length,
            itemBuilder: (context, index) {
              DetailRepairModel item = controller.detailRepairs[index];
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
                              Text(
                                'ID: ${item.idPhieu}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                'Loại: ${controller.convertLoai(item.loaiyeuCau!)}',
                                style: TextStyle(
                                    color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                ' ${controller.convertTrangThai(item.trangThai!)}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              IconButton(
                                  onPressed: (){ShowUpdateRepair(context, item);},
                                  icon: Icon(Icons.edit, color: Colors.blue,)
                              )

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.score, color: Colors.grey,)),
                              Expanded(
                                child: Container(
                                  child: Text('${item.tenSanPham}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,),
                                )
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.bookmarks_outlined, color: Colors.grey,)),
                              Expanded(
                                child: Container(
                                  child: Text('IMEI: ${item.imei}', overflow: TextOverflow.ellipsis,),
                                )
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                    child: Text('Tên DV: ${item.tenDichVu}', overflow: TextOverflow.ellipsis,),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    child: Text('Đ.Giá: ${convertMoney(item.donGia)}', overflow: TextOverflow.ellipsis,),
                                  )
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                    child: Text('Thành tiền: ', overflow: TextOverflow.ellipsis,),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    child: Text('${convertMoney(item.thanhTien)}', overflow: TextOverflow.ellipsis,),
                                  )
                              )
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
        )))
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/search-detail-repair');
        },
        label: Obx(()=>Text('${controller.totalRecords.value} Record', style: TextStyle(color: Colors.white),)),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  void ShowUpdateRepair(BuildContext context, DetailRepairModel data){
    controller.TextEditingControllerghiChuUpdate.text = data.ghiChu ?? "";
    controller.ConverTrangThaiToID(data.trangThai!);
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
                        'CẬP NHẬT',
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
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Obx(() =>
                          ControlTypeDropDown(
                            menuList: controller.TrangThaiPhieuMenu,
                            initPosition: controller.trangThaiUpdate.value,
                            onChange: (val) async {
                              controller.trangThaiUpdate.value = val;
                            },
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: TextField(
                        onChanged: (value){
                        },
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        controller: controller.TextEditingControllerghiChuUpdate,
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
                    SizedBox(height: 16.0,),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        'LƯU THAY ĐỔI',
                        style: TextStyle(
                            color: CustomColor.titleTextColorBlue),),
                      onPressed: () async {
                        Get.back();
                        await controller.UpdateDetailRepair(data.idSuaChua);
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
