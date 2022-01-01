
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';

import '../controllers/time_keeping_controller.dart';

class TimeKeepingView extends GetView<TimeKeepingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        foregroundColor: CustomColor.TimKeepingColor,
        title: Text('Chấm công', style: TextStyle(color: CustomColor.TimKeepingColor),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.info_outline, color: CustomColor.TimKeepingColor)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.refresh, color: CustomColor.TimKeepingColor)
          )
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(()=>Card(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:  ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 36.0,
                        backgroundImage: NetworkImage("https://thumbs.gfycat.com/HastyThoseEyelashpitviper-size_restricted.gif"),
                      ),
                      title: Text("Xin chào, ${controller.userName.value}", style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('${controller.email.value}',style: TextStyle(color: Colors.grey),),
                    ),
                  )
                )),
                Obx(()=>GestureDetector(
                  onTap: ()async{
                    await controller.NextToChooseTimeKeeping();
                  },
                  child:Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child:Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                          child:  Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: controller.BoxDecorationIdPhanCa.value,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                ),
                                padding:  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.qr_code, color: Colors.white,),
                                        SizedBox(width: 16.0,),
                                        Text("${controller.statusPhanCa.value}", style: TextStyle(color: Colors.white, fontSize: 16),)
                                      ],
                                    ),
                                    Obx(()=>Text("${controller.Hour.value} : ${controller.Minute.value}", style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),))
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                child: Text("${controller.NameDivision.value}", style: TextStyle(color: controller.BoxDecorationIdPhanCa.value),),
                              )
                            ],
                          )
                      )
                  ),
                )),
                GestureDetector(
                  onTap: (){Get.toNamed('/manage-time-keeping');},
                  child:Card(
                      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child:  ListTile(
                          leading: Image.asset('assets/images/ChamCong.png'),
                          title: Text("Quản lý yêu cầu", style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0) //                 <--- border radius here
                                    ),),
                                  child: Obx(()=>Text('${controller.lengthAwaitAcceptList.value}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
                              ),
                              Container(
                                  margin: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0) //                 <--- border radius here
                                    ),),
                                  child: Obx(()=>Text('${controller.lengthAcceptedList.value}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
                              ),
                              Container(
                                  margin: const EdgeInsets.all(4.0),
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0) //                 <--- border radius here
                                    ),),
                                  child: Obx(()=>Text('${controller.lengthRefuseAcceptList.value}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed("/history-time-keeping");
                    controller.GetHistoryTimeKeeping();
                    },
                  child:Card(
                      margin: const EdgeInsets.symmetric( horizontal: 16.0),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child:  ListTile(
                            leading: Container(
                              child: Image.asset('assets/images/h.png'),
                            ),
                            title: Text("Lịch sử chấm công", style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      )
                  ),
                ),
                TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(1999),
                    lastDay: DateTime(2150)
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text("Powered by Vsofh. All rights reserved",style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
