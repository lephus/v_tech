import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/DashboardScreen/controllers/dashboard_screen_controller.dart';
import 'package:v_tech/app/modules/DashboardScreen/views/dashboard_screen_view.dart';
import 'package:v_tech/app/modules/Slide/controllers/slide_controller.dart';
import 'package:v_tech/app/modules/Slide/views/slide_view.dart';
import 'package:v_tech/app/modules/home/components/header.dart';
import 'package:v_tech/app/modules/home/controllers/home_controller.dart';
import '../../../../responsive.dart';
class HomeView extends GetView<HomeController> {
  final slideController = Get.lazyPut(()=>SlideController());
  final dashboardScreenController = Get.lazyPut(() => DashboardScreenController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: CustomColor.colorBG,
      drawer: SlideView(),
      appBar: AppBar(
        title: Text('Vsofh'),
        actions: [
          ProfileCard(userName: '${box.read("userName")}',)
        ],
        backgroundColor: CustomColor.primaryColor,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                child: SlideView(),
              ),
            Expanded(
              flex: 5,
              child: DashboardScreenView(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isCheckNotify.value = true;
          Get.toNamed('/recent-files');
        },
        child: Obx(()=>
        controller.isCheckNotify.value == false ?
            Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.notifications_active),
                Icon(Icons.circle,size: 12, color: Colors.red,),
              ],
            ):
             Icon(Icons.notifications_active),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
