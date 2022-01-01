import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:v_tech/app/modules/TimeKeeping/controllers/time_keeping_controller.dart';
import 'package:v_tech/app/modules/TimeKeeping/views/refuse_accept_view.dart';

import 'accepted_view.dart';
import 'await_accept_view.dart';

class ManageTimeKeeping  extends GetView<TimeKeepingController>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: controller.myTabs.length,
        child: Scaffold(
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              title: Text('QUẢN LÝ YÊU CẦU'),
              centerTitle: true,
              bottom: TabBar(
                tabs:controller.myTabs,
              ),
            ),
            body: TabBarView(
              children: controller.myTabs.map((Tab tab) {
                final String? label = tab.text;
                if(label == "CHỜ DUYỆT"){
                  return AwaitAcceptView();
                }
                if(label == "CHẤP THUẬN"){
                  return AcceptedView();
                }
                return RefuseAcceptView();
              }).toList(),
            )
        ));
  }
}