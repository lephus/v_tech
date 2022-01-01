import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/infor_product_controller.dart';
import 'informationProduct.dart';
import 'inventoryProduct.dart';

class InforProductView extends GetView<InforProductController> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: controller.myTabs.length,
        child: Scaffold(
          backgroundColor: Colors.grey[400],
          appBar: AppBar(
            title: Text('Sản phẩm ${controller.id}'),
          centerTitle: true,
          bottom: TabBar(
              tabs:controller.myTabs,
          ),
        ),
          body: TabBarView(
            children: controller.myTabs.map((Tab tab) {
                final String? label = tab.text;
                if(label == "THÔNG TIN"){
                  return InformationProduct();
                }
                return Center(
                  child: InventoryProduct());
              }).toList(),
          )
    ));
  }
}