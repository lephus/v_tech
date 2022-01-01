import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/modules/Repair/views/BillRepair_view.dart';
import '../controllers/repair_controller.dart';
import 'DetailRepair_view.dart';

class RepairView extends GetView<RepairController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: controller.myTabs.length,
        child: Scaffold(
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              title: Text('PHIẾU SỬA CHỮA'),
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                tabs:controller.myTabs,
              ),
            ),
            body: TabBarView(
              children: controller.myTabs.map((Tab tab) {
                final String? label = tab.text;
                if(label == "PHIẾU SỬA CHỮA"){
                  return BillRepairView();
                }
                return DetailRepairView();
              }).toList(),
            )
        ));
  }
}
