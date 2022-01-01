import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:v_tech/app/data/common_ui.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/modules/Repair/RepairModel.dart';
import '../controllers/repair_controller.dart';

class BillRepairView extends GetView<RepairController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Obx(()=> controller.isLoadingRepair.value ?
              Center(
                child: CircularProgressIndicator(),
              ) :
              controller.listRepair.length == 0 ?
              Center(
                child: Text('Không có dữ liệu'),
              )  :
              Scrollbar(child: RefreshingView(
                controller: controller.refreshControllerRepair,
                onRefresh: controller.onRefreshRepair,
                onLoadmore: controller.onLoadMoreRepair,
                child:
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listRepair.length,
                    itemBuilder: (context, index) {
                      RepairModel item = controller.listRepair[index];
                      return StickyHeader(
                        header:
                        Container(
                          width: 0.0,
                          height: 0.0,
                        ),
                        content: InkWell(
                          onTap: ()async{
                            await controller.GetDetailBillRepair(item.id);
                            showDetailBillRepair(context);
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
                                            '${item.createDate!.day}-${item.createDate!.month}-${item.createDate!.year}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'SL: ${item.soLuong}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Name
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.arrow_right_outlined, color: Colors.grey,)),
                                      Expanded(
                                          child: Container(
                                              child:  Text('${item.cuaHangInfo!.ten ?? ""}',
                                                overflow: TextOverflow.ellipsis,
                                              )
                                          )
                                      )
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: (){},
                                            icon: Icon(Icons.person, color: Colors.blue,)
                                        ),
                                        Expanded(
                                            child: Container(
                                                child: Text("${item.khachHangInfo == null  ? "Khách hàng" : item.khachHangInfo['ten']}",
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                            )
                                        )
                                      ]
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.add_business_outlined, color: Colors.blue,)
                                      ),
                                      Expanded(
                                          child: Container(
                                              child: Text("${item.nhaCungCapInfo == null ? "Đơn vị sửa chữa" :item.nhaCungCapInfo['ten'] }",
                                                overflow: TextOverflow.ellipsis,
                                              )
                                          )
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: (){},
                                              icon: Icon(Icons.arrow_right, color: Colors.black,)
                                          ),
                                          Text("${item.soLuongDaHoanThanh}/${item.tongSo}"),
                                        ],
                                      ),
                                      Text("${controller.convertTrangThai(item.trangThai!)}",style: TextStyle(fontWeight: FontWeight.bold),),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/search-repair');
        },
        label: Obx(()=>Text('${controller.totalRecordsRepair.value} Record', style: TextStyle(color: Colors.white),)),
        icon: const Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),
    );
  }


  void showDetailBillRepair(BuildContext context){
    Get.dialog(
      Scaffold(
        appBar: AppBar(
          title: Text("Xem chi tiết phiếu sữa chữa"),
        ),
        body: SafeArea(
          child: Obx(()=>
            controller.isLoadDetailBillRepair.value ?
              Center(child: CircularProgressIndicator()):
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.detailBillRepairData["chiTiet"].length,
                itemBuilder: (context, index){
                  var chiTiet = controller.detailBillRepairData["chiTiet"][index];
                  List chiTiet_SuaChua_DichVu = chiTiet["chiTiet_SuaChua_DichVu"];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${chiTiet['tenSanPham']}",
                            style: TextStyle(fontSize: 18, color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: chiTiet_SuaChua_DichVu.length,
                              itemBuilder: (context, index){
                                var tenDichVu = chiTiet_SuaChua_DichVu[index]['tenDichVu'];
                                var thanhTien = chiTiet_SuaChua_DichVu[index]['thanhTien'];
                                List chiTiet_SuaChua_DichVu_SanPham = chiTiet_SuaChua_DichVu[index]['chiTiet_SuaChua_DichVu_SanPham'];
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${tenDichVu}",
                                          style: TextStyle(fontSize: 16, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                                        ),
                                        Text("Thành Tiền: ${convertMoney(double.parse(thanhTien.toString()))}"),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: chiTiet_SuaChua_DichVu_SanPham.length,
                                            itemBuilder: (context, index){
                                              var endData = chiTiet_SuaChua_DichVu_SanPham[index];
                                              return Text(
                                                "->   ${endData['tenSanPham']}",
                                                style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                                              );
                                            }
                                        )
                                      ],
                                    ),
                                  )
                                );
                              }
                          )
                        ],
                      ),
                    )
                  );
                }
              )
          ),
        ),
      )
    );
  }
}
