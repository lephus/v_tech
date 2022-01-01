import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import '../controllers/infor_product_controller.dart';

class InventoryProduct extends GetView<InforProductController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(()=>
                controller.isLoadingInformation.value ?
                Text(
                  'Tên SP: ',
                  style:
                  CommonStyle.strongTextBlack(context).copyWith(fontSize: 18.0),
                ):
                    Text(
                  'Tên SP: ${controller.Product!.ten ?? ""}',
                  style:
                  CommonStyle.strongTextBlack(context).copyWith(fontSize: 18.0),
                )),
                SizedBox(height: 16.0),
                Divider(
                  color: Colors.blue,
                  height: 1.0,
                ),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(flex: 6, child: Text('Tên cửa hàng', style: TextStyle(fontWeight: FontWeight.bold),)),
                    Expanded(flex: 2, child: Text('Tồn', style: TextStyle(fontWeight: FontWeight.bold, color:Colors.red),)),
                    SizedBox(width: 16.0),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Đ.Về',
                          style: TextStyle(fontWeight: FontWeight.bold, color:Colors.blue[800]),)),
                    SizedBox(width: 16.0),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'C.Kho',
                          style: TextStyle(fontWeight: FontWeight.bold, color:Colors.deepPurple),)),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Divider(
                  color: Colors.black54,
                  height: 1.0,
                ),
                Obx(()=>
                    controller.isLoadingInformation.value ?
                        Center(
                          child: CircularProgressIndicator(),
                        ) :controller.Product!.dsCuaHangTon!.isNotEmpty
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.Product!.dsCuaHangTon!.length,
                        itemBuilder: (context, index) {
                          final item = controller.Product!.dsCuaHangTon![index];
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 40.0,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(flex: 6, child: Text('${item.ten}')),
                                      Expanded(
                                          flex: 2, child: Text('${item.ton}', style: TextStyle(color: Colors.red),)),
                                      SizedBox(
                                        width: 16.0,
                                      ),
                                      Expanded(
                                          flex: 2, child: Text('${item.dangVe}', style: TextStyle(color: Colors.blue[800]),)),
                                      SizedBox(
                                        width: 16.0,
                                      ),
                                      Expanded(
                                          flex: 2, child: Text('${item.chuyenKho}', style: TextStyle(color: Colors.deepPurple),)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black54,
                                  height: 1.0,
                                )
                              ],
                            ),
                          );
                        })
                        : Container(width: 0, height: 0)
                )
              ],
            ),
          )),
    );
  }
}