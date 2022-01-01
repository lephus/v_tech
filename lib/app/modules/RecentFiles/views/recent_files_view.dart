import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/hepper.dart';
import 'package:v_tech/app/modules/RecentFiles/NotifyModel.dart';

import '../controllers/recent_files_controller.dart';

class RecentFilesView extends GetView<RecentFilesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông Báo"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(()=>
              controller.isLoading.value ?
              Center(child: CircularProgressIndicator()) :
              Scrollbar(child:
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notifyList.length,
                  itemBuilder: (context, index) {
                    NotifyModel item = controller.notifyList[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.arrow_right,
                          color: Colors.deepPurple,
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${getTimeWithText('${item.createdDate!.year}-${item.createdDate!.month}-${item.createdDate!.day}T00:00:48.2229326')}',
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text('${item.ten}', style: TextStyle(fontWeight: FontWeight.w400),),
                          ],
                        ),
                        subtitle: Text('${item.noiDung}'),
                      ),
                    );
                  }),
              )
              )
            ],
          ),
        ),
      )
    );
  }
}
