import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/app/modules/MyFile/controllers/my_file_controller.dart';
import 'package:v_tech/app/modules/MyFile/views/my_file_view.dart';
import 'package:v_tech/responsive.dart';

import '../controllers/dashboard_screen_controller.dart';

class DashboardScreenView extends GetView<DashboardScreenController> {
  final myFileController = Get.lazyPut(() => MyFileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(SizeText.defaultPadding),
        child: Column(
          children: [
            SizedBox(height: SizeText.defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFileView(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: SizeText.defaultPadding),
                      //if (Responsive.isMobile(context)) StarageDetailsView(),
                      //SizedBox(height: SizeText.defaultPadding),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}
