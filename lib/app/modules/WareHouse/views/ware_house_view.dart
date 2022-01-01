import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/WareHouse/views/ImportAndExportProduct.dart';
import '../controllers/ware_house_controller.dart';
import 'BillOrder.dart';
import 'ProductAreComing.dart';
import 'Transfer.dart';

class WareHouseView extends GetView<WareHouseController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: controller.myTabs.length,
        child: Scaffold(
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              title: Text('KHO HÀNG'),
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                tabs:controller.myTabs,
              ),
            ),
            body: TabBarView(
              children: controller.myTabs.map((Tab tab) {
                final String? label = tab.text;
                if(label == "CHUYỂN KHO"){
                  return Transfer();
                }
                if(label == "HÀNG ĐANG VỀ"){
                  return ProductAreComing();
                }
                if(label == "SP XUẤT NHẬP KHO"){
                  return ImportAndExportProduct();
                }
                return BillOrder();
              }).toList(),
            )
        ));
  }
}
